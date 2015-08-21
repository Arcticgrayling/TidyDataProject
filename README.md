Data Science - Getting and Cleaning Data
========================================
Course Project - Peter Olsen - August 2015
-------------------------------------------

##The Project  
This project takes data from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones   
The data is process according to the project specifications through an R script which:   
* Merges the training and the test sets to create one data set.  
* Extracts only the measurements on the mean and standard deviation for each measurement.   
* Uses descriptive activity names to name the activities in the data set   
* Appropriately labels the data set with descriptive variable names.   
* From the data set in step 4, creates a second, independent tidy data set    
with the average of each variable for each activity and each subject.

##Data:   

The data was downloaded from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

It is assumed the file is downloaded and unzipped in the same directory as the script.
Unzip will produce a directory: "UCI HAR Dataset" with the data.

####Data from the following files is used:  
* From the project Directory
  * activity_labels.txt  
  * features.txt  
* From the test directory    
  * subject_test.txt  
  * X_test.txt  
  * y_test.txt  
* From the train directory
  * subject_train.txt
  * X_train.txt  
  * y_train.txt  

##Script:  

run_analysis.R is the data tidying script.  It has been commented for clarity.

##Results = Tidy Data:  

The Script produces a "tidy data" text file: "part5Data.txt" in response to the project 
requirements.
This file is written to the main project directory.

##Code Book:  

The code book the variables used in the part5Data.txt file.  It should be noted the
existing variable names from the features.txt file was used "as is".  
The variables are named the same in the results file even though they represent the mean 
of Subject and Activity grouping.

##Process:  

The data is down loaded and unzipped in the project directory.
The script:  
1. Loads labels and activityList into tables.  

2. Loads train data into tables.  
  * Labels are given to this train data.  
  * Activities (with names) and Subject columns are added to the beginning 
	of the training data table.  
  * Remove undesired columns/variables.  A reg script is used to select only
	Variables with mean() and std() in the variable name. (1.) (2.)  
  * For testing and verification purposes,  intermediary data was used.  
	The script removes some of this data after the Test data is processed
	to free memeory.  

3. Loads test data into tables.
  * Labels are given to this test data. 
  * Activities (with names) and Subject columns are added to the beginning 
  of the test data table.  
  * Remove undesired columns/variables.  A reg script is used to select only
	Variables with mean() and std() in the variable name.     

4.	The Test and and Train data are merged.  They have been cleaned identically so 
	they merge correctly.  

5.	The complete data is processed so each variable is grouped by Activity and Subject
	and the mean calculated.  "group_by" and "summarize_each" were used to perform this
	because of the intuitive language of the functions.  
	http://stackoverflow.com/a/24455439/4076486 was referenced in researching this.  
	
##Misc:    
Contains a script inspired by the TA David Hood 
to extract the variable names from the data to be used in the Codebook
	
##Notes:

1. The project directions were unclear as to exactly which variables were to be selected.
	It was assumed that this project would only include variables with 
	mean() and std() in the variable name.
	
2. The regex/grep script uses // to "escape the ( and ) characters.
	
		
