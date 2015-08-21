---

---

##README

This repository contains the script "run_analysis.R", which reads in the UCI HAR dataset and performs operations
on it to extract information on the average of some features by subject and activity. For more information on the dataset see [this](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

Data from the training and test files are read into data.frames and subsequently merged into a single table. The features relating to mean and standard deviation of measurements (the ones we are interested in) are then extracted from the feature list contained in the dataset. These are then used to subset the data, the descriptive names of the activities are also substituted into the table.

We can now melt the data by subject and activity and use the 'dcast' function to create a new data frame containing the averages of the features of interest by subject and activity.

