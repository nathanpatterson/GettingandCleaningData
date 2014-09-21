## Preamble - Load libraries and settings, save data file from URL, extract data.
## For expediency's sake I am not incorporating user prompts or other UI elements; this is meant to be a purpose-built analysis.

library(plyr)
setInternet2(TRUE)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "Dataset.zip", mode = "wb")
unzip("Dataset.zip")

## Step 1 - "Merges the training and the test sets to create one data set."

dataset_combined <- {
	X_training <- read.table("UCI HAR Dataset/train/X_train.txt")
	Y_training <- read.table("UCI HAR Dataset/train/y_train.txt")
	subject_training <- read.table("UCI HAR Dataset/train/subject_train.txt")
	X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
	Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
	subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
	X_combined <- rbind(X_training, X_test)
	Y_combined <- rbind(Y_training, Y_test)
	subject_combined <- rbind(subject_training, subject_test)
	list(x = X_combined, y = Y_combined, subject = subject_combined)
}

X_comb <- dataset_combined$x
Y_comb <- dataset_combined$y

## Step 2 - "Extracts only the measurements on the mean and standard deviation for each measurement."

measurements_extract <- {
	measurements <- read.table("UCI HAR Dataset/features.txt")
	mean_extract <- sapply(measurements[,2], function(x) grepl("mean()", x, fixed = T))
	standarddeviation_extract <- sapply(measurements[,2], function(x) grepl("std()", x, fixed = T))
	extract <- X_comb[, (mean_extract | standarddeviation_extract)]
	colnames(extract) <- measurements[(mean_extract | standarddeviation_extract), 2]
	extract
}

## Step 3 - "Uses descriptive activity names to name the activities in the data set"

activities_Y_comb <- {
	colnames(Y_comb) <- "activity"
	activitynames <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
	colnames(activitynames) <- c("V1","V2")
	for(i in 1:6) {
		Y_comb$activity[Y_comb$activity == i] <- activitynames$V2[match(i, activitynames$V1, nomatch = FALSE)]
	}
	Y_comb
}

## Step 4 - "Appropriately labels the data set with descriptive variable names."

colnames(dataset_combined$subject) <- c("subject")
transformed_data <- cbind(measurements_extract, activities_Y_comb, dataset_combined$subject)

## Step 5 - "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

independenttidydataset <- ddply(transformed_data, .(subject, activity), function(x) colMeans(x[,1:60]))
write.csv(independenttidydataset, "UCI HAR Dataset_tidy.csv", row.names = FALSE)
write.table(independenttidydataset, "UCI HAR Dataset_tidy.txt", row.names = FALSE)
rm(dataset_combined, X_training, Y_training, subject_training, X_test, Y_test, subject_test, X_combined, Y_combined, subject_combined, X_comb, Y_comb, measurements_extract, mean_extract, standarddeviation_extract, extract, activities_Y_comb, activitynames, transformed_data, independenttidydataset)
csvpath <- paste(c(getwd(), "/UCI HAR Dataset_tidy.csv"), collapse='')
txtpath <- paste(c(getwd(), "/UCI HAR Dataset_tidy.txt"), collapse='')
message("Analysis complete and available here:")
message("- ", csvpath)
message("- ", txtpath)
message("Remember to reverse your slashes if viewing outside of R.")
