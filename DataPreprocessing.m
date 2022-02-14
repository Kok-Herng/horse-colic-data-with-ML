%% Set up the import options and import the data
opts = delimitedTextImportOptions("NumVariables", 28);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["Surgery", "Age", "Hospital Number", "Rectal Temperature", ...
    "Pulse", "Respiratory Rate", "Temperature of Extremities", "Peripheral Pulse", ...
    "Mucous Membranes", "Capillary Refill Time", "Pain", "Peristalsis", ...
    "Abdominal Distension", "Nasogastric Tube", "Nasogastric Reflux", ...
    "Nasogastric Reflux pH", "Rectal Examination", "Abdomen", "Packed Cell Volume", ...
    "Total Protein", "Abdominocentesis Appearance", "Abdomcentesis Total Protein", ...
    "Outcome", "Surgical Lesion", "Type of Lesion", "Type of Lesion", ...
    "Type of Lesion", "Cp_data"];
opts.VariableTypes = ["categorical", "categorical", "string", "double", ...
    "double", "double", "categorical", "categorical", "categorical", ...
    "categorical", "categorical", "categorical", "categorical", "categorical", ...
    "categorical", "double", "categorical", "categorical", "double", "double", ...
    "categorical", "double", "categorical", "categorical", "string", "string", ...
    "string", "categorical"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, ["Hospital Number", "Type of Lesion", "Type of Lesion", ...
    "Type of Lesion"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Surgery", "Age", "Hospital Number", "Temperature of Extremities", ...
    "Peripheral Pulse", "Mucous Membranes", "Capillary Refill Time", "Pain", ...
    "Peristalsis", "Abdominal Distension", "Nasogastric Tube", "Nasogastric Reflux", ...
    "Rectal Examination", "Abdomen", "Abdominocentesis Appearance", "Outcome", ...
    "Surgical Lesion", "Type of Lesion", "Type of Lesion", "Type of Lesion", ...
    "Cp_data"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["Nasogastric Reflux pH", "Abdomcentesis Total Protein"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["Nasogastric Reflux pH", "Abdomcentesis Total Protein"], "ThousandsSeparator", ",");

% Import the data
data1 = readtable("horse-colic.data", opts); % Predefined training dataset
data2 = readtable("horse-colic.test", opts); % Predefined testing dataset

%% Data examination and cleaning
% Combine both predefined dataset into one
data = [data1; data2];

% Standardize missing values according to type
dataClean = standardizeMissing(data,"?");

% Count number of missing values for each variable
sum(ismissing(dataClean))

% Remove columns with more than 40% missing values
dataClean = rmmissing(dataClean,2,'MinNumMissing',147);

% Fill missing values for columns less than 40% missing values
% Extract numerical columns only
dataNumOnly = dataClean(:,[4:6,18:19]);
dataNumOnly = table2array(dataNumOnly);

% Replace missing values with median value of that particular column for
% numerical data
dataNumFill = fillmissing(dataClean,'constant',median(dataNumOnly,1,'omitnan'), ...
    'DataVariables',@isnumeric);

% Replace missing values with nearest non-missing value for 
% categorical data
dataAllFill = fillmissing(dataNumFill,"nearest",'DataVariables', ...
    @iscategorical);

%% Prepare input & target matrix
%Convert categorical data to numerical data
input = convertvars(dataAllFill, (1:3), 'double');
input = convertvars(input, (7:17), 'double');
input = convertvars(input, (20:25), 'double');
input = table2array(input(:, 1:25));

%Input matrix for clustering
input = input';

%Input and target matrix for classification
inputs = input([1:2,4:20,22:24], :);
targets = input(21, :);
targets(targets==2)=0;  %0 means that the lesion is not surgical
