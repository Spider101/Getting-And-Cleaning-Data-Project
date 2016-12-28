###############################################################################

## Coursera - Getting and Cleaning Data Course
## Author - Abhimanyu Banerjee
## Date - 12/27/2016

## File Description:

##
###############################################################################

#clean workspace
rm(list = ls())

#setup
library(data.table)
#library(dplyr)

featuresPath <- "./data/features.txt"
activityLabelsPath <- "./data/activity_labels.txt"
trainDataFeaturesPath <- "./data/train/X_train.txt"
trainDataLabelsPath <- "./data/train/y_train.txt"
trainDataSubjectsPath <- "./data/train/subject_train.txt"
testDataFeaturesPath <- "./data/test/X_test.txt"
testDatLabelsPath <- "./data/test/y_test.txt"
testDataSubjectsPath <- "./data/test/subject_test.txt"

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
testDataLabels <- fread(testDatLabelsPath, header = F)
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
