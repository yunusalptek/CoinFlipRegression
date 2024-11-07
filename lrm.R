# Reload processed datasets
train <- fread("./project/volume/data/interim/train.csv")
test <- fread("./project/volume/data/interim/test.csv")

# Train logistic regression model
lrm <- glm(result~total_heads, data = train)
summary(lrm)

# Check uniqueness
unique(train$total_heads)
unique(train$result)

# Predict result for test dataset
test$pred <- predict(lrm, newdata = test)
test <- test[, binary_pred := as.integer(pred >= 0.5)]

# Evaluate model using training data
train$pred <- predict(lrm, newdata = train)
rmse <- sqrt(mean((train$result - train$pred) ** 2))
print(rmse)

# Prepare final submission file
test <- test[, .(id, pred)]
setnames(test, "pred", "result")
fwrite(test, "./project/volume/data/processed/submit.csv")
