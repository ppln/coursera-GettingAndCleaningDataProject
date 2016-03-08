library(plyr)

fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"

# download the dataset
if(!file.exists(fileName)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, fileName)
}

folderName <- "UCI HAR Dataset"
# unzip dataset
if(!file.exists(folderName)){
  unzip(fileName)
}

# read activity_labels and features
activity_labels <- read.table( paste(folderName, "/activity_labels.txt", sep = ""), colClasses = "character" )
features <- read.table( paste(folderName, "/features.txt", sep = "") )

# extract only the measurements on the "mean" and "standard deviation"
feature_extract_cols <- grep("mean\\(\\)|std\\(\\)", features[, 2])
# activity names
feature_extract_colnames <- gsub("mean\\(\\)", "Mean", features[feature_extract_cols, 2])
feature_extract_colnames <- gsub("std\\(\\)", "Std", feature_extract_colnames)

# read and assemble test dataset
subject_test <- read.table( paste(folderName, "/test/subject_test.txt", sep = "") )
x_test <- read.table( paste( folderName, "/test/X_test.txt", sep = "") )[feature_extract_cols]
y_test <- read.table( paste( folderName, "/test/y_test.txt", sep = "") )
test <- cbind(subject_test, y_test, x_test)

# read and assemble train dataset
subject_train <- read.table( paste(folderName, "/train/subject_train.txt", sep = "") )
x_train <- read.table( paste( folderName, "/train/X_train.txt", sep = "") )[feature_extract_cols]
y_train<- read.table( paste( folderName, "/train/y_train.txt", sep = "") )
train <- cbind(subject_train, y_train, x_train)

# merge test and train dataset
data <- rbind(train, test)
# set activity names
colnames(data) <- c("subject", "activity", feature_extract_colnames)
data$activity <- mapvalues(data$activity, from = activity_labels[,1], to = activity_labels[,2])

# calculate average of each variable for each activity and each subject.
dataOUt <- ddply(data, c("subject", "activity"), numcolwise(mean))

# output the tidy data set
write.table(dataOUt, file = "tidy.txt", row.names = FALSE)
