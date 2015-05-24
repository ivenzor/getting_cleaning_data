## The following code is logically divided in several sections
## Section 1 will produce the merged data set
## Section 2 will provide meaningful column names
## Section 3 will put activity names instead of numbers
## Section 4 will save the first tidy data set
## Section 5 will compute the average of each variable for each activity and each subject
## Section 6 will save the second tidy data set
##
## Note1: plyr and reshape2 libraries are going to be used
## Note2: it is assumed the source zip file was unzipped in the working directory
##
##
##  Section 1	##
##
## activity labels will be used later on
actLab <- read.table("./activity_labels.txt")
## read the test-related files
testSub <- read.table("./test/subject_test.txt")
testFeat <- read.table("./test/X_test.txt")
testAct <- read.table("./test/y_test.txt")
## read the features file to be able to filter columns
features <- read.table("./features.txt")
## only mean and standard deviation measurements are needed
## meanFreq columns are also discarded
meansdt <- grep("Freq",grep("mean|std", features$V2, value=TRUE), value=TRUE, invert=TRUE)
testFeat <- testFeat[,features[features$V2 %in% meansdt,1]]
## merge the test-related files
test <- cbind(testSub,testAct)
test <- cbind(test,testFeat)
## read the training-related files
traiSub <- read.table("./train/subject_train.txt")
traiFeat <- read.table("./train/X_train.txt")
traiAct <- read.table("./train/y_train.txt")
## filter columns
traiFeat <- traiFeat[,features[features$V2 %in% meansdt,1]]
## merge the training-related files
trai <- cbind(traiSub,traiAct)
trai <- cbind(trai,traiFeat)
## merge both data sets
tidy1 <- rbind(test,trai)
##
##	Section 2	##
##
## change column names to be more readable or fix potencially illegal characters
from <- c('tBody','tGravity','f','Gyro','Acc','Mag','BodyBody','\\(\\)','\\-','mean','std')
to <- c('TDSBody','TDSGravity','FDS','Gyroscope','Accelerometer','Magnitude','Body','','','Mean','STD')
replaces <- function(pattern, replacement, x, ...) {
  for(i in 1:length(pattern))
    x <- gsub(pattern[i], replacement[i], x, ...)
  x
}
newcolumns <- replaces(from, to, meansdt)
## asign new column names
colnames(tidy1) <- c("volunteerID","activity",newcolumns)
##
##	Section 3	##
##
## replace activity numbers with the correct string
tidy1$activity <- as.factor(tidy1$activity)
library(plyr)
tidy1$activity <- mapvalues(tidy1$activity, from = actLab$V1, to = as.character(actLab$V2))
##
##	Section 4	##
##
## save first tidy data set
write.table(tidy1, file="tidy1.txt")
##
##	Section 5	##
##
## compute the average of each variable for each subject and each activity
library(reshape2)
melted <- melt(tidy1,id=names(tidy1)[1:2])
tidy2 <- dcast(melted, volunteerID+activity ~ variable, fun.aggregate = mean, na.rm = TRUE)
##
##	Section 6	##
##
## save second tidy data set wich will be uploaded to coursera
write.table(tidy2, file="tidy2.txt",row.name=FALSE)