---
title: "CodeBook"
author: "APR"
date: "11/29/2021"
output: html_document
---

## R Markdown
#Description
#Additional information about the variables, data #and transformations used in the course project for #the Johns Hopkins Getting and Cleaning Data #course.

##Source Data
The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Download the dataset
2. Dataset downloaded and extracted under the folder called UCI HAR Dataset

3. Assign each data to variables


4. Merges the training and the test sets to create one data set


5. Extracts only the measurements on the mean and standard deviation for each measurement


Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export FinalData into FinalData.txt file.

##Data + Description can be found here UCI Machine



