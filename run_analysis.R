setwd("C:\\Users\\erobertson\\datasciencecoursera\\Cleaning Data Assignment")


# Step1: Merges the training and the test sets to create one data set.
    dataset_test <- read.table("X_test.txt")
    dataset_train <- read.table("X_train.txt")
    dataset_all <- rbind(dataset_test, dataset_train)


# Step2: Extracts only the measurements on the mean and standard deviation for each measurement.
    features <- read.table("features.txt")

    ExtractCols <- grep("[Mm]ean\\(\\)|[Ss]td\\(\\)", features[,2]) 

    features <- features[ExtractCols,]

    MeanStd_all <- dataset_all[,ExtractCols]


# Step3: Uses descriptive activity names to name the activities in the data set.
    labels_test <- read.table("y_test.txt")
    labels_train <- read.table("y_train.txt")
    labels_all <- rbind(labels_test, labels_train)

    activity_labels <- read.table("activity_labels.txt")

    labels_all$order  <- 1:nrow(labels_all)
    
    activity_all = merge(labels_all,activity_labels,by.x="V1",by.y="V1")
    activity_all <- activity_all[order(activity_all$order), ]
    activity_all <- activity_all[,c("V1","V2")]


# Step4: Appropriately labels the data set with descriptive variable names.

    # Combine all elements into 1 dataset 
    subject_test <- read.table("subject_test.txt")
    subject_train <- read.table("subject_train.txt")
    subject_all <- rbind(subject_test, subject_train)

    CombineData <- cbind(subject_all,activity_all,MeanStd_all)

    # Descriptive variable names
    features <- gsub("-"," ",features$V2)  # Clean Vars by dropping the " - " 
    features <- gsub("\\(\\)","",features)  # Clean Vars by dropping the " () " 
    features <- gsub(" ","_",features)  # Clean Vars by replacing spaces " 
    VariableNames <- c("subject","activity_number", "activity_name",features)

    names(CombineData) <- VariableNames
   

# Step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    VariableMeans <- names(CombineData)
    VariableMeans <- VariableMeans[4:69]

    tidy <- aggregate(CombineData[VariableMeans], by = CombineData[c("subject","activity_number","activity_name")], mean, na.rm=T)

    tidy <- tidy[order(tidy$subject,tidy$activity_number), ]

    write.table(tidy, file="tidy.txt",row.name=FALSE)

    # Write out Tidy Dataset
    write.table(tidy, "tidy_data_with_means.txt",row.name=FALSE)
