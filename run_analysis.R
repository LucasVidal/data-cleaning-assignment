library(tidyverse)

##
## Downloads and unzips the data into a "data" folder
##
download_data <- function() {
  if (!file.exists("data")) {
    temp_zip_filename <- "data.zip"
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp_zip_filename)
    unzip(temp_zip_filename)
    file.remove(temp_zip_filename) 
    file.rename("UCI HAR Dataset", "data")
  }
}

##
## Reads all data, introduces column names and merges into one dataset
##
read_data <- function() {

  # Read features which will become column names in the x_* dataset
  features <- read_table2("data/features.txt", col_names = c("id", "description"))
  
  # Read test data
  x_test       <- read_table("data/test/X_test.txt",       col_names = features$description)
  y_test       <- read_table("data/test/y_test.txt",       col_names = "activity")
  subject_test <- read_table("data/test/subject_test.txt", col_names = "subject")
  test         <- cbind(subject_test, y_test, x_test)
  
  # Read train data
  x_train       <- read_table("data/train/X_train.txt",       col_names = features$description)
  y_train       <- read_table("data/train/y_train.txt",       col_names = "activity")
  subject_train <- read_table("data/train/subject_train.txt", col_names = "subject")
  train <- cbind(subject_train, y_train, x_train)
  
  # Bind them all and return
  rbind(test, train)
}

##
## Selects collumns from df that matches "mean" and "sd", also conserving Subject and Label
##
extract_mean_sd <- function(df) {
  df %>% select(subject, activity, contains("mean"), contains("std"))
}

##
## Replaces label integer column with the correspondent activity names
##
labels_to_factors <- function(df) {
  
  # Read activity labels
  labels <- read_table("data/activity_labels.txt", col_names = c("id", "label"))
  
  # Mutate the dataset to match the integer with the label
  df %>% mutate(activity = factor(activity, levels = labels$id, labels = labels$label))
}

# download_data()
har_df <- read_data() %>%  ## Solution to requests (1) and (4)
  extract_mean_sd() %>%    ## Solution to request (2)
  labels_to_factors()      ## Solution to request (3)

## Solution to request (5)
averages <- har_df %>% 
  group_by(activity, subject) %>% 
  summarise(mean)
