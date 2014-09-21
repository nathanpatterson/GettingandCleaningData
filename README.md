Processing and Analysis of Wearable Computing Dataset
======================

This repository contains the materials to obtain and process data collected from users of the Samsung Galaxy S smartphone.


## Background
We are using R to download, manipulate, and analyze data obtained from thirty users of the Samsung Galaxy S smartphone.  The data (direct <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">link</a> to the data file) were collected from the gyroscopes and accelerometers on the smartphones; a full discussion behind the dataset is contained <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">here</a>.

## Description of Script
The script <a href="https://github.com/nathanpatterson/GettingandCleaningData/blob/master/run_analysis.R">run_analysis.R</a> will perform the following steps:
* Obtain the compressed data file from the link above and extract the data to your working directory.
* Merges the training and the test sets to create one data set.
* Extracts the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set.
* Labels the data set with descriptive variable names. 
* Creates a separate tidy data set with the average of each variable for each activity and each subject; this is then saved as both a txt file and a csv file.

## Instructions 
The script is purpose-built and self contained; the user need simply run the R script from within R or RStudio.  Before running the script, the user should make sure the <a href="http://cran.r-project.org/web/packages/plyr/index.html">plyr</a> package is installed.  The script incorporates no user interaction elements other than the final output and does not check to see if the data set is already downloaded.

For more information, review the <a href="https://github.com/nathanpatterson/GettingandCleaningData/blob/master/CodeBook.md">CodeBook.md</a> file.
