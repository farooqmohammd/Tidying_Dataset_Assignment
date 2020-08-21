---
title: "Codebook"
author: "Farooqmohammd"
date: "21/08/2020"
output:
  html_document:
    keep_md: yes
---

### Project Description
The objective is to tidy the dataset Human Activity Recognition Using Smartphones Dataset.

The obtained dataset contains the results of experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years and the results have been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

We are required to prepare the dataset for further analysis by tidying it up.


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
2. Training and testing datasets are merged into a single dataframe.
3. Only columns with mean and standard deviation are extracted from the merged datframe.
4. Labeling the data set with descriptive variable names.
5. From the dataset, a second, independent tidy dataset is created with the average of each        variable for each activity and each subject.


### Description of the variables

General description of the tidied dataset is shown below.

The variables are as follows.


|column position| Name                                          | Description             |
|:--------------|:----------------------------------------------|:------------------------|
|1  |Subject|id of the volunteers | 
| | | |
|2             |Activity |1  Walking     |                         
|               |                                               |2 WALKING_UPSTAIRS       |
|               |                                               |3 WALKING_DOWNSTAIRS     |
|               |                                               |4 SITTING                |
|               |                                               |5 STANDING               |
|               |                                               |6 LAYING                 |
|               |                                               |                         |
|3-88           |TimeBodyAccelerometer.SD-XYZ                   |Readings calculated from |
|               |TimeGravityAccelerometer.SD-XYZ                |the values obtained from |
|               |tBodyAccelerometrJerk.SD-XYZ                   |the 3 axial linear accele|
|               |TimeBodyGyroscope.SD-XYZ                       |rometer and 3 axial gyro |
|               |TimeBodyGyroscopeJerk.SD-XYZ                   |scope.(standard deviation|
|               |TimeBodyAccelerometerMagnitude.SD              |and mean)                |
|               |TimeGravityAccelerometerMagnitude.SD           |                         |
|               |TimeBodyAccelerometerJerkMagnitude.SD          |                         |
|               |TimeBodyGyroscopeMagnitude.SD                  |                         |
|               |TimeBodyGyroscopeJerkMagnitude.SD              |                         |
|               |FrequencyBodyAcclerometer.SD-XYZ               |                         |
|               |FequencyBodyAccelerometerJerk.SD-XYZ           |                         |
|               |FrequencyBodyGyroscope.SD-XYZ                  |                         |
|               |FrequencyBodyAccelerometerMagnitude.SD         |                         |
|               |FrequencyBodyAccelerometerJerkMagnitude.SD     |                         |
|               |FrequencyBodyGyroscopeMagnitude.SD             |                         |
|               |FrequencyBodyGyroscopeJerkMagnitude.SD         |                         |

See the [README.txt]() file for the detailed information on the dataset
