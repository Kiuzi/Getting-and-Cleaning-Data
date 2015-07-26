## Getting-and-Cleaning-Data
###Final Project
The data used in this project is collected in a study conducted by Samsung to evaluate subjects' performance in in daily living activities with a waist-mounted smartphone with inertial sensors. The data and a full description of it can be obtained through UCLA Machine Learning Repository:
[DataLink](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 
\s The idea of this project is to collect and create a tidy data from a several data sets that can be used for later analysis. The steps of doing the project are a follows:
####step 1####
X_test and X_train data sets contain information of 561 features with time and frequency domain variables for test and train groups of participants. These two datasets were first merged by rbind function since they have the same format, just for different subjects.
####step 2####
The columns that were not of interest were removed before adding the activity and subject columns. featuresdata was used to detect the columns regarding mean and standard deviation of any variable. To do so, thestringer package in R and the str_detect function were used to select any row containing the words "mean" or "std". Basically, a new column was created in the feature data set with three values "mean", "std", and "other". Then, a logical vector of this new column was generated and the merged data was indexed by this logical vector. Therefore, the new dataset only contains the columns that are about mean and standard deviation. I named this data set "submerge".
####step 3####
By a similar approach to the first step, the subjects and activities information from test and train data sets were merged separately and then were added as the first two columns to the "submerge" data set. I called this data set final and also named the added two columns "subject" and "activity" for easier referral. To name the activity names in the activity column, the class attribute of the activity measures was converted from integer to factor (e.g. converting 1 to "1") and then these levels were set equal to the activity_labels data activity name levels.
####step 4####
For labeling the current data set with descriptive variable names, the logical vector created in step 2 was used to make a vector of the column names from the feature data set. Then a series of gsub functions were used to make the columns' name easy to read. Finally, I assigned the vector of column names to the final data set.
####step 5####
For this section, I decided to use the melt and dcast function in the reshape R package. First, the was converted to a long format by grouping over the subject and activity variables. Then, all measurements were averaged for all combinations of subjects and activities. The final result is a data frame with 180 by 81 dimension.

