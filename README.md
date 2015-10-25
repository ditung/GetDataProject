# GetDataProject
Repository for Course Project for Getting and Cleaning Data on Coursera

The 'Run_Analysis.R" script combines data 

The script first reads in data from the following files:

(main directory)
activity_labels
features

(test directory)
subject_test
y_test
x_test

(train directory)
subject train
y_train
x_train

It then creates a unique ID 'ID' across the tables generated from the files in the test and train directory. 
Next, it combines the test and train datasets and merges the activity and subject data with the measurement data into one dataset (called mergedData).
Then, it outputs the means and standard deviations for the measurement variables across one dataset into a 'measures' data frame.
Finally, it creates a subject and activity interaction variable, which it will use to calculate the means of the measurement variable across each subject and activity group (this step requires some workaround procedures, like creating a temporary table, transposing the resulting matrix and re-naming the columns in the resulting matrix).

This will result in a 180x564 table which contains 180 rows corresponding to 30 subjects and their six different activities (walking, walking upstairs, walking downstairs, sitting, standing, laying). The 564 columns contain the subject ID, activity ID, subject activity interaction variable and the 561 measurement vectors. The table is sorted by activity and then subject.
