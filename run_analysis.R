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

featuresPath <- "./data/features.txt"
activityLabelsPath <- "./data/activity_labels.txt"
trainDataFeaturesPath <- "./data/train/X_train.txt"
trainDataLabelsPath <- "./data/train/y_train.txt"
testDataFeaturesPath <- "./data/test/X_test.txt"
testDatLabelsPath <- "./data/test/y_test.txt"

# load the metadata in
features <- read.table(featuresPath, header = F)
activityLabels <- read.table(activityLabelsPath, header = F)
colnames(features) <- c("featureID", "feature")
colnames(activityLabels) <- c("activityID", "activity")

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
