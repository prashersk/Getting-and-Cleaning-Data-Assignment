# The source of data for this project is available at following link:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.
# Download the file from source location
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", method="curl", destfile="uciData.zip") 

#Unzip the files and read the desired text files and combine them together
unzip("/Users/satyendrakumar/uci.zip", exdir="UCIdataset")  
setwd("/Users/satyendrakumar/UCIdataset") 

set1 <- read.table("train/X_train.txt", header=FALSE, sep="") 
set2 <- read.table("test/X_test.txt", header=FALSE, sep="") 
X <- rbind(set1, set2) 

set1 <- read.table("train/subject_train.txt", header=FALSE, sep="") 
set2 <- read.table("test/subject_test.txt", header=FALSE, sep="")
S <- rbind(set1, set2)

set1 <- read.table("train/y_train.txt", header=FALSE, sep="")
set2 <- read.table("test/y_test.txt", header=FALSE, sep="")
Y <- rbind(set1, set2)

# 2. Extraction of the measurements with the mean and standard deviation.

features <- read.table("features.txt")  
good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2]) 
X <- X[, good_features] 
names(X) <- features[good_features, 2] 
names(X) <- gsub("\\(|\\)", "", names(X)) 
names(X) <- tolower(names(X)) 

# 3. Use of descriptive activity names in the data set

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
complete <- cbind(S, Y, X)
write.table(complete, "First_data.txt") 
head(complete)
# 5. Creates second independent tidy data set with the average of each variable for each activity and each subject. Here i have used melt and cast functions from package reshape2

require(reshape2)
Melted <- melt(complete, id = c("activity", "subject"))
Decasted <- dcast(Melted, formula = subject + activity ~ variable, mean)

write.table(Decasted, "TidyData_with_averages.txt")

