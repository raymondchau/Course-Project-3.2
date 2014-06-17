# Code Book for cleaned up data set
## The cleaned up data set format
#### column 1: subjects
Unique IDs representing each subject who contributes the data, range from 1 to 30.

#### column 2: activities
The different actitivies that each subject perform during the test. Variations include:

1. walking
2. walking_upstairs
3. walking_downstairs
4. sitting
5. standing
6. laying

#### column 3 - column 68
Column 3 to 68 contains means of various means and standard deviations columns from the original data set for each subject + activity combination. For example, column 3 is "body acc time x mean", which refers to the mean of the x axis time domain signal values from the body acceleration monitor.

## How data is tided up in this set
### Loading the data
The data is downloaded from the following address: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Then the downloaded zip file is being extracted to a folder, where the data clean up R script will be placed.

### Reading and merging the data
Extract the zip file and we find the following files under the folder:
* /features.txt
* /activity_labels.txt
* /test/X_test.txt
* /test/y_test.txt
* /test/subject_test.txt
* /train/X_train.txt
* /train/y_train.txt
* /train/subject_train.txt

1. First read all mentioned .txt files
2. Merge test set data by cbind data sets read from the /test/ folder
3. Merge train set data by cbind data sets read from the /train/ folder
4. Merge test and train sets by rbind the 2 data sets
5. Add header to the merged data set by using data from features.txt and activity_labels.txt

### Extracts only the measurements on the mean and standard deviation for each measurement
Using the result data set from the above section, subsetting another data set by selecting columns with column names that match either 'mean()' or 'std()'.

The result data set now reduced to only 68 columns.

### Uses descriptive activity names to name the activities in the data set
The result data set from above section is using numbers for various activites. 
Now make use of the activities data we read from the activity_labels.txt and replacing the numbers by actual activities labels (e.g. walking) using the sub function.

### Appropriately labels the data set with descriptive variable names
Then we use multiples gsub function to replace the original column names by a more human readable terms; at the same time replacing all hyphen with space.

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject
Finally, using the above data set; use a 2 levels for loop:

1. Iterate each subject + activity combination
2. Subset the dataset so that it returns all rows of the given subject + activity combination
3. Then for each column of this sub set, calculate the column mean and append it to a temporary data frame
4. Append this column means data frame to a larger data frame after each iteration

After the 2 levels for loop we will obtain a 66 cols * 180 rows data frame. Then we append it with the subject and activity columns to construct the final data set.

Final data set can now be described as follows:
* Having 68 cols * 180 rows
* The first column is subject IDs
* The second column is user activity (e.g. walking)
* Column Column 3 to 68 contains means of various means and standard deviations columns from the original data set for each subject + activity combination

Finally, export the data set to a file called 'tidyset.txt' in the same folder