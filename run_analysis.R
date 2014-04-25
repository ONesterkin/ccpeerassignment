#Common stuff
##Column names
###Reading column names
colnames <- read.table("features.txt")
###Cleaning colnames of special characters and making them lowercase
colnames$V3 <- tolower(gsub("[\\.\\(\\)\\,0123456789]*",
                            "",
                            colnames$V2))
colnames$V3 <- gsub("\\-", "_", colnames$V3)
colnames$V3 <- gsub("_$", "", colnames$V3)

###Creating logical vector of which columns to keep
colkeep <- grepl("mean\\(\\)",
                 colnames$V2) | 
  grepl("std\\(\\)",
        colnames$V2)

##Activity names
activitynames <- read.table("activity_labels.txt")
activitynames$V2 <- tolower(activitynames$V2)

#Dealing with trainset
##Trainset itself
###Reading trainset
train <- read.table("train/X_train.txt")
###Renaming column names in dataset
names(train) <- colnames$V3
###Removing unnecessary columns from dataset
train <- train[,colkeep]

##Trainset activities
###Reading activities for trainset
trainactivities <- read.table("train/y_train.txt")
###Friendly name for activity column
names(trainactivities)[1]<-"activity"
###Converting activities to factors
trainactivities$activity <- factor(trainactivities$activity)
###Adding friendly names to activities, as stored in activitynames
levels(trainactivities$activity) <- activitynames$V2
###Binding activities to trainset
train <- cbind(trainactivities,train)

##Subjects
###Reading trainset
trainsubjects <- read.table("train/subject_train.txt")
###Friendly name for subject column
names(trainsubjects)[1] <- "subject"
###Binding subjects to dataset
train <- cbind(trainsubjects,train)


#Dealing with TESTset
##Trainset itself
###Reading trainset
test <- read.table("test/X_test.txt")
###Renaming column names in dataset
names(test) <- colnames$V3
###Removing unnecessary columns from dataset
test <- test[,colkeep]

##Trainset activities
###Reading activities for trainset
testactivities <- read.table("test/y_test.txt")
###Friendly name for activity column
names(testactivities)[1]<-"activity"
###Converting activities to factors
testactivities$activity <- factor(testactivities$activity)
###Adding friendly names to activities, as stored in activitynames
levels(testactivities$activity) <- activitynames$V2
###Binding activities to trainset
test <- cbind(testactivities,test)

##Subjects
###Reading trainset
testsubjects <- read.table("test/subject_test.txt")
###Friendly name for subject column
names(testsubjects)[1] <- "subject"
###Binding subjects to dataset
test <- cbind(testsubjects,test)

#Merging test and train
final <- rbind(train,test)

#Another dataset
###Loading library for reshaping dataset
library(reshape2)
###Melting dataq
fmolten <- melt(final, id=c("subject", "activity"))
###Creatint new dataset with means of MEAN() and STD() as columns
final2 <- dcast(fmolten, formula = subject + activity ~ variable, fun.aggregate=mean)

#Exporting data
write.table(final, "final.txt", row.names=FALSE)
write.table(final2, "final2.txt", row.names=FALSE)
