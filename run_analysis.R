##
## This function takes the raw data found here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## 
## It combines the trainings and test sets, adds the activity and subject data to the motion
## data, and filters out all but the columns with mean and standard deviation data.
##
## Finally, the data is grouped by subject and activity. For each pair the average (mean) is
## calculated for all columns.
##
run_analysis <- function() {
  
  # Read the column captions from "features.txt"
  fields <- read.table("features.txt")
  
  # Select fields containing "mean" or "std" into a vector
  relevant_fieldnames <- grep("(mean)|(std)", fields[,2], ignore.case = TRUE, value = TRUE)

  # Select all fields into a vector
  all_fieldnames <- fields[,2]
  
  # Read the activity names from "activity_labels.txt"
  activity_labels <- read.table("activity_labels.txt")
  
  # Read the activity data sets
  activity_train_data <- read.table("train/y_train.txt")
  activity_test_data <- read.table("test/y_test.txt")
  
  # Combine the activity data into a vector containing the activity names
  activity_data <- activity_labels[append(activity_train_data[,1], activity_test_data[,1]), 2]

  # Read the subject data sets
  subject_train_data <- read.table("train/subject_train.txt")
  subject_test_data <- read.table("test/subject_test.txt")
  
  # Combine the subject data into a vector
  subject_data <- append(subject_train_data[,1], subject_test_data[,1])

  # Read the raw motion data sets
  motion_train_data <- read.table("train/X_train.txt")
  motion_test_data <- read.table("test/X_test.txt")
  
  #Set the column names of both motions data sets
  colnames(motion_train_data) <- all_fieldnames
  colnames(motion_test_data) <- all_fieldnames
  
  # Cut all unwanted columns from both motion data sets
  filtered_motion_train_data <- motion_train_data[colnames(motion_train_data) %in% relevant_fieldnames]
  filtered_motion_test_data <- motion_test_data[colnames(motion_test_data) %in% relevant_fieldnames]

  # Combine both filtered motion data sets
  tidy_data <- rbind(filtered_motion_train_data, filtered_motion_test_data)

  # Add the activity and subject data
  tidy_data$activity <- activity_data
  tidy_data$subject <- subject_data
  
  # Aggregate the data by subject and activity: provide the mean for all data fields
  result <- aggregate(. ~ activity + subject, tidy_data, mean)
  
  # Write the result into a textfile
  write.table(result, file="result.txt", row.names=FALSE)
  
  # Return the result
  result
}

