# Getting And Cleaning Data Project

## File Description
A codebook for the the tidy dataset produced as a result of running the 'run_analysis.R' script. It contains information about the variables in the data and the transformations performed on the dataset to get the final tidy dataset.

### Data Source
A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Variables Description
The features selected for the UCI HAR Dataset come from the accelerometer and gyroscope 3-axial raw signals **tAcc-XYZ** and **tGyro-XYZ** (prefix *t* to denote time). The acceleration and gyroscope signals were then separated into body and gravity acceleration signals (**tBodyAcc-XYZ**, **tGravityAcc-XYZ**, **tBodyGyro-XYZ**, **tGravityGyro-XYZ**).

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (**tBodyAccJerk-XYZ** and **tBodyGyroJerk-XYZ**). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (**tBodyAccMag**, **tGravityAccMag**, **tBodyAccJerkMag**, **tBodyGyroMag**, **tBodyGyroJerkMag**). 

Finally a **Fast Fourier Transform** (FFT) was applied to some of these signals producing **fBodyAcc-XYZ**, **fBodyAccJerk-XYZ**, **fBodyGyro-XYZ**, **fBodyAccJerkMag**, **fBodyGyroMag**, **fBodyGyroJerkMag** (prefix *f* to indicate frequency domain signals). 

### Code Book
The signals mentioned above were used to estimate variables of the feature vector in the original HAR dataset:  
(*-XYZ* is used to denote 3-axial signals in the X, Y and Z directions)

1. tBodyAcc-XYZ
2. tGravityAcc-XYZ
3. tBodyAccJerk-XYZ
4. tBodyGyro-XYZ
5. tBodyGyroJerk-XYZ
6. tBodyAccMag
7. tGravityAccMag
8. tBodyAccJerkMag
9. tBodyGyroMag
10. tBodyGyroJerkMag
11. fBodyAcc-XYZ
12. fBodyAccJerk-XYZ
13. fBodyGyro-XYZ
14. fBodyAccMag
15. fBodyAccJerkMag
16. fBodyGyroMag
17. fBodyGyroJerkMag

The following set of variables were estimated from the signals above: 

1. mean(): Mean value
2. std(): Standard deviation
3. mad(): Median absolute deviation 
4. max(): Largest value in array
5. min(): Smallest value in array
6. sma(): Signal magnitude area
7. energy(): Energy measure. Sum of the squares divided by the number of values. 
8. iqr(): Interquartile range 
9. entropy(): Signal entropy
10. arCoeff(): Autorregresion coefficients with Burg order equal to 4
11. correlation(): correlation coefficient between two signals
12. maxInds(): index of the frequency component with largest magnitude
13. meanFreq(): Weighted average of the frequency components to obtain a mean frequency
14. skewness(): skewness of the frequency domain signal 
15. kurtosis(): kurtosis of the frequency domain signal 
16. bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
18. angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample:
(They were then used on the angle() variable)

1. gravityMean
2. tBodyAccMean
3. tBodyAccJerkMean
4. tBodyGyroMean
5. tBodyGyroJerkMean

The tidy dataset on the other hand focusses on *66* out of the *561* variables in the original dataset. Please reference the file below (created using Knitr) for the summary of the variables found in the tidy dataset.

<a href="http://htmlpreview.github.com/?https://github.com/Spider101/Getting-And-Cleaning-Data-Project/blob/master/codeBookGen.html" target="_blank">Tidy Dataset Codebook</a>

### Transformations:

**PART I: Merge the training and the test sets to create one data set**

Step 1. Set the path variables for the datasets of interest.

Step 2. Load the tables with metadata information, found in -
	
* features.txt
* activity_labels.txt
* subject_train.txt
* subject_test.txt
		
and assign appropriate labels to the variables in each table.

Step 3. Load the tables with the training and test set data, found in -
	
* X_train.txt
* y_train.txt
* X_test.txt
* y_test.txt

and assign appropriate labels to the variables in each table; using the values in the features table for labelling variables in 		**X_train** and **X_test** tables respectively.

Step 4. Merge the features vectors and labels of the training and test set respectively and then join the combined training and test datasets.

**PART II: Extract only the measurements on the mean and standard deviation for each measurement.**

Step 1. Find matches for 'mean()' and 'std()' partials in the variable names of the dataset formed from the previous steps.

Step 2. Concatenate the matches found with the activity and subject id variable names.

Step 3. Subset the overall dataset based on the subset of variable names computed above.

**PART III: Use descriptive activity names to name the activities in the data set**

Step 1. Merge the overall dataset with the dataset with the activity labels (*activitiesLabel*) to add labels for each record.

**PART IV: Appropriately label the data set with descriptive variable names**

Step 1. Loop through the variable names and replace technical nomenclature with meaningful names.

Step 2. Replace the dataset variable names with the formatted variable names.

**PART V: Create a second, independent tidy data set with the average of each variable for each activity and each subject**

Step 1. Group dataset by the subjectID and activityID (included activity for sake of better presentation in the final dataset).

Step 2. Compute mean of the remaining variables and extract out this summary along with the grouping variables as the tidy dataset.

Step 3. Export the tidy dataset.

### Study Design
The original UCI HAR dataset was obtained from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Thereafter, the various components of the dataset were combined to form a single dataset (this process is explained in the section [Transformations](#transformations)) of 563 variables and 10299 records. Out of the 563 variables, 561 of them related to the signals observed in the original experiment and the remaining two were identifier variables - **subjectID** and **activityID**). As determined by the project requirements, the variables chosen for the tidy dataset were the mean and standard deviation of the signals mentioned in the section [Code Book](code-book). These variables were then averaged over the records for each subject and each activity in the original experiment to form the final tidy dataset. The details of the original experiment are given below:

The experiments were carried out with a group of *30* volunteers within an age bracket of *19-48* years. Each person performed six activities (***WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING***) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, **3-axial linear acceleration** and **3-axial angular velocity** were captured at a constant rate of *50Hz*. The experiments were been video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where *70%* of the volunteers was selected for generating the training data and *30%* the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of *2.56* sec and *50%* overlap (*128* readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a ***Butterworth low-pass filter*** into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with *0.3Hz* cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
