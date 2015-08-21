library(reshape2)
#read data from files
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

trainSubject<-read.table("UCI HAR Dataset/train//subject_train.txt",header=F,fill=T)
trainX<-read.table("UCI HAR Dataset/train//X_train.txt",header=F,fill=T)
trainY<-read.table("UCI HAR Dataset/train//y_train.txt",header=F,fill=T)
testSubject<-read.table("UCI HAR Dataset/test//subject_test.txt",header=F,fill=T)
testX<-read.table("UCI HAR Dataset/test//X_test.txt",header=F,fill=T)
testY<-read.table("UCI HAR Dataset/test//y_test.txt",header=F,fill=T)
featureNames<-read.table("UCI HAR Dataset/features.txt",header=F,fill=T)
activityNames<-read.table("UCI HAR Dataset/activity_labels.txt",header=F,fill=T)

#merge data from test and training sets
#in the resulting set the first column will be subject ids, then the feature columns follow and the last column
# is the activity name
train<-cbind(trainSubject,trainX,trainY)
test<-cbind(testSubject,testX,testY)
data<-rbind(train,test)

#we will use the feature names too determine which features are measurements on mean or standard deviation
#and use this to subset our data
featureNames$V2<-as.character(featureNames$V2)
mnstd<-grepl("mean()",featureNames$V2,fixed=T)|grepl("std()",featureNames$V2,fixed=T)
featureNames<-c("Subject",featureNames$V2,"Activity")
#we add a TRUE value at the beginning and end of the mnstd vector so we keep the subject and activity rows when 
#subsetting
mnstd<-c(TRUE,mnstd,TRUE)
data<-data[,mnstd]

#now we can add descriptive names to the features. The names were found in the features.txt file
names(data)<-featureNames[mnstd]

#we also add descriptive names for the different activities
data$Activity<-as.factor(data$Activity)
levels(data$Activity)<-c("Walking","Walking Up","Walking Down","Sitting", "Standing", "Laying")

#now we create a table with the mean of each feature for every subject and activity
meltData<-melt(data,id=c("Subject","Activity"))
newData<-dcast(meltData,Subject + Activity ~ variable,mean)

#now save this to a text file
write.table(newData,file="data.txt",row.names=F)