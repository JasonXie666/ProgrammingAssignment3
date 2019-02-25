#Loading library
library(data.table)
library(dplyr)

#Getting files ready
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"./project.zip")
unzip("project.zip")

#Read all files
XTest <- read.table("UCI HAR Dataset/test/X_test.txt")
YTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

XTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

#Create merged datasets Question#1
X <- rbind(XTest, XTrain)
Y <- rbind(YTest, YTrain)
Subject <- rbind(SubjectTest, SubjectTrain)

#Getting all mean/std indeces for X Question#2
index <- grep("mean\\(\\)|std\\(\\)", features[,2])
X <- X[,index]

#Replace numbers to correlated values from activity Question#3
Y[,1] <- activity[Y[,1],2]

#Label whole data set with descriptive names Question#4
names <- features[index,2]

names(X) <- names
names(Subject) <- "SubjectID"
names(Y) <- "Activity"
tidy <- cbind(Subject, Y, X)

#Create another data set Question#5
table <- data.table(tidy)
tidy1 <- table[, lapply(.SD, mean), by = 'SubjectID,Activity']
write.table(tidy1, file = "Tidy1.txt", row.names = FALSE)








