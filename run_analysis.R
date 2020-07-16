run_analysis <- function(){
        
        library(dplyr)
        
        #Reading the training and test datasets
        feature <- read.table("UCI HAR Dataset/features.txt")
        acti <- read.table("UCI HAR Dataset/activity_labels.txt")
        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
        x_t <- read.table("UCI HAR Dataset/test/X_test.txt")
        y_t <- read.table("UCI HAR Dataset/test/y_test.txt")
        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
        x_tr <- read.table("UCI HAR Dataset/train/X_train.txt")
        y_tr <- read.table("UCI HAR Dataset/train/y_train.txt")

        #1. Merging the train and test data set
        x1 <- rbind(x_t,x_tr)
        y1 <- rbind(y_t,y_tr)
        subj <- rbind(subject_test,subject_train)
        
        #2. Extracts only the measurements on the mean and standard deviation for each measurement
        feature2 <- grep("(.*)mean\\(\\)|(.*)std\\(\\)",feature[,2])
        data2 <- x1[,feature2]
        colnames(data2) <- feature[feature2,2]
        data1 <- cbind(subj, data2, y1)
        
        #3. Uses descriptive activity names to name the activities in the data set
        y1[,1] <- acti[y1[,1],2]
        
        #4. Appropriately labels the data set with descriptive variable names
        colnames(subj) <- "SubjectID"
        colnames(y1) <- "Activity"
        final_data <- cbind(subj,y1,data2)
        
        #Below two lines are to give valid column names. Otherwise while grouping it may give dupilcate column error
        
        valid_column_names <- make.names(names=names(final_data), unique=TRUE, allow_ = TRUE)
        names(final_data) <- valid_column_names
        
        #5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        final_data1 <- final_data %>% group_by(SubjectID, Activity) %>% summarise(across(.fns = mean))
        write.csv(final_data1, "Final_Tidy_Data.csv", row.names = FALSE)
}