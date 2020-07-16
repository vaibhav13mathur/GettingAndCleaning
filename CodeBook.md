---
title: "CodeBook"
author: "Vaibhav"
date: "16/07/2020"
output: html_document
---

The script run_analysis.R is used to clean up UCI HAR Dataset as described in the project's definition

**Step 1**: Read the files
**Variable - Description**

features - It contains the list of features that has been taken into account for measurements (features.txt)
acti - Links the class labels with their activity name(activity_labels.txt)
subject_test - (subject_test.txt)
X_t - Test set(test/X_test.txt)
y_t - Test labels(test/y_test.txt)
x_tr - Training set(train/X_train.txt)
y_tr -  Training labels(train/y_train.txt)
subject_train - Each row identifies the subject who performed the activity for each window sample (train/subject_train.txt)
subject_test - Each row identifies the subject who performed the activity for each window sample(test/subject_test.txt)

**Step 2**: Merging the dataset using rbind() function
**Variable - Description**

x1 <- It binds x_t and x_tr
y1 <- It binds y_t and y_tr
subj <- It binds subject_train and subject_test

Step 3: Extracting the values for only mean and standard deviation for each measurement. grep() function used to get values in the column where "mean" and "std" word is present
**Variable - Description**

feature2 - It contains the index of column where word "mean" and "std" is present
data2 - It contains all the columns from x1 where word "mean" and "std" is present

colnames() function is used to give names to the columns of data2 from feature

data1 - It contains the combined data of subj, data2 and y1 combined using cbind() function

**Step 3**: In this step descriptives activities names are added in data

Descriptive values are added in y1 from acti

**Step 4**: Descriptive variable names
colnames() function is used to give names to columns y1 and subj
**Variable - Description**

final_data - It contains the combined values of data1, y1 and subj combined using rbind() function

**Step 5**: Valid column names to be given
**Variable - Description**

valid_column_names - It contains valid and unique column names from final_data. make.names() function is used here

names() function is used to give valid_column_names to final_data

**Step 6**: Create a final dataset with mean of each column group by activity and subject
**Variable - Description**

final_data1 - It contains final required data set with mean of each column group by activity and subject
write.csv() function is used to export a Final_Tidy_Data.csv file of tidy dataset 

