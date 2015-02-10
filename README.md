# Getting And Cleaning Data Project Assignment

## Introduction
This is the description of the steps taken to complete the project assignment associated with the Getting and Cleaning Data Coursera course.

* Stephen Hunt
* 2015-02-10

## Execution Steps

### Step 1
Set the working directory, so that the zip file can be downloaded to a consistent folder structure.

### Step 2
List any libraries that we be used in the script.

### Step 3
Download the zip file from the internet to the working folder, as per the instructions in the assignment.

### Step 4
Create the zip file path using the working folder, which will be used later to define where the files are extracted to.

### Step 5
Unzip the Dataset.zip file previously downloaded, and overwrite extracted files if previously downloaded.

### Step 6
Unzip folder directory used for reference later, assumes all unzipped files are contained in the "UCI HAR Dataset" folder.  The extraction process will populate a number of folders and files, and for the purposes of the assignment we are interested in extracting data from the following files:-

* train/subject_train.txt
* train/X_train.txt
* train/Y_train.txt
* test/subject_test.txt
* test/X_test.txt
* test/Y_test.txt

### Step 7
Create variables to define the file paths of each file listed above

### Step 8
Now extract each of the files into data frames.  Both the "Subject" and "Y" files only have one attributes, whereas the "X" files have many hundred attributes.  All attributes are to be "numeric" data types, and read.file() uses strip.white=TRUE to assist with the fixed with format of the source files.

### Step 9
The previous step will automativally assign default attribute names, e.g. V1, V2... therefore we need to rename "Subject" and "Y" V1 columns to make attributes names unique across all data frames otherwise there will be multiple V1 column names when merging data frames.

### Step 10
As the train and test data frames have the same number of rows we can use the cbind() function to merge the three respective data frames (X, Y, Subject).

### Step 11
Tidy up memory and remove the unwanted data frames, as the previous step created new data frames.

### Step 12
Now in a position to row bind using the rbind() function (dfTrain, dfTest) to create a single data frame called df.

### Step 13
Tidy up memory and remove the unwanted data frames

### Step 14
Going to use dplyr package, so lets wrap the data frame in the tbl_df() function, and remove the existing data frame (df).

### Step 15
We need to take a reduced set/range of columns before renaming them, refer to the code book for the list of columns to be extrated.  Will use the dply select() function with a series of column ranges.  This will create a new data frame called dfSelectCols which represents a wide tidy data set.

### Step 16
Now rename "V" columns with meaningful descriptions based on the code book instructions and creates a new data frame called dfRenamedCol.

### Step 17
Using the dplyr functionality, group the data by Subject and Activity so the next step can aggregate the data, the grouping object is called dfAggSubjectActivity.

### Step 18
Aggregate the dfAggSubjectActivity object, calculating the mean values by the previous grouping using a prefix of "Mean." before the column name.  Create a new data frame called dfAggByMean.

### Step 19
Create the file called ProjectStep5.txt, with the write.table() command and using the argument row.name=FALSE as per Step 5 instructions.

That completes the steps for the project assignment.

