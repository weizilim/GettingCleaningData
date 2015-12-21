#load packages
library(downloader)
library(dplyr)
library(data.table)

#create directory if doesnt exist
if (!file.exists("GettingCleaningData")){
    dir.create("GettingCleaningData")
}

#set working directory
setwd("GettingCleaningData")

#download file
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, "./Dataset.zip")
unzip("Dataset.zip")

##TEST files===========================================================================================

#read activity file
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("label_id","activity"))

#read features file
features <- read.table("UCI HAR Dataset/features.txt")
#identify mean & std columns
index <- grep("mean\\()|std\\()", features[,2])
names <- features[index,2]
#derive column names
names <- gsub("\\()","",names)
names <- gsub("-","_", names)

#test files
subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="subj_id")
y_test    <- read.table("UCI HAR Dataset/test/y_test.txt", col.names="label_id") %>%
             merge(activity_labels, by="label_id")

#select mean & std columns
x_test    <- read.table("UCI HAR Dataset/test/X_test.txt")[,index]
colnames(x_test) <- names

#merge with subject id and activity label
test      <- cbind(subj_test, y_test) %>% 
             cbind(x_test) %>% 
             subset(select=-label_id)

##TRAIN files================================================================================

subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="subj_id")
y_train    <- read.table("UCI HAR Dataset/train/y_train.txt", col.names="label_id") %>%
              merge(activity_labels, by="label_id")

#select mean & std columns
x_train    <- read.table("UCI HAR Dataset/train/X_train.txt")[,index]
colnames(x_train) <- names

#merge with subject id and activity label
train      <- cbind(subj_train, y_train) %>%
              cbind(x_train) %>%
              subset(select=-label_id)

##MERGE test & train==========================================================================

data <- rbind(test, train)

##TIDY data===================================================================================

tidy_data <- data.table(data)[,lapply(.SD, mean),by=c("subj_id","activity"), .SDcols=3:68]

#export file
write.table(tidy_data, "tidy_data.csv", row.names=F)


