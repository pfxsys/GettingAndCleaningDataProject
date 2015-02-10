# Step 1: Set the Working Directory to the project folder
setwd("C:/Work/Coursera/GettingAndCleaningData/Project")

# Step 2: Load libraries that contain functionality to help with the project
library("dplyr")

# Step 3: Download the zip file from the internet to the working folder
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="Dataset.zip")

# Step 4: Create the zip file path using the working folder
zipfilepath <- paste(getwd(), "/Dataset.zip", sep="") 

# Step 5: Unzip the Dataset.zip file previously downloaded, overwrite if previously downloaded
unzip(zipfilepath, overwrite=TRUE)

# Step 6: Unzip folder directory used for reference later, assumes all unzipped files are contained in the "UCI HAR Dataset" folder
unzipdir <- paste(getwd(), "/UCI HAR Dataset", sep="")

# 6 files to be merged into one complete set of data before further processing.
# train/subject_train.txt
# train/X_train.txt
# train/Y_train.txt
# test/subject_test.txt
# test/X_test.txt
# test/Y_test.txt

# Step 7: create variables to define the file paths of each file listed above
trainSubjectFilepath <- paste(unzipdir, "/train/subject_train.txt", sep="")
trainXFilepath <- paste(unzipdir, "/train/X_train.txt", sep="")
trainYFilepath <- paste(unzipdir, "/train/Y_train.txt", sep="")
testSubjectFilepath <- paste(unzipdir, "/test/subject_test.txt", sep="")
testXFilepath <- paste(unzipdir, "/test/X_test.txt", sep="")
testYFilepath <- paste(unzipdir, "/test/Y_test.txt", sep="")

# Step 8: Load all the source data files into 6 data frames, using a fixed width format 
dfTrainSubject <- read.table(trainSubjectFilepath, header=FALSE, colClasses="numeric")
dfTrainX <- read.table(trainXFilepath, header=FALSE, strip.white=TRUE, colClasses="numeric")
dfTrainY <- read.table(trainYFilepath, header=FALSE, colClasses="numeric")
dfTestSubject <- read.table(testSubjectFilepath, header=FALSE, colClasses="numeric")
dfTestX <- read.table(testXFilepath, header=FALSE, strip.white=TRUE, colClasses="numeric")
dfTestY <- read.table(testYFilepath, header=FALSE, colClasses="numeric")

# Step 9: rename Subject and Y "V1" columns to make attributes names unique across all data frames
# otherwise there will be multiple V1 column names when merging data frames
names(dfTrainSubject)[names(dfTrainSubject)=="V1"] <- "SubjectID"
names(dfTestSubject)[names(dfTestSubject)=="V1"] <- "SubjectID"
names(dfTrainY)[names(dfTrainY)=="V1"] <- "ActivityID"
names(dfTestY)[names(dfTestY)=="V1"] <- "ActivityID"

# Step 10: As the train data sets have the same number of rows we can cbind() the train data frames
dfTrain <- cbind(dfTrainSubject, dfTrainY, dfTrainX)
# As test data sets have the same number of rows we can cbind() the test data frames
dfTest <- cbind(dfTestSubject, dfTestY, dfTestX)

# Step 11: Tidy up memory and remove the unwanted data frames
rm(dfTrainSubject)
rm(dfTrainX)
rm(dfTrainY)
rm(dfTestSubject)
rm(dfTestX)
rm(dfTestY)

# Step 12: Now in a position to row bind the two data frames
df <- rbind(dfTrain, dfTest)

# Step 13: Tidy up memory and remove the unwanted data frames
rm(dfTrain)
rm(dfTest)

# Step14: Going to use dplyr, so lets wrap the data frame in the tbl_df function,and remove the existing data frame
dfRaw <- tbl_df(df)
rm(df)

