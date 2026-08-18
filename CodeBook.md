# Code Book

This code book describes the variables, data, and transformations performed to clean the Human Activity Recognition Using Smartphones dataset.

## Dataset Overview
The dataset contains accelerometer and gyroscope 3-axial raw signals captured from 30 volunteers (aged 19-48 years) performing six activities while wearing a Samsung Galaxy S II smartphone.

## Identifiers
* `subject`: The ID of the subject (integer, 1 to 30)
* `activity`: The type of activity performed:
  - `WALKING`
  - `WALKING_UPSTAIRS`
  - `WALKING_DOWNSTAIRS`
  - `SITTING`
  - `STANDING`
  - `LAYING`

## Measurements
All measurement variables are normalized and bounded within [-1, 1]. The values in the tidy dataset represent the average of each variable for each subject and activity:
* `TimeBodyAccelerometer.mean...X/Y/Z`
* `TimeBodyAccelerometer.std...X/Y/Z`
* `TimeGravityAccelerometer.mean...X/Y/Z`
* `TimeGravityAccelerometer.std...X/Y/Z`
* `TimeBodyAccelerometerJerk.mean...X/Y/Z`
* `TimeBodyAccelerometerJerk.std...X/Y/Z`
* `TimeBodyGyroscope.mean...X/Y/Z`
* `TimeBodyGyroscope.std...X/Y/Z`
* `TimeBodyGyroscopeJerk.mean...X/Y/Z`
* `TimeBodyGyroscopeJerk.std...X/Y/Z`
* `TimeBodyAccelerometerMagnitude.mean/std`
* `TimeGravityAccelerometerMagnitude.mean/std`
* `TimeBodyAccelerometerJerkMagnitude.mean/std`
* `TimeBodyGyroscopeMagnitude.mean/std`
* `TimeBodyGyroscopeJerkMagnitude.mean/std`
* `FrequencyBodyAccelerometer.mean...X/Y/Z`
* `FrequencyBodyAccelerometer.std...X/Y/Z`
* `FrequencyBodyAccelerometerJerk.mean...X/Y/Z`
* `FrequencyBodyAccelerometerJerk.std...X/Y/Z`
* `FrequencyBodyGyroscope.mean...X/Y/Z`
* `FrequencyBodyGyroscope.std...X/Y/Z`
* `FrequencyBodyAccelerometerMagnitude.mean/std`
* `FrequencyBodyAccelerometerJerkMagnitude.mean/std`
* `FrequencyBodyGyroscopeMagnitude.mean/std`
* `FrequencyBodyGyroscopeJerkMagnitude.mean/std`

## Transformations
1. Training and test sets were merged using `rbind()` and `cbind()`.
2. Measurements containing `mean` and `std` were extracted.
3. Activity codes were replaced with descriptive character labels from `activity_labels.txt`.
4. Variable names were cleaned using `gsub()` to remove abbreviations (e.g., `Acc` -> `Accelerometer`, `t` -> `Time`).
5. A secondary tidy dataset was created by aggregating the average for each measurement grouped by `subject` and `activity`.
