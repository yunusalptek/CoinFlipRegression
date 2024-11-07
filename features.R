# Load required libraries
library(data.table)
library(Metrics)

# Set random seed
set.seed(77)

# Load datasets
samp_sub <- fread("./project/volume/data/raw/samp_sub.csv")
test <- fread("./project/volume/data/raw/test_file.csv")
train <- fread("./project/volume/data/raw/train_file.csv")

# Initialize test result column
test$result <- train$result
test$result <- 0

# Calculate total_heads for both train and test
test <- test[, total_heads := rowSums(.SD), .SDcols = V1:V10]
train <- train[, total_heads := rowSums(.SD), .SDcols = V1:V10]

# Calculate coin flip bias for each flip
meanV1 <- mean(train$V1)
meanV2 <- mean(train$V2)
meanV3 <- mean(train$V3)
meanV4 <- mean(train$V4)
meanV5 <- mean(train$V5)
meanV6 <- mean(train$V6)
meanV7 <- mean(train$V7)
meanV8 <- mean(train$V8)
meanV9 <- mean(train$V9)
meanV10 <- mean(train$V10)
print(meanV1)
print(meanV2)
print(meanV3)
print(meanV4)
print(meanV5)
print(meanV6)
print(meanV7)
print(meanV8)
print(meanV9)
print(meanV10)

# Save processed train and test datasets
fwrite(train, "./project/volume/data/interim/train.csv")
fwrite(test, "./project/volume/data/interim/test.csv")
