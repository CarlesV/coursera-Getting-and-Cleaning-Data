## Getting and Cleaning Data Course Project 
## =========================================
## The script is set to download and unzip the data files into the working directory. If these files have 
## already been downloaded (without changing names), the script can be commented out (with ##) until MERGE
## TRAINING AND TEST DATA SETS TO CREATE A NEW DATA SET
## Before running the script, make sure that the working directory is set to be the same one where the data
## folder and files will be downloaded.

## SET WORKING DIRECTORY
# setwd("PATH TO WORKING DIRECTORY")


## DOWNLOAD ZIP DATAFILE AND UNZIP 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile= "./wearabaledata.zip", method= "wget")
unzip("./wearabaledata.zip")


## MERGE TRAINING AND TEST DATA SETS TO CREATE A NEW DATA SET
## Upload data sets
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
test <- read.table("./UCI HAR Dataset/test/X_test.txt")

## Both data files have the same number of columns. Merge datafile with rbind
alldata <- rbind(train, test)


## EXTRACT MEASUREMENTS ON THE MEAN AND STD FOR EACH MEASUREMENT
## Assign variable names to the columns in the data frame
## 1. Upload variable names
measurements <- read.table("./UCI HAR Dataset/features.txt")
## 2. Make variable names into a vector
measurements_vector <- as.character(measurements[,2])
## 3. Add names of variables to the data frame
# names(alldata)  <- measurements_vector
# str(alldata)

## Identify variable names referring to mean and standard deviation
indexes_mean <- grep("mean()", measurements_vector, fixed= TRUE) 
indexes_std <- grep("std()", measurements_vector, fixed= TRUE)
indexes <- sort(c(indexes_mean, indexes_std))

## Select columns corresponding to these variables
selecteddata <- alldata[,indexes]


## LABEL DATASET WITH DESCRIPTIVE VARIABLE NAMES AND ADD AND LABEL ACTIVITIES 
## Merge train and test files of activity levels
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
all_activity <- rbind(train_activity, test_activity)

## Add activity vector to the data file
selecteddata <- cbind(selecteddata, all_activity)
chosen_measurements <- c(measurements_vector[indexes], "activity")
names(selecteddata)  <- chosen_measurements       ## Labels all variables

## Relabel activities
## 1. Read activity labels from file
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
activity_vector <- as.character(activity_labels[,2])
## 2. Use library plyr to rename values in the activity variables
install.packages("plyr")
library(plyr)
selecteddata$activity <- mapvalues(selecteddata$activity, from = c(1,2,3,4,5,6), to = activity_vector)


## CREATE DATASET FOR THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
## Add a column indicating subject for each row
## 1. Merge train and test files of subjects
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
all_subject <- rbind(train_subject, test_subject)

## 2. Add subject vector to the data file
selecteddata <- cbind(selecteddata, all_subject)
chosen_measurements <- c(measurements_vector[indexes], "activity", "subject")
names(selecteddata)  <- chosen_measurements       ## Re-labels all variables

## Generate the average for each column splitting by activity and individual using ddply from library plyr
summary <- ddply(selecteddata, .(activity, subject), colwise(mean))


# Save data frame into an output file
write.table(summary, file= "./summary_activity_individual.txt", row.names= FALSE)
