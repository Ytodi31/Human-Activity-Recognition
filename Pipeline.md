# Human-Activity-Recognition
Human activity recognition (walking, climbing stairs, descending stairs) from accelerometer data using Classifiers

**Problem Statement**
One of the lead project engineers at the smartwatch company ABC, and assigns a new project in activity detection.  The task is to evaluate the utility of processing data from a wrist-worn 3-axis accelerometer in detecting what activities the wearer is performing.  The marketing department predicts significant commercial opportunities for extracting data about user activities in order to offer hints and suggestions to the users that are synchronized with their activities.  Their pilot research suggests that users are receptive only when these messages are offered sparingly and when the message is linked directly to an activity the user is currently performing. The goal of this assignment is to classify a limited set of activities from wrist-worn accelerometer data. 

**Data Preparation**
* The pilot study will be based on a publicly available dataset described in the paper (Bruno, B., Mastrogiovanni, F., & Sgorbissa, A.: A public domain dataset for ADL recognition using wrist-placed accelerometers. 
* In the 23rd IEEE International Symposium on Robot and Human Interactive Communication, pp. 738-743, 2014) and available at the following website:http://archive.ics.uci.edu/ml/datasets/Dataset+for+ADL+Recognition+with+Wrist-worn+Accelerometer

**Pipeline**
1. Exploring the spectral characteristics of the data using spectrograms.
2. Designing a FIR (Finite Impulse Response) filter to process the data by choosing highpass and lowpass based on observations from Step 1.
3. Determining the magniture and phase transfer characteristics of the filter achieved in Step 2.
4. Designing a classifier to discriminate data from walking, climbing staris and descending stairs.
5. Preparing a training data set and testing data set in 70%-30% ratio.
6. Training the data on the classifier and evaluating the performance on testing data.
7. Analyzing false negatives and false positives.
8. Tuning the classifier to balance the false negatives and false positives.

Note : MATLAB is used for Steps 1,2,4 and 6. All other details are included in the Project Report
