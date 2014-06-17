## 1. Merges the training and the test sets to create one data set.

## read features and activity labels
features <- read.table("./features.txt", stringsAsFactors = FALSE)
activities <- read.table("./activity_labels.txt")

## combine test data into 1 dataset
## result data set is like:
## | subjects | activities | .....561 cols of related data |
test.data <- read.table("./test/X_test.txt")
test.activities <- read.table("./test/y_test.txt")
test.subjects <- read.table("./test/subject_test.txt")
test.set <- cbind(test.subjects, test.activities, test.data)

## combine train data into 1 dataset
## result data set is like:
## | subjects | activities | .....561 cols of related data |
train.data <- read.table("./train/X_train.txt")
train.activities <- read.table("./train/y_train.txt")
train.subjects <- read.table("./train/subject_train.txt")
train.set <- cbind(train.subjects, train.activities, train.data)

## merge header data read from features set
header <- c("subjects", "activities")
header <- c(header, features[,2])
master.set <- rbind(test.set, train.set)
names(master.set) <- header 

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
header.filter <- which(grepl("mean\\(\\)", header) | grepl("std\\(\\)", header) )
header.filter <- c(1, 2, header.filter)
master.set <- master.set[, header.filter]

## 3. Uses descriptive activity names to name the activities in the data set
master.set.activities <- master.set[, c("activities")]

for (i in activities[,1]) {
    master.set.activities <- sub(i, tolower(activities[i,2]), master.set.activities)
}
master.set[, c("activities")] <- master.set.activities

## 4. Appropriately labels the data set with descriptive variable names.
header <- names(master.set)
header <- gsub("-mean\\(\\)-X", " x axis mean", header)
header <- gsub("-mean\\(\\)-Y", " y axis mean", header)
header <- gsub("-mean\\(\\)-Z", " z axis mean", header)
header <- gsub("-std\\(\\)-X", " x axis std deviation", header)
header <- gsub("-std\\(\\)-Y", " y axis std deviation", header)
header <- gsub("-std\\(\\)-Z", " z axis std deviation", header)
header <- gsub("-mean\\(\\)", " mean", header)
header <- gsub("-std\\(\\)", " std deviation", header)
header <- gsub("tBodyAcc", "body acc time signals", header)
header <- gsub("fBodyAcc", "body acc freq signals", header)
header <- gsub("tGravityAcc", "gravity acc time signals", header)
header <- gsub("fGravityAcc", "gravity acc freq signals", header)
header <- gsub("tBodyGyro", "gyroscope time signals", header)
header <- gsub("fBodyGyro", "gyroscope freq signals", header)
header <- gsub("Mag", " magnitude", header)
header <- gsub("Jerk", " Jerk", header)
header <- gsub("fBodyBodyAcc", "body acc freq signals", header)
header <- gsub("fBodyBodyGyro", "gyroscope freq signals", header)
names(master.set) <- header

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
means <- data.frame()

for (i in 1:30) {
    for (j in activities[,2]) {
       x <- master.set[master.set$subjects == i & master.set$activities == tolower(j),]
       colmeans <- numeric()
       
       for (k in 3:ncol(x)) {
           colmeans <- c(colmeans, mean(x[,k]))
       }
       
       means <- rbind(means, colmeans)
    }
}

result <- data.frame(rep(1:30, each=6), rep(tolower(activities[,2]), 30), means)
names(result) <- header

write.table(result, file="./tidyset.txt", row.names = FALSE)