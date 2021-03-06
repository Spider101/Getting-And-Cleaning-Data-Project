###############################################################################

## Coursera - Getting and Cleaning Data Course
## Author - Abhimanyu Banerjee
## Date - 12/27/2016

## File Description:

## This script is a demonstration of a data cleaning pipeline. It works on the
## datasets found in the UCI HAR Dataset [http://archive.ics.uci.edu/ml/datasets
## /Human+Activity+Recognition+Using+Smartphones] and performs the following
## steps:
## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for each
##    measurement.
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive variable names.
## 5. From the data set in step 4, create a second, independent tidy data set
##    with the average of each variable for each activity and each subject.

###############################################################################

## Setup environment for the rest of the script's code

#clean workspace
rm(list = ls())

#using dplyr_0.5.0 and data.table_1.10.0
require("data.table")
require("dplyr")

#check if the data directory exists, if not then create it, download the dataset
# and unzip it
if(!file.exists("data")){
    dir.create("data")
    dataUrl <- paste("https://d396qusza40orc.cloudfront.net/getdata%2F",
                     "projectfiles%2FUCI%20HAR%20Dataset.zip",
                     collapse ="", sep = "")
    dataZipPath <- "./data/UCI HAR Dataset.zip"
    download.file(dataUrl, dataZipPath)
    unzip(dataZipPath, exdir = "./data")

}

#check if the environment is empty, if so then populate it with the necessary
#variables
if(length(ls()) == 0){
    datasetLoc <- list.dirs("./data/", recursive = F)
    dataPath <- list.files(datasetLoc[1], full.names = T, recursive = T)
    featuresPath <- dataPath[2]
    activityLabelsPath <- dataPath[1]
    trainDataSubjectsPath <- dataPath[26]
    testDataSubjectsPath <- dataPath[14]
    trainDataFeaturesPath <- dataPath[27]
    trainDataLabelsPath <- dataPath[28]
    testDataFeaturesPath <- dataPath[15]
    testDataLabelsPath <- dataPath[16]
}

# load the metadata in
features <- read.table(featuresPath, header = F)
activityLabels <- read.table(activityLabelsPath, header = F)
trainDataSubjects <- read.table(trainDataSubjectsPath)
testDataSubjects <- read.table(testDataSubjectsPath)
colnames(features) <- c("featureID", "feature")
colnames(activityLabels) <- c("activityID", "activity")
colnames(trainDataSubjects) <- "subjectID"
colnames(testDataSubjects) <- "subjectID"

#load the training data in and assign the right variable names to the columns
trainDataFeatures <- fread(trainDataFeaturesPath, header = F)
trainDataLabels <- fread(trainDataLabelsPath, header = F)
colnames(trainDataFeatures) <- as.character(features$feature)
colnames(trainDataLabels) <- "activityID"

#load the test data in and assign the right variable names to the columns
testDataFeatures <- fread(testDataFeaturesPath, header = F)
testDataLabels <- fread(testDataLabelsPath, header = F)
colnames(testDataFeatures) <- as.character(features$feature)
colnames(testDataLabels) <- "activityID"

## Part 1: Merge the training and the test sets to create one data set.

#merge the features vectors and labels of the training and test set respectively
trainingData <- cbind(trainDataFeatures, trainDataLabels, trainDataSubjects)
testData <- cbind(testDataFeatures, testDataLabels, testDataSubjects)
finalDataset <- rbind(trainingData, testData)

## Part 2: Extract only the measurements on the mean and standard deviation for
## each measurement.

#find matches for 'mean()' and 'std()' partials in the variable names
meanAndStdMatches <- grep("mean\\(\\)|std\\(\\)", colnames(finalDataset))

#get the variable names of the matches found above and concatenate them with
#the activity and subject id variable names
datasetVariableSubset <- colnames(finalDataset)[meanAndStdMatches]
datasetVariableSubset <- c(datasetVariableSubset, "activityID", "subjectID")

#subset the overall dataset based on the subset of variable names computed above
dataSubset <- finalDataset[, datasetVariableSubset, with = F]

## Part 3: Use descriptive activity names to name the activities in the data set

#merge the overall dataset with the activitiesLabel dataset to add labels for
#each record
dataSubset <- merge(dataSubset, activityLabels, by = "activityID")

## Part 4: Appropriately label the data set with descriptive variable names.

dataVariables <- colnames(dataSubset)

#loop through the variable names and replace technical nomenclature with
#meaningful names
for(i in seq_along(dataVariables)){
    dataVariables[i] <- gsub("\\-", "", dataVariables[i])
    dataVariables[i] <- gsub("\\()", "", dataVariables[i])
    dataVariables[i] <- gsub("mean", "Mean", dataVariables[i])
    dataVariables[i] <- gsub("std", "Std", dataVariables[i])
    dataVariables[i] <- gsub("^t", "time", dataVariables[i])
    dataVariables[i] <- gsub("^f", "freq", dataVariables[i])
    dataVariables[i] <- gsub("(Body){2}", "Body", dataVariables[i])
    dataVariables[i] <- gsub("Mag", "Magnitude", dataVariables[i])
}

#replace the dataset variable names with the formatted variable names
colnames(dataSubset) <- dataVariables

## Part 5: Create a second, independent tidy data set with the average of each
## variable for each activity and each subject.

#group dataset by the subjectID and activityID (included activity for sake of
#better presentation in the dataset), compute mean of remaining variables and
#extract out this summary along with the grouping variables as the tidy dataset
tidyDataset <- dataSubset %>%
                group_by(subjectID, activityID, activity) %>%
                summarize_each(funs(mean))

#export the tidy dataset
write.table(tidyDataset, "./data/tidy_dataset.txt", sep = " ", row.names = F)
