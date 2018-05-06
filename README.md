# Getting and Cleaning Data Course Project
## Programming Assignment - Human Activity Recognition Using Smartphones Data Set
## 


## Behavior

When running the script, the indicated operations will ocurr:

1. Download data if needed
2. Produce a tidy dataset, assigning proper variable names, having one table per observational unit
3. Transforms the activity numbers into their labels to have more declarative data.
4. Creates a second tidy dataset, which contains all variables averaged grouped by activity and subject

## Functions

#### download_data()

1. Download the dataset from the source
2. Unzips the data into a "data" folder

#### read_data(data.frame) -> data.frame
Solution to requests (1) and (4)

1. Loads the variable names dataset
2. Loads the test data, binding the subject column and the activity number column. Assigns the variable names read in step 1.
3. Loads the train data, binding the subject column and the activity number column. Assigns the variable names read in step 1.
4. Binds both test and train datasets into one.


#### extract_mean_sd(data.frame) -> data.frame
Solution to request (2)

Extracts columns which names matches "mean" or "std", while also keeping _subject_ and _activity_ columns

#### labels_to_factors(data.frame) -> data.frame
Solution to request (3)

Replaces label integer column with the correspondent activity names

#### produce_averages(data.frame) -> data.frame
Solution to request (5)

Average all variables grouped by activity and subject.
