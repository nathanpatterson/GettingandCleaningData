Description of Variables, Data, and Work Performed
======================


## Introduction and High-Level Description of Script

We are using R to download, manipulate, and analyze data obtained from thirty users of the Samsung Galaxy S smartphone.  The data (direct <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">link</a> to the data file) were collected from the gyroscopes and accelerometers on the smartphones; a full discussion behind the dataset is contained <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">here</a>.

The script <a href="https://github.com/nathanpatterson/GettingandCleaningData/blob/master/run_analysis.R">run_analysis.R</a> will perform the following steps:
* Obtain the compressed data file from the link above and extract the data to your working directory.
* Merges the training and the test sets to create one data set.
* Extracts the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Labels the data set with descriptive variable names.
* Creates a separate tidy data set with the average of each variable for each activity and each subject; this data set is exported as both a txt and csv file.

## The Data and Variables
The original data set is separated between training and test data; 70% of the data (approximate) comes from the training group and 30% comes from a test group.  All participants were randomly assigned between the two groups.  Each data set is split apart into files that contain the subject identifier, measurements from the gyroscope and accelerometer, and activity label.

## Work Performed
The script, while continuous, performs each of the steps described above.  All variables are local variables and are cleared once the analysis is complete and the tidy data set extracted.

Preamble:
* Load plyr and load the internet2.dll library.
* Download the ZIP file containing the dataset and extract it to the working directory.

Step 1:
* We read the raw data to tables; we create a table for the set, labels, and subject, for both the test and training data  (X (data set), Y (labels), and subject (individual)).
* We then combine the training and test sets, labels, and subject tables.
* These are standard table creation and combination steps using read.table and rbind.  We return a list containing the three merged tables.  We also store the X and Y tables separately for use in Steps 2 and 3.

Step 2:
* Once we have our combined data set, we extract all features pertaining to mean and standard deviation measurements (any features with "mean()" or "std()").
* We then subset our combined dataset to include just the data pertaining to those features.
* We store the result in another table for use in Step 4.

Step 3:
* We replace the activity labels with descriptive activity names.  We use the labels defined in the file "activity_labels.txt".
* We use a basic for loop and match to line up our labels and descriptive names.
* Our output is the Y_comb table from Step 1 with descriptive activity names instead of the numeric labels.

Step 4:
* We create a descriptive variable name for "subject", then use cbind to pull together our combined data set (which has descriptive variable names for all the component tables).
* As part of doing this, we complete our combined data set using the results of our manipulation in Steps 2-4.

Step 5:
* We create a new data set using the ddply function in package plyr to subset our transformed data first by subject, then by activity, then take the mean of each subset of data.
* The user should end up with 180 observations with 66 variables each.
* We write the resulting data set to both csv and txt, then remove our variables.

## Notes to Users
The script is purpose-built and self contained; the user need simply run the R script from within R or RStudio.  Before running the script, the user should make sure the <a href="http://cran.r-project.org/web/packages/plyr/index.html">plyr</a> package is installed.  The script incorporates no user interaction elements other than the final output and does not check to see if the data set is already downloaded.
