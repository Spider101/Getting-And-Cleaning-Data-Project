## Getting-And-Cleaning-Data-Project

This repository consists of the R script and codebook for (Coursera's) Getting And Cleaning Data course's peer reviewed assignment.

### Overview

This script is a demonstration of a data cleaning pipeline. It works on the datasets found in the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and performs the following steps:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

### Notes for using this repository

After you have cloned this repository or downloaded the source files, keep in mind that you have to change the path variables in *run_analysis.R* script to point to the respective locations (on your machine) of the dataset text files involved. Additional details about the process and variables can be found in the *Codebook.MD* file.
