# Load the party package. It will automatically load other required packages.
# library(party)
library(FFTrees)
source('fft_common.r')
args <- commandArgs(TRUE)
n <- as.integer(args[1])

# Read data
data<- getData("../Data/velocity.csv",n)
train <- data$trainData
test <-data$testData

# Saving the training and testing set to file:
write.csv(train, file = paste('../Results/', toString(n), "_training.csv", sep=""))
write.csv(test, file = paste('../Results/', toString(n), "_testing.csv", sep=""))

# train the model
model<- trainFFT(train,test)

# get prediction for the test set
prediction <- predict(model, data = test)

# compare prediction and actual, counting no of hits:
count <- 0
for(i in 1:nrow(test)){
  if(test[i,"bug"]==prediction[i]){
    count = count +1;
  }
}

#View the fft results.

# saving model to file
sink(paste('../Results/', toString(n), "_fft.txt", sep=""))
print(model)
sink()

# print(model) 

print(count)
print(object.size(model))