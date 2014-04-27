The run_analysis.R description:
========================================================

README
--------------------------------------------------------
Step 0:

The source data for this project is available at following link:
url= https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Step 1: Merges the training and the test sets to create one data set.
a. Download the file from source location using download.file(),  store it on local drive.
b. Unzip the directory and store on local drive. 
c. Read the test and training directory for X_test.txt in a variable called set1 of data.frame() type  and X_train.txt in a variable called set2 of data.frame() type using read.table(), with additional parameter like header = FALSE, sep = “”.  
d. Combine both X_test and X_train using  rbind() in a  variables called X. 
e. Repeat steps 1c-1d for subject_test.txt and subject_training.txt and Y_test.txt and Y_train.txt, save the data frame by names S and Y, respectively. 

Step 2. Extraction of the measurements on the mean and standard deviation.
a. Read the features.txt as describe in step 1(c) in a variable called feature.
b. Extract the column names with mean and std using grep() in variable called the good_features.
c. Set the column name of the data frame X using good_feature. 
d. Remove the (), space and from the column names of the X data frame 
e. change column names to all lowercase.


Step 3. Uses descriptive activity names to name the activities in the data set
a. Read the activity_labels.txt to include same activity names as described in 1(c).
b. change the all the activities to lowercase.
c. Change the name of the column in Y data frame saved earlier with activities which has all the names.
 
Step 4. Appropriately labels the data set with descriptive activity names.
a. Change the subject names. 
b. Complete the data by combining the data frames S, Y and X which has now subject and activity column using cbind() function. The output is called “complete”.
c. Write the out put in a file using write.table (). Save it on local disc. 

Step 5. Creates another independent tidy data set with the average of each variable for each activity and each subject. 
Here I have used melt and cast functions from package reshape2.
a. load the package reshape2 in R.
b. Use melt function with previously saved “complete” dataset with id as subject and activity.
c. dcast, using inbuilt function dcast() with formula and mean to get the mean. 
c. Save the output on local disc as described in 4(c). 