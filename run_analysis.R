# Class Project

# Read data into R. This is the directory structure on my MAC
#features <- read.table("./UCI HAR Dataset/features.txt")
#activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
#ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
#xtest <- read.table("./UCI HAR Dataset/test/x_test.txt")
#stest <- read.table("./UCI HAR Dataset/test/subject_test.txt") #subject_test
#ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
#xtrain <- read.table("./UCI HAR Dataset/train/x_train.txt")
#strain <- read.table("./UCI HAR Dataset/train/subject_train.txt") #subject train

# The instructions call for a flat directory structure. 
# This expects all files to reside at the same directory at the R script
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")
ytest <- read.table("y_test.txt")
xtest <- read.table("x_test.txt")
stest <- read.table("subject_test.txt") #subject_test
ytrain <- read.table("y_train.txt")
xtrain <- read.table("x_train.txt")
strain <- read.table("subject_train.txt") #subject train

# Merge the training and the test sets to create one data set
xdata <- rbind(xtest,xtrain) #merged test and train data (x-files)
ydata <- rbind(ytest,ytrain) #merged test and train activity labels, range 1-6, (y-files)
sdata <- rbind(stest,strain) #merdged subject labels, range 1-30, (s-files)

# subset_data is a data.frame with only the mean and standard deviation for each measurement
# 79 columns overall. I elected to disregard other columns with "Mean" etc.
names_vector <- features[,"V2"] #name columns of xdata
names(xdata) <- names_vector
subset_names <- grep("mean()|std()",names_vector) #grep names containing either mean() or std()
sub_data <- xdata[,subset_names]

# Use descriptive activity names to name the activities in the data set
# numbered activity names (range 1:6) are in "ydata" created above. 
names(ydata) <- "activity" #change column name from "V1" to "activity"
names(sdata) <- "subject"
sub_data <- cbind(sub_data,ydata) # merge activity still in numbers form into sub_data
sub_data <- cbind(sub_data,sdata) # merge with subject numbers (range 1:30)
sub_data$activity <- activities[sub_data$activity,2] # replace activity numbers by activity names

# Appropriately label the data set with descriptive variable names
clean_names <- make.names(names(sub_data), unique=TRUE)
clean_names <- gsub("\\.\\.\\.", "\\.", clean_names) #replace tripple or double "." with "."
clean_names <- gsub("\\.+$","", clean_names) #remove "." from the end of the names
names(sub_data) <- clean_names # replace names with the clean_names

# create a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
# sub_data dim are [10299, 81], where the last columns are "activity" and "subject"

# install.packages("dplyr")
library(dplyr) # may have to install the package by removing the comment above
library(reshape2)

molten_data <- melt(sub_data, id=c("subject", "activity")) #columns: subject, activity, variable, value
grouped_data <- group_by(molten_data, subject, activity, variable)
summary <- summarise(grouped_data, mean(value)) # results in 4 columns and 14220 lines

#alternatively, I could have casted "molten_data" into 180 rows by 81 columns; a columns per
# each of the 79 measurements + two columns for "subject" and "activity". The followin line 
# would have done the job

# summary <- dcast(molten_data, subject + activity ~ variable, mean)