# Step 15: We need to take a reduced set/range of columns before renaming them
dfSelectCols <- select(dfRaw, SubjectID, ActivityID, V1:V6, V41:V46, V81:V86, V121:V126, V161:V166, V201:V202, V214:V215, V227:V228, V240:V241, V253:V254, V266:V271, V345:V350, V424:V429, V503:V504, V516:V517, V529:V530, V542:V543)

# Step 16: Now Rename Columns with meaningful descriptions based on the code book descriptions (grouped below by observation)
dfRenamedCol <- rename(dfSelectCols, Subject_ID=SubjectID, Activity_ID=ActivityID, 
                       MeanTime_BodyAcc_X=V1, MeanTime_BodyAcc_Y=V2, MeanTime_BodyAcc_Z=V3, 
                       SDTime_BodyAcc_X=V4, SDTime_BodyAcc_Y=V5, SDTime_BodyAcc_Z=V6, 
                       MeanTime_GravityAcc_X=V41, MeanTime_GravityAcc_Y=V42, MeanTime_GravityAcc_Z=V43, 
                       SDTime_GravityAcc_X=V44, SDTime_GravityAcc_Y=V45, SDTime_GravityAcc_Z=V46, 
                       MeanTime_BodyAccJerk_X=V81, MeanTime_BodyAccJerk_Y=V82, MeanTime_BodyAccJerk_Z=V83, 
                       SDTime_BodyAccJerk_X=V84, SDTime_BodyAccJerk_Y=V85, SDTime_BodyAccJerk_Z=V86, 
                       MeanTime_BodyGyro_X=V121, MeanTime_BodyGyro_Y=V122, MeanTime_BodyGyro_Z=V123, 
                       SDTime_BodyGyro_X=V124, SDTime_BodyGyro_Y=V125, SDTime_BodyGyro_Z=V126, 
                       MeanTime_BodyGyroJerk_X=V161, MeanTime_BodyGyroJerk_Y=V162, MeanTime_BodyGyroJerk_Z=V163, 
                       SDTime_BodyGyroJerk_X=V164, SDTime_BodyGyroJerk_Y=V165, SDTime_BodyGyroJerk_Z=V166,
                       MeanTime_BodyAccMag=V201,
                       SDTime_BodyAccMag=V202,
                       MeanTime_GravityAccMag=V214,
                       SDTime_GravityAccMag=V215,
                       MeanTime_BodyAccJerkMag=V227,
                       SDTime_BodyAccJerkMag=V228,
                       MeanTime_BodyGyroMag=V240,
                       SDTime_BodyGyroMag=V241,
                       MeanTime_BodyGyroJerkMag=V253,
                       SDTime_BodyGyroJerkMag=V254,
                       MeanFreq_BodyAcc_X=V266, MeanFreq_BodyAcc_Y=V267, MeanFreq_BodyAcc_Z=V268,
                       SDFreq_BodyAcc_X=V269, SDFreq_BodyAcc_Y=V270, SDFreq_BodyAcc_Z=V271,
                       MeanFreq_BodyAccJerk_X=V345, MeanFreq_BodyAccJerk_Y=V346, MeanFreq_BodyAccJerk_Z=V347,
                       SDFreq_BodyAccJerk_X=V348, SDFreq_BodyAccJerk_Y=V349, SDFreq_BodyAccJerk_Z=V350,
                       MeanFreq_BodyGyro_X=V424, MeanFreq_BodyGyro_Y=V425, MeanFreq_BodyGyro_Z=V426,
                       SDFreq_BodyGyro_X=V427, SDFreq_BodyGyro_Y=V428, SDFreq_BodyGyro_Z=V429,
                       MeanFreq_BodyAccMag=V503,
                       SDFreq_BodyAccMag=V504,
                       MeanFreq_BodyBodyAccJerkMag=V516,
                       SDFreq_BodyBodyAccJerkMag=V517,
                       MeanFreq_BodyBodyGyroMag=V529,
                       SDFreq_BodyBodyGyroMag=V530,
                       MeanFreq_BodyBodyGyroJerkMag=V542,
                       SDFreq_BodyBodyGyroJerkMag=V543
)

