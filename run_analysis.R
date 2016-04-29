###############################################################################
# R Version 3.2.4 Revised (2016-03-16 r70336)
# plyr package Version ‘1.8.3’ 
# Date:
# Written By: R. I. Chowdhury
##############################################################################

library(plyr)
setwd("D:\\CoursERA\\C3W4")


# Preprocessing: download and unzip the data
 
  if (!file.exists("getdata_data.zip")){
     fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     download.file(fileURL, destfile="getdata_data.zip")
  }
   unzip("getdata_data.zip")
                                                                               
# Step-1: merge the training and test data sets

 # Finding column classes to make fatser read of X_data only
 
 inread      <- read.table("./UCI HAR Dataset/train/X_train.txt",nrows=10)
 classes     <- sapply(inread,class)
 
# Reading and meging tarin, test data sets and adding sampleType column to identify "Train" and "Test" samples
 
 merged_data <- cbind(rbind(cbind(sampleType=1,read.table("./UCI HAR Dataset/train/subject_train.txt",col.names="subjectId"),
                            read.table("./UCI HAR Dataset/train/y_train.txt",col.names="activityType")),
                            cbind(sampleType=2,read.table("./UCI HAR Dataset/test/subject_test.txt",col.names="subjectId"),
                                  read.table("./UCI HAR Dataset/test/y_test.txt",col.names="activityType"))),
                      rbind(read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = classes),
                            read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = classes)))
 
# Converting  sampleType  column as factor with coresponding labels
                            
    merged_data$sampleType   <- factor(merged_data$sampleType, 
                                labels=c("Train","Test"))
  
# Step-2: Extract mean and SD  
 # reading features data
   features <- read.table("./UCI HAR Dataset/features.txt")
 
 # Identifying column locations for mean and sd
 
   mean_std_features <- grep("-mean\\(\\)|-std\\(\\)",features$V2)
   mean_std_features_cols <- c(1:3,(mean_std_features+3L))
   merged_data       <-   merged_data[,mean_std_features_cols]
 
# Step-3: Uses descriptive activity name to name the activities 

   activities       <- read.table("./UCI HAR Dataset/activity_labels.txt")
   merged_data[,3]  <-    activities[merged_data[,3],2]  
 
#Step-4 Appropriately lables the data set with descriptive variable names 

   feature_names     <- features[mean_std_features, 2]
   colnames(merged_data)[4:ncol(merged_data)]<-paste(feature_names) 
      
# Step-5  Second data set of averages for each variable by subject acitivity

 average_data     <- ddply(merged_data, .(subjectId, activityType), 
                     function(X) colMeans(X[,4:69]))                        

 write.table(merged_data, "merged_data_tidy.txt", row.names=FALSE)
 write.table(average_data, "average_data.txt", row.names=FALSE)
 
 #end of program
 
 