% To perform classification for the horse colic
% dataset using Support Vector Machine (SVM).

% Dataset:
% LOAD horse_colic.MAT loads 3 variables but 
% only these 2 are used for classification:
%   inputs(input data)- a 22x368 matrix defining 22 attributes of
%   368 samples.
%   targets(target data)- a 1x368 matrix which is set to 0 for
%   non-surgical lesion and 1 for surgical lesion

% Pseudocode:
% 1. Load the data 
% 2. Assign the input and target matrix to variables
% 3. Split data into training and testing
% 4. Train and test the SVM model
% 5. Calculate the classification accuracy
% 6. Plot confusion matrix and ROC curve
% 7. Compute the AUROC.

%Load the data
load horse_colic
X = inputs.'
Y = targets.'

%Divide data for training and testing
cv = cvpartition(368,'HoldOut',0.3);
%Extract the test indices
idx = cv.test;
%Get the training data
XTrain=X(~idx,:);
YTrain=Y(~idx,:);
%Get the testing data
XTest=X(idx,:);
YTest=Y(idx,:);

%Train SVM model using the training data
SVMModel=fitcsvm(XTrain,YTrain,'Standardize',true,'KernelFunction','rbf','KernelScale','auto','Solver','L1QP');

%Predict the model on testing data
[label] = predict(SVMModel,XTest);

%Calculate the prediction accuracy
accuracy = sum((predict(SVMModel,XTest) == YTest))/length(YTest)*100

% Plot confusion matrix
cm = confusionchart(YTest,label);
cm.Title = 'Confusion Matrix for Classification by SVM';

% Plot ROC curve and compute AUC
[X,Y,T,AUC] = perfcurve(YTest,label,1);
AUC
plot(X,Y)
xlabel('False positive rate') 
ylabel('True positive rate')
title('ROC for Classification by SVM')
