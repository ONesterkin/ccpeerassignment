#Clean up ["Human Activity Recognition Using Smartphones"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) Data Set 


This script cleans up dataset according to rules, described below.
- only a single script here, which does all the job: run_analysis.R
- all transformations described in CodeBook.md
- results are: 
   - final.txt - first tidy dataset (means and std)
   - final2.txt - second tidy dataset (means)

Tidy datasets where created according to these instructions
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive activity names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 