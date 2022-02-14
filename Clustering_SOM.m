% This program is intended to perform clustering for the horse colic
% dataset using Self-Organizing Map (SOM).

% Dataset:
% LOAD horse_colic.MAT loads 3 variables but 
% only 1 are used for clustering:
%   input(input data)- a 25x368 matrix defining 25 attributes of
%   368 samples.

% Pseudocode:
% 1. Load the data.
% 2. SOM training function will take 'input' data as its input vectors.
% 4. Train the function to cluster the dataset.
% 6. View training network.
% 7. Plot the network topology, neighbor connections, neighbor weight
% distances, input planes, sample hits, and weight positions.

%Load dataset
load horse_colic.mat

%Create a SOM network
dimension1 = 15;
dimension2 = 15;
net = selforgmap ([dimension1, dimension2]);

%Network training
[net, tr] = train(net, input);

%Ntwork testing
output = net(input);

%View network
view(net)

%Plot figures
figure, plotsomtop(net)
figure, plotsomnc(net)
figure, plotsomnd(net)
figure, plotsomplanes(net)
figure, plotsomhits(net, input)
figure, plotsompos(net, input)



