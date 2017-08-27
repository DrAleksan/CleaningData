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
names(test_y) <- "y"

setwd("../train")

train_id <- read.table("subject_train.txt", colClasses = "numeric")
names(train_id) <- "id"
train_X <- read.table("X_train.txt", colClasses = "numeric")
names(train_X) <- features
train_y <- read.table("y_train.txt", colClasses = "numeric")
names(train_y) <- "y"

test_X <- test_X[, grep("std|mean", features)]
train_X <- train_X[, grep("std|mean", features)]

test_y$y <- activities[test_y$y]
train_y$y <- activities[train_y$y]


test_all <- cbind(test_id, test_X, test_y)
train_all <- cbind(train_id, train_X, train_y)

full_set <- rbind(test_all, train_all)

grouped <- group_by(full_set, id, y)
means <- summarise_all(grouped, mean)

setwd("..")