# data_cleaning
This repository holds my project submission for the Coursera course on
getting and cleaning data by the John Hopkins Bloomberg School of Public Health.

## run_analysis.R
This file contains the commented source code in the R programming language that cleans the raw data and tidies it up.
To use it, the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip has to reside in the
same directory as the script (and has to be unpacked). The result will be saved into result.txt.

## Inner workings of the function
1. Process field names
	* Read the column captions from "features.txt" with read.table()
	* Select fields containing "mean" or "std" into a vector using grep()
	* Select all fields into another vector
2. Process activity names
	* Read the activity names from "activity_labels.txt" using read.table()
	* Read the activity data sets from both sub-folders using read.table()
	* Combine the activity data into a vector containing the activity names using append() and sub-setting
3. Process subject data
	* Read the subject data from both sub-folders sets using read.table()
	* Combine the subject data into a vector using append() and sub-setting
4. Read the raw motion data from both sub-folders sets using read.table()
5. Set the column names of both motions data to the list of all field names obtained earlier using colnames()
6. Cut all unwanted columns from both motion data sets by sub-setting colnames() with the %in% operator
7. Combine both filtered motion data sets using rbind()
8. Add the activity and subject data to a separate column respectively
9. Aggregate the data by subject and activity using the aggregate() function - provide the mean for all data fields.
10. Write the result into a textfile named "result.txt"
11. Return the result

## result.txt
This is the result as written by the run_analysis() function.

## codebook.md
This file contains a description of the data in result.txt.