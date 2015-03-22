# coursera-Getting-and-Cleaning-Data

Getting and Cleaning Data
Course Project
March 22, 2015

The R script run_analysis.R analyzes activity data generated by: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. Smartlab - Non Linear Complex Systems Laboratory DITEN - Università degli Studi di Genova. Via Opera Pia 11A, I-16145, Genoa, Italy. activityrecognition@smartlab.ws www.smartlab.ws

The script:

Downloads in the working directory and unzpips a zip file containing data files from this address: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip The data was obtained from accelerometers at a smatphone. A full description can be foudn in this address: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Merges the training and the test sets to create one data set (dataframe: alldata)

Identifies variables corresponding to the mean and standard deviation for each measurement and generates a new data ser with these (selecteddata). Variables analyzed are listed in the file CodeBook.md

Appends a column to this data file indicating types of activity renamed according to the file activity_labels.txt

Appends a column with subject identification codes

Adds names to all variables in the data set

Generates the average for each column splitting by activity and individual.

Produces an output file with this information, named summary_activity_individual.txt, which is saved in the working directory

NOTES:

a.- The script is set to download and unzip the data files into the working directory. If these files have already been downloaded (without changing names), the script can be commented out (with ##) until MERGE TRAINING AND TEST DATA SETS TO CREATE A NEW DATA SET

b.- Before running the script, make sure that the working directory is set to be the same one where the data folder and files will be downloaded.

c.- The script installs and uploads the package "plyr"