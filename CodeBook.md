### Code Book for variables and data transformation

The run_analysis.R codes does the following:

1. Downloads and unzips the raw files

2. reads in the following files:
    + activity_labels.txt : labels for the y_test and y_train files
    + features.txt : labels for the columns in the x_test and x_train files  
    
3. From the features file, select only the mean and std variables 

4. Import and merge the following test files:
    + subject_test.txt : identifies the subject id for each row in x_test
    + y_test.txt : identifies the activity for each row in x_test, converted to activity name based on mapping from activity_labels.txt
    + X_test.txt : test dataset, filter only for columns with mean & std based on mapping from features file  

5. Import and merge the following train files:
    + subject_train.txt : identifies the subject id for each row in x_train
    + y_train.txt : identifies the activity for each row in x_train, converted to activity name based on mapping from activity_labels.txt
    + X_train.txt : train dataset, filter only for columns with mean & std based on mapping from features file  

6. Merge test and train data sets from steps 4 and 5

7. Create tidy data by calculating the mean for each variable in the datset in step 6 grouped by subject id and activity
    
    
### Description of variables in data and tidy data

* subj_id : ID to identify individuals in the dataset, range from 1 to 30

* activity : type of activity
    + WALKING
    + WALKING_UPSTAIRS
    + WALKING_DOWNSTAIRS
    + SITTING
    + STANDING
    + LAYING

* prefix t : denotes time

* prefix f : denotes frequency

* contains BodyGyro : denotes gyroscope signal

* contains BodyAcc : denotes body acceleration signal

* contains GravityAcc : denotes gravity acceleration signal

* contains Jerk : denotes Jerk signals obtained from the body linear acceleration and angular velocity derived in time 

* contains Mag : denotes magnitude of these three-dimensional signals calculated using the Euclidean norm

* contains x,y,z : denotes signal axis

* contains mean : mean of variable

* contains std : standard deviation of variable

