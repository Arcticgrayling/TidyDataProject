## Coursera Get and Clean data course, class Project
## Peter Olsen, August 2015
##

# rm(list=ls())  # option to remove all variables, useful while developing script

##SET directories, these will need to be changed based on users system
wd <- "~/Documents/datasciencecoursera/GettingCleaningData/project/"
dataLoc <- paste(wd,"UCI HAR Dataset/", sep = "")
setwd(dataLoc)

activityList <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

featureLabels <- read.table(file = "features.txt")
#df.featureLabels <- data.frame(featureLabels, labels = TRUE)
TFlabels <- t(featureLabels) # take feature labels and transpose it
labels <- TFlabels[2,]  #take just the text part

df.XTrain <- read.table (file = "./train/X_train.txt", fill = TRUE)  # Loading Training data
df.YTrain <- read.table (file = "./train/Y_train.txt", fill = TRUE)   # activites
df.SubTrain <- read.table(file = "./train/subject_train.txt", fill = TRUE) #subjects
colnames(df.SubTrain) <- "Subject"  # give Subject columname to 

##PROCESS TRAIN DATA
colnames(df.XTrain) <- labels  # label Xtrain table with labels from features.txt file
colnames(df.YTrain) <- "Activity"

df.YTrain <- mutate(df.YTrain, Activity = activityList[Activity])  # change Activites to names from integers using a list

Train1 <- bind_cols(df.YTrain, df.XTrain)  # add activites column
Train2 <- bind_cols(df.SubTrain, Train1)    # add column Subject, to data 

## Choose only the desired columns - Subjects, Activites, Varaibles that are mean values and std values, 
## Selection based on Variables with mean() and std() in the name.
# use grep/regular expressions to get only variables with mean() and std(), use \\ to escape the '(' and ')' characters
Train3 <- Train2[ ,  c(1, 2, grep("mean\\(\\)|std\\(\\)", names(Train2))) ]  

rm(Train1)  # remove larger intermediary tables to free memory
rm(Train2)
rm(df.XTrain)

#PROCESS TEST DATA
#Load data tables from the test sub directory
df.XTest <- read.table (file = "./test/X_test.txt", fill = TRUE)
df.YTest <- read.table (file = "./test/Y_test.txt", fill = TRUE)
df.SubTest <- read.table(file = "./test/subject_test.txt", fill = TRUE)

#LABEL Columns
colnames(df.XTest) <- labels  # label Xtrain table with labels from features.txt file
colnames(df.YTest) <- "Activity"  # label the Activty 

df.YTest <- mutate(df.YTest, Activity = activityList[Activity])  # change Activites to names from integers using a list

Test1 <- bind_cols(df.YTest, df.XTest)  # add activites column

colnames(df.SubTest) <- "Subject"  # give Subject column a name
Test2 <- bind_cols(df.SubTest, Test1)    # add column Subject, to data 

## SELECT only the desired columns - Subjects, Activites, mean values and std values, choose based on Variables with mean() and std()
# use grep/regular expressions to get only mean() and std() variables
Test3 <- Test2[ ,  c(1, 2, grep("mean\\(\\)|std\\(\\)", names(Test2))) ]  

#### Merge TRAIN data and TEST data
step4 <- bind_rows(Train3,Test3)


##Summarize by variable and activity
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## used summarise_each as mentioned in this post: http://stackoverflow.com/a/24455439/4076486

part5Data <-  group_by(step4, Activity, Subject) %>%
          summarise_each(funs(mean))    ## Using the summarise_each function because of its simplicity

#write table to submit
write.table(part5Data, "../part5Data.txt", quote = FALSE, row.names = FALSE, col.names = TRUE)


