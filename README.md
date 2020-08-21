---
title: "README"
author: "Farooqmohammd"
date: "21/08/2020"
output:
  html_document:
    keep_md: yes
---

### Project Description
The purpose of this project is to demonstrate THE ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. . We are required to submit: 1) a tidy data set , 2) a link to a Github repository , and 3) a code book that describes the variables of the dataset.The objective is to tidy the dataset Human Activity Recognition Using Smartphones Dataset.

The obtained dataset contains the results of experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years and the results have been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Collection of the data
The data is downloaded from the given url and the contents are unzipped.
```{r}
file_name <- "Final_project.zip"
# Checking for existance

if (!file.exists (file_name)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file (url, file_name)
  )
unzip(file_name)

```

The files that will be used for this project are as follows.

* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt


### Guide to create the tidy data file

1. All the rquired files are loaded into R and are given proper column names.

```{r}
features <- read.table ("UCI HAR Dataset/features.txt", col.names = c("N","Function"))

activities <- read.table ("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "Activity"))

subject_test <- read.table ("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x_test <- read.table ("UCI HAR Dataset/test/X_test.txt", col.names = features$Function)

y_test <- read.table ("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table ("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_train <- read.table ("UCI HAR Dataset/train/X_train.txt", col.names = features$Function)

y_train <- read.table ("UCI HAR Dataset/train/y_train.txt", col.names = "code")


```
2. Training and testing datasets are merged into a single dataframe.

```{r}
#Step 1: Merging the training and the test sets to create one dataset

# column binding training datasets. Same is applied to testing datasets

training_data <- cbind (subject_train, y_train, x_train)

testing_data <- cbind (subject_test, y_test, x_test)


# row binding the above dataframes to form a one complete dataset

merged_data <- rbind (training_data, testing_data)

```
3. Only columns with mean and standard deviation are extracted from the merged datframe.

```{r}
Step 2: Extracting measurements on the mean and standard deviation for each measurement

extracted_data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))
```

4. Labeling the data set with descriptive variable names.

```{r}
# Step 3: Use descriptive activity names to name the activities in the dataset
# Using the factor function to give activity labels to the code 

extracted_data$code <- factor (extracted_data$code, labels = activities$Activity)



# Step 4: Labeling the data set with descriptive variable names.
# using full forms and capital letters

names(extracted_data)[2] = "activity"

names(extracted_data) <- gsub ("Acc", "Accelerometer", names(extracted_data))

names(extracted_data) <- gsub ("Gyro", "Gyroscope", names(extracted_data))

names(extracted_data) <- gsub ("BodyBody", "Body", names(extracted_data))

names(extracted_data) <- gsub ("Mag", "Magnitude", names(extracted_data))

names(extracted_data) <- gsub ("^t", "Time", names(extracted_data))

names(extracted_data) <- gsub ("^f", "Frequency", names(extracted_data))

names(extracted_data) <- gsub ("tBody", "TimeBody", names(extracted_data))

names(extracted_data) <- gsub ("angle", "Angle", names(extracted_data))

names(extracted_data) <- gsub ("gravity", "Gravity", names(extracted_data))

names(extracted_data) <- gsub ("mean", "Mean", names(extracted_data))

names(extracted_data) <- gsub ("std", "SD", names(extracted_data))

names(extracted_data) <- gsub ("freq", "Frequency", names(extracted_data))
```

5. From the dataset, a second, independent tidy dataset is created with the average of each        variable for each activity and each subject.
```{r}
# Step 5: From the dataset in step 4, creating a second, independent tidy dataset
# with the average of each variable for each activity and each subject.

final_data <- extracted_data %>%
  group_by (subject, activity) %>%
  summarise_all (.funs = mean)
  
write.table (final_data, "final_data.txt", row.name=FALSE)
```
Finally the resut is written as a text file. It can be loaded on R as `r read.table('final_data.txt', header=TRUE)`

