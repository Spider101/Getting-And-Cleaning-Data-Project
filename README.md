## Getting-And-Cleaning-Data-Project

This repository consists of the R script and codebook for (Coursera's) Getting And Cleaning Data course's peer reviewed assignment.

### Overview

This project is a demonstration of a data cleaning pipeline. It works on the datasets found in the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and performs the following steps:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

The *Codebook.md* file provides information about the variables in the tidy dataset that cannot be inferred from the dataset itself, lists the transformations performed on the original dataset to get the tidy dataset and describes how the original dataset was collected and the choice of variables to be used in the tidy dataset. The *codeBookGen.html* provides summary information about the variables in the tidy dataset. There is a link to it in the markdown file under the **Code Book** section. 