# Step 17: Grouping the data by Subject_ID and Activity_ID
dfAggSubjectActivity <- group_by(dfRenamedCol, Subject_ID, Activity_ID)

# Step 18: Calculate the mean values by the previous grouping using a prefix of "Mean." before the column name
dfAggByMean <- summarize(dfAggSubjectActivity,  
                         Mean.MeanTime_BodyAcc_X=mean(MeanTime_BodyAcc_X), 
                         Mean.MeanTime_BodyAcc_Y=mean(MeanTime_BodyAcc_Y), 
                         Mean.MeanTime_BodyAcc_Z=mean(MeanTime_BodyAcc_Z), 
                         Mean.SDTime_BodyAcc_X=mean(SDTime_BodyAcc_X), 
                         Mean.SDTime_BodyAcc_Y=mean(SDTime_BodyAcc_Y), 
                         Mean.SDTime_BodyAcc_Z=mean(SDTime_BodyAcc_Z), 
                         Mean.MeanTime_GravityAcc_X=mean(MeanTime_GravityAcc_X), 
                         Mean.MeanTime_GravityAcc_Y=mean(MeanTime_GravityAcc_Y), 
                         Mean.MeanTime_GravityAcc_Z=mean(MeanTime_GravityAcc_Z), 
                         Mean.SDTime_GravityAcc_X=mean(SDTime_GravityAcc_X), 
                         Mean.SDTime_GravityAcc_Y=mean(SDTime_GravityAcc_Y), 
                         Mean.SDTime_GravityAcc_Z=mean(SDTime_GravityAcc_Z), 
                         Mean.MeanTime_BodyAccJerk_X=mean(MeanTime_BodyAccJerk_X), 
                         Mean.MeanTime_BodyAccJerk_Y=mean(MeanTime_BodyAccJerk_Y), 
                         Mean.MeanTime_BodyAccJerk_Z=mean(MeanTime_BodyAccJerk_Z), 
                         Mean.SDTime_BodyAccJerk_X=mean(SDTime_BodyAccJerk_X), 
                         Mean.SDTime_BodyAccJerk_Y=mean(SDTime_BodyAccJerk_Y), 
                         Mean.SDTime_BodyAccJerk_Z=mean(SDTime_BodyAccJerk_Z), 
                         Mean.MeanTime_BodyGyro_X=mean(MeanTime_BodyGyro_X), 
                         Mean.MeanTime_BodyGyro_Y=mean(MeanTime_BodyGyro_Y), 
                         Mean.MeanTime_BodyGyro_Z=mean(MeanTime_BodyGyro_Z), 
                         Mean.SDTime_BodyGyro_X=mean(SDTime_BodyGyro_X), 
                         Mean.SDTime_BodyGyro_Y=mean(SDTime_BodyGyro_Y), 
                         Mean.SDTime_BodyGyro_Z=mean(SDTime_BodyGyro_Z), 
                         Mean.MeanTime_BodyGyroJerk_X=mean(MeanTime_BodyGyroJerk_X), 
                         Mean.MeanTime_BodyGyroJerk_Y=mean(MeanTime_BodyGyroJerk_Y), 
                         Mean.MeanTime_BodyGyroJerk_Z=mean(MeanTime_BodyGyroJerk_Z), 
                         Mean.SDTime_BodyGyroJerk_X=mean(SDTime_BodyGyroJerk_X), 
                         Mean.SDTime_BodyGyroJerk_Y=mean(SDTime_BodyGyroJerk_Y), 
                         Mean.SDTime_BodyGyroJerk_Z=mean(SDTime_BodyGyroJerk_Z),
                         Mean.MeanTime_BodyAccMag=mean(MeanTime_BodyAccMag),
                         Mean.SDTime_BodyAccMag=mean(SDTime_BodyAccMag),
                         Mean.MeanTime_GravityAccMag=mean(MeanTime_GravityAccMag),
                         Mean.SDTime_GravityAccMag=mean(SDTime_GravityAccMag),
                         Mean.MeanTime_BodyAccJerkMag=mean(MeanTime_BodyAccJerkMag),
                         Mean.SDTime_BodyAccJerkMag=mean(SDTime_BodyAccJerkMag),
                         Mean.MeanTime_BodyGyroMag=mean(MeanTime_BodyGyroMag),
                         Mean.SDTime_BodyGyroMag=mean(SDTime_BodyGyroMag),
                         Mean.MeanTime_BodyGyroJerkMag=mean(MeanTime_BodyGyroJerkMag),
                         Mean.SDTime_BodyGyroJerkMag=mean(SDTime_BodyGyroJerkMag),
                         Mean.MeanFreq_BodyAcc_X=mean(MeanFreq_BodyAcc_X), 
                         Mean.MeanFreq_BodyAcc_Y=mean(MeanFreq_BodyAcc_Y), 
                         Mean.MeanFreq_BodyAcc_Z=mean(MeanFreq_BodyAcc_Z),
                         Mean.SDFreq_BodyAcc_X=mean(SDFreq_BodyAcc_X), 
                         Mean.SDFreq_BodyAcc_Y=mean(SDFreq_BodyAcc_Y), 
                         Mean.SDFreq_BodyAcc_Z=mean(SDFreq_BodyAcc_Z),
                         Mean.MeanFreq_BodyAccJerk_X=mean(MeanFreq_BodyAccJerk_X), 
                         Mean.MeanFreq_BodyAccJerk_Y=mean(MeanFreq_BodyAccJerk_Y), 
                         Mean.MeanFreq_BodyAccJerk_Z=mean(MeanFreq_BodyAccJerk_Z),
                         Mean.SDFreq_BodyAccJerk_X=mean(SDFreq_BodyAccJerk_X), 
                         Mean.SDFreq_BodyAccJerk_Y=mean(SDFreq_BodyAccJerk_Y), 
                         Mean.SDFreq_BodyAccJerk_Z=mean(SDFreq_BodyAccJerk_Z),
                         Mean.MeanFreq_BodyGyro_X=mean(MeanFreq_BodyGyro_X), 
                         Mean.MeanFreq_BodyGyro_Y=mean(MeanFreq_BodyGyro_Y), 
                         Mean.MeanFreq_BodyGyro_Z=mean(MeanFreq_BodyGyro_Z),
                         Mean.SDFreq_BodyGyro_X=mean(SDFreq_BodyGyro_X), 
                         Mean.SDFreq_BodyGyro_Y=mean(SDFreq_BodyGyro_Y), 
                         Mean.SDFreq_BodyGyro_Z=mean(SDFreq_BodyGyro_Z),
                         Mean.MeanFreq_BodyAccMag=mean(MeanFreq_BodyAccMag),
                         Mean.SDFreq_BodyAccMag=mean(SDFreq_BodyAccMag),
                         Mean.MeanFreq_BodyBodyAccJerkMag=mean(MeanFreq_BodyBodyAccJerkMag),
                         Mean.SDFreq_BodyBodyAccJerkMag=mean(SDFreq_BodyBodyAccJerkMag),
                         Mean.MeanFreq_BodyBodyGyroMag=mean(MeanFreq_BodyBodyGyroMag),
                         Mean.SDFreq_BodyBodyGyroMag=mean(SDFreq_BodyBodyGyroMag),
                         Mean.MeanFreq_BodyBodyGyroJerkMag=mean(MeanFreq_BodyBodyGyroJerkMag),
                         Mean.SDFreq_BodyBodyGyroJerkMag=mean(SDFreq_BodyBodyGyroJerkMag)
)

# Step 19: Create the file, with write.table and row.name=FALSE as per Step 5 instructions
write.table(dfAggByMean, file="ProjectStep5.txt", row.names=FALSE)