# Download the dataset
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")

# Unzip the dataset
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")

# 1. Merge the training and test datasets

# 1.1 Reading files

#Read the Activity files

dataActivityTest  <- read.table("./getcleandata/UCI HAR Dataset/test/X_test.txt",header = FALSE)
dataActivityTrain <- read.table("./getcleandata/UCI HAR Dataset/train/x_train.txt",header = FALSE)

#Read the Subject files
dataSubjectTrain <- read.table("./getcleandata/UCI HAR Dataset/train/subject_train.txt",header = FALSE)
dataSubjectTest  <- read.table("./getcleandata/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

#Read Fearures files
dataFeaturesTest  <- read.table("./getcleandata/UCI HAR Dataset/features.txt",header = FALSE)
#dataFeaturesTrain <- read.table("./getcleandata/UCI HAR Dataset/features_info.txt",header = FALSE)

# 1.2 Look at the properties of the above varibles
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)
str(dataFeaturesTest)
str(dataFeaturesTrain)

#1.3 Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
#dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

#1.4set names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table("./getcleandata/UCI HAR Dataset/features.txt",header = FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

#1.4 Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

#Extracts only the measurements on the mean and standard deviation for each measurement
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

str(Data)

#Uses descriptive activity names to name the activities in the data set
#Read descriptive activity names from “activity_labels.txt”
activityLabels <- read.table("./getcleandata/UCI HAR Dataset/activity_labels.txt",header = FALSE)
head(Data$activity,30)

#Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

names(Data)

#Creates a second,independent tidy data set and ouput it
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)


