
## Objectives 1-4

## Read in data from files, adding in column names when necessary
subject_test <- read.table("./test/subject_test.txt",col.names = "subject_id")
test_activity <- read.table("./test/y_test.txt",col.names = "activity_id")

subject_train <- read.table("./train/subject_train.txt",col.names = "subject_id")
train_activity <- read.table("./train/y_train.txt",col.names = "activity_id")

activity_label <- read.table("activity_labels.txt",col.names = c("activity_id", "activity"))
features <- read.table("features.txt")

## Read in train and test datasets using features dataset to name columns
train <- read.table("./train/x_train.txt",col.names = features[,2])
test <- read.table("./test/x_test.txt",col.names = features[,2])


## Create unique ID across tables
subject_test$id = paste("test",1:nrow(subject_test),sep="")
test_activity$id = paste("test",1:nrow(test_activity),sep="")
test$id = paste("test",1:nrow(test),sep="")

subject_train$id = paste("train",1:nrow(subject_train),sep="")
train_activity$id = paste("train",1:nrow(train_activity),sep="")
train$id = paste("train",1:nrow(train),sep="")


## Combine the test and train datasets vertically
testtrain <- rbind(test,train)
subject <- rbind(subject_test,subject_train)
activity <- rbind(test_activity,train_activity)

## Re-arrange columns in subject table
subject <- subject[c(2,1)]

## Merge data into final dataset
library(plyr)
library(dplyr)
dfList = list(subject,activity,activity_label,testtrain)
mergedData <- join_all(dfList)

## Extract only the measurements on the mean and standard deviation for each measurement. 
mean_std <- c(1:10,45:50,85:90,125:130,165:170,205:206,244:245,270:275,349:354,428:433,507:508)
mergedData <- mergedData[,mean_std]


## Objective 5

## Create interaction variable with subject and activity
mergedData$s_a = interaction(mergedData$subject_id, mergedData$activity_id)

## Save subject and activity IDs
temp <- unique(cbind(subject_id = mergedData$subject_id, activity_id = mergedData$activity_id, s_a = mergedData$s_a))
temp <- arrange(data.frame(temp), s_a)

## Initialize mean matrix       
meanS_A <- matrix(nrow = 54,ncol = 180)


## Calculate measurement means over subject/activity interaction variable              
for(i in 5:58) { 
        meanS_A[i-4,] <- tapply(mergedData[,i], mergedData$s_a, mean)
}

## Transpose the matrix
meanS_A <- t(meanS_A)

## Re-name Columns
r <- c(1:6,41:46,81:86,121:126,161:166,201:202,240:241,266:271,345:350,424:429,503:504)
colnames(meanS_A) <- features[r,2]
meanS_A = cbind(temp, data.frame(meanS_A))
meanS_A <- arrange(meanS_A, activity_id)

## Write table containing means for subject activities to 'meansa.txt'
write.table(meanS_A, file = "meansa.txt", row.names = FALSE)

