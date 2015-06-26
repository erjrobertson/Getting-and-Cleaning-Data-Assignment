# Getting and Cleaning Data Assignment

### This describes how the script (run_analysis.R) works

##### Setup: 
* Before you begin, download and unzip all of the files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  On the first line of the code set your working directory to the location of the unzipped files.

##### Running the Code:
* Step1: This step reads in both the training and test datasets to create one dataset (dataset_all).

* Step2: This step reads in the features.txt and exacts only the measurements on the mean and standard deviation.  The dataset_all is then subset to only contain these exacted measurements.  This means that only the mean and standard deviation measurements are retained in the dataset_all.

* Step3: This step reads in the training and test label files to create a single label file.  The names of the activites are then read in and merged with the label file.  Rather than just have the label 1, 2, 3, etc the file now has Walking, climbing stairs, etc.

* Step4: This step first reads in the training and test  subject files to create a single subject file.  Next the code creates a single dataset by merging all of the dataframes.  The subject file (identifies the participant) is merged with the activity file (identifies each activity the participant engaged in) and finally is merged with the MeanStd file (contains all the mean and std measures for each participant by activity).  This final merged file is called CombineData.  This section of the code then creates a clean vector of variable names and replaces all of the original variable names in the CombineData dataframe. 

* Step5: This step outputs an independent tidy data set containing the averages of each variable for each activity and each subject

