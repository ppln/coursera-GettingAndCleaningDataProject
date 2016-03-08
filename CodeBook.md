#Data description
A full description of the data set can be found at [
Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Data id
 * activity 
	- 'activity_labels.txt': Links the class labels with their activity name.
 * subject  
	- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
	- 'test/subject_test.txt': similar as 'train'

##Variables
 - 'features.txt': List of all features.
 
##Measurements
 * train:
	- 'train/X_train.txt': Training set.
	- 'train/y_train.txt': Training labels.
 * test:
	- 'test/X_test.txt': Test set.
	- 'test/y_test.txt': Test labels.

###The Script "run_analysis.R" do the following steps
* load the library "plyr" required for this script.
* Download the dataset and unzip it.
* read "activity_labels" and "features"
* extract only the measurements on the "mean" and "standard deviation", rename the activities.
* read and assemble "test" and "train" datasets
* merge "test" and "train" datasets, set column names.
* calculate average of each variable for each activity and each subject.
* output the tidy data set.
	


	