library(dplyr)

# 1. Download and unzip dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_file <- "Dataset.zip"
if (!file.exists(zip_file)) {
  download.file(url, zip_file, method = "curl")
}
if (!file.exists("UCI HAR Dataset")) {
  unzip(zip_file)
}

# 2. Read features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# 3. Read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# 4. Read train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 5. Merge training and test sets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# 6. Extract mean and standard deviation measurements
TidyData <- Merged_Data %>% 
  select(subject, code, contains("mean"), contains("std"))

# 7. Use descriptive activity names
TidyData$code <- activities[TidyData$code, 2]

# 8. Appropriately label the data set with descriptive variable names
names(TidyData)[2] = "activity"
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))

# 9. Create final tidy dataset with averages
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# 10. Export to txt file
write.table(FinalData, "tidy_data.txt", row.name = FALSE)
