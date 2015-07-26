rm(list=ls())
# Reading the main files into R
x_test<- read.table("X_test.txt", header=FALSE, sep="")
x_train<- read.table("X_train.txt", header=FALSE, sep="")
x_merge<- rbind(x_test,x_train)

# Slecting the rows with mean and standard deviation from the feature.txt
library(stringr)
feature<- read.table("features.txt")
feature$select<- "other"    
feature$select[str_detect(feature$V2,"mean")]<- "mean"
feature$select[str_detect(feature$V2,"std")]<- "std"
logic_vector<- feature$select=="mean" |
               feature$select=="std"    # a logical vector of the column names
                  # including mean or std in their names
                    
submerge<- x_merge[,logic_vector]

# Adding the activity name and subjects # 
y_test<- read.table("y_test.txt")
y_train<- read.table("y_train.txt")
s_test<- read.table("subject_test.txt")
s_train<- read.table("subject_train.txt")
class_lables<- rbind(y_test,y_train)   #combine activity numbers
subject_numbers<- rbind(s_test,s_train)   #combine activity numbers
final<- cbind(subject_numbers, class_lables,submerge)  
colnames(final)[1] <- "subject"
colnames(final)[2] <- "activity"
act_Labels<- read.table("activity_labels.txt")
final$activity<- factor(final$activity) # converting the activity variable type to factor  
levels(final$activity)<- act_Labels$V2 # setting it's levels based on the activity_lables.txt levels

# Labeling data with descriptive names
column_names<- feature$V2[logic_vector] # I used the same logical vector that we made to select mean and std
column_names<- gsub("-"," ", column_names)
column_names<- gsub("\\(|\\)","", column_names)
column_names<- gsub("Freq", " Frequency", column_names)
column_names<- gsub("^t", "Time-", column_names)
column_names<- gsub("^f", "Frequency-", column_names)
column_names<- gsub("BodyBody", "Body", column_names)
column_names<- gsub("BodyAcc", "Body Acceleration", column_names)
column_names<- gsub("BodyGyro", "Body Angular", column_names)
column_names<- gsub("GravityAcc", "Gravity Acceleration", column_names)
column_names<- gsub("Gyro", "Gyroscope", column_names)
column_names<- gsub("Jerk", " Jerk", column_names)
column_names<- gsub("Mag", " Magnitude", column_names)
column_names<- gsub("X", "on X", column_names)
column_names<- gsub("Y", "on Y", column_names)
column_names<- gsub("Z", "on Z", column_names)
colnames(final)<- c("subject", "activity", column_names) 

#making the data tidy
library(reshape2)
library(plyr)
library(dplyr)
final_by_activity_subject<- melt(final, id=c("activity","subject"))
mean_final<- dcast(final_by_activity_subject, activity + subject ~ variable, mean)
write.table(mean_final, file="tidydata.txt", row.name=TRUE)
# tidy<-read.table("tidydata.txt", header=TRUE, sep="", check.names=FALSE)

