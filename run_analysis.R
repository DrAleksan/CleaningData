### Reading all data

activities <- read.table("activity_labels.txt", colClasses = "character")$V2
features <- read.table("features.txt", colClasses = "character")$V2
features <- make.unique(features)

setwd("test")

test_id <- read.table("subject_test.txt", colClasses = "numeric")
names(test_id) <- "id"
test_X <- read.table("X_test.txt", colClasses = "numeric")
names(test_X) <- features
test_y <- read.table("y_test.txt", colClasses = "numeric")
names(test_y) <- "activity"

setwd("../train")

train_id <- read.table("subject_train.txt", colClasses = "numeric")
names(train_id) <- "id"
train_X <- read.table("X_train.txt", colClasses = "numeric")
names(train_X) <- features
train_y <- read.table("y_train.txt", colClasses = "numeric")
names(train_y) <- "activity"

## Take only columns with std or mean value

test_X <- test_X[, grep("std\\(\\)|mean\\(\\)", features)]
train_X <- train_X[, grep("std\\(\\)|mean\\(\\)", features)]

## Change activity id to activity name

test_y$activity <- activities[test_y$activity]
train_y$activity <- activities[train_y$activity]

## Merging all

test_all <- cbind(test_id, test_X, test_y)
train_all <- cbind(train_id, train_X, train_y)

full_set <- rbind(test_all, train_all)

## Making factor from activity and id

full_set$activity <- factor(full_set$activity)
full_set$id <- factor(full_set$id)

## Making final table with means values

grouped <- group_by(full_set, id, activity)
means <- summarise_all(grouped, mean)

## write.table(means, file = "res.txt", row.names = FALSE)

setwd("..")
