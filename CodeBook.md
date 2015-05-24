#CodeBook

This is the codebook for the creation of the tidy data set.

Our data source is the following zip file:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Inside the zip file there are two folders (test and train) and several other useful files:

- features.txt contains the column names used in the test and train data sets.
- features_info.txt explains how the data was created, the meaning of the columns and other information about the variables.
- activity_labels.txt contains the actual activity names.
- test and train directories contain a subfolder named Inertial Signals which is not going to be used.
- test and train directories also have three files: subject%, X%, and y%.
- subject% file contains the id of the subject, one line per measurement.
- y% file contains the id of the activity, one line per measurement.
- X% file contains the measurements.


Information about the original variables can be found in the features_info.txt file.
The following signals were used to estimate the other columns:

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag 

Where *X,Y,Z*  are our three physical dimensions. The *t*  prefix mean time domain signals. The *f*  prefix mean frequency domain signals produced by a fast Fourier transform function. *Acc*  stands for accelerometer, *Gyro*  for gyroscope, *Mag*  for magnitude which was calculated using the Euclidean norm and *Jerk*  is the derivative of the body linear acceleration and angular velocity.

Based on the previous list there will be a mean and a standar deviation (std) for each signal. As there are 8 variables with X,Y,Z dimensions, we will have a mean and a standar deviation for each. The other 9 variables will also have a mean and a standar deviation. So, there will be (3x8x2)+(9x2)=66 columns we need to use in order to meet the project criteria. 

So, from the X% files we will filter the column names to only use the mean and a standar deviation related columns. However, the meanFreq columns will be excluded because is not really a mean or a standar deviation value.

After the subsetting of the X% file, the y% file and the subject% file will be merged with X% file, resulting in 68 columns. Finally, the test and train data will also be merged.

Once there is a full data set, we can provide better column names. 

- The first column came from the subject% file, so I will name it volunteerID
- The second column came from the y% file, so it will be name activity.
- The other 68 columns came from the X% file, so they will keep their former name but with some modifications to improve meaningfulness and to replace potencially illegal variables (if variables names should be used as inputs in R).
- *t* is replaced by *TDS* (time domain signal), *f*  is replaced by *FDS*  (trequency domain signal), *Acc*  by *Accelerometer*, *Gyro*  by *Gyroscope*, *Mag*  by *Magnitude*, *mean*  by *Mean*, *std*  by *STD*  (standard deviation), *()*  is deleted as well as *-*.


So far, activity is represented with a number which will be replaced by its string value as stated in activity_labels file.

Finally, the average of each variable for each subject and each activity is computed.

Plase read the *R code file*  for further details.

