library(dplyr)

file_name <- "Final_project.zip"


# Checking for existance

if (!file.exists (file_name)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file (url, file_name)
}  


# Checking if the directory exists

if (!file.exists ("UCI HAR Dataset")) { 
  unzip (file_name) 
}


#Reading the files into R and assigning column names

features <- read.table ("UCI HAR Dataset/features.txt", col.names = c("N","Function"))

activities <- read.table ("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "Activity"))

subject_test <- read.table ("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x_test <- read.table ("UCI HAR Dataset/test/X_test.txt", col.names = features$Function)

y_test <- read.table ("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table ("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_train <- read.table ("UCI HAR Dataset/train/X_train.txt", col.names = features$Function)

y_train <- read.table ("UCI HAR Dataset/train/y_train.txt", col.names = "code")



#Step 1: Merging the training and the test sets to create one dataset

# column binding training datasets. Same is applied to testing datasets

training_data <- cbind (subject_train, y_train, x_train)

testing_data <- cbind (subject_test, y_test, x_test)


# row binding the above dataframes to form a one complete dataset

merged_data <- rbind (training_data, testing_data)



# Step 2: Extracting measurements on the mean and standard deviation for each measurement

extracted_data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))



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



# Step 5: From the dataset in step 4, creating a second, independent tidy dataset
# with the average of each variable for each activity and each subject.

final_data <- extracted_data %>%
  group_by (subject, activity) %>%
  summarise_all (.funs = mean)


# wriiting the final dataframe as a .txt file

write.table (final_data, "final_data.txt", row.name=FALSE)


