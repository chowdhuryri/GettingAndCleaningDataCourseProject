#Getting and Cleaning Data Course Project Assignment

**run_analysis.R**

The R script (**run_analysis.R**) performed following tasks:

1. Codes in lines 14-18 download the needed data from the website to the local 
   directory and unzip the file.
   24-25 th lines identify the column classes for X-data which is used to reduce 
   file reading time.
   
2. Lines 29-34 read all the train, test data for outcome and features and merges
   as a single data file named **merged_data**.
   The first column (sampleType) in **merged_data** file is a derived variable to 
   identify the training (1) and test samples (2).
   Line 38 converts sampleType as factor with lables "Train" and "Test".
   
   system.time produce following out to produce *merged_data*:
     * user  system elapsed 
     * 13.06    0.28   13.40
   
3. Line 43 reads all the features name from *features.txt* file.
   Line 47 identifies the columns number for the measurements on the mean and 
   standard deviation.
   Line 48 adjust the column locations for selected features in *merged_data*.
   Line 49 select the needed columns and store it as *merged_data*.

4. Line 53 reads activity labels from *activity_labels.txt* file.
   Line 54 assigned these labels to activityType column in the *merged_data*.
      
5. LIne 58-59 labels the *merged_data* features columns with descriptive 
   variable names.
   
6. Line 63 creates a second, independent tidy data set with the average of each 
   variable for each activity and each subject.
   Finally, lines 66-67 write both the data sets to text file.

   In *merged_data* file we have  10299 records with following breakdown
   
   table(merged_data$sampleType)
   
   * Train  Test 
   * 7352  2947 
   

