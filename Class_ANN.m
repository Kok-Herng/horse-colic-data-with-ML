% To perform classification for the horse colic
% dataset using Artificial Neural Network (ANN).

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
% 3. Create the pattern recognition network
% 4. Split data into training, validation and testing
% 5. Train and test the network
% 6. Calculate the classification accuracy
% 7. Plot confusion matrix and ROC curve
% 8. Compute the AUROC.


%Load the data
load horse_colic
horseinput = inputs
horsetarget = targets

%Create a pattern recognition network
trainFcn = 'trainbr'
hiddenLayerSize = 20;
net = patternnet (hiddenLayerSize,trainFcn);

%Set up division of data for training, validation, testing
net.divideParam.trainRatio = 70/100;
net.divideParam.testRatio = 30/100;

%Train the network
[net,tr] = train(net,horseinput,horsetarget);

%Test the network
outputs = net(horseinput);
errors = gsubtract(horsetarget,outputs);
performance = perform(net,horsetarget,outputs)

%Calculate classification accuracy
[c,cm] = confusion(horsetarget,outputs);
fprintf('Percentage Correct Classification : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

%Plot confusion matrix and ROC curve
figure, plotconfusion(horsetarget,outputs)
figure, plotroc(horsetarget,outputs)

% Compute AUROC 
[X,Y,T,AUC] = perfcurve(horsetarget,outputs,1);
AUC