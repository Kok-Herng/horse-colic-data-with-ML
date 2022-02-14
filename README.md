# horse-colic-data-with-ML
Colic is a condition of abdominal pain in horses and also referred as gastrointestinal disorders.
The raw data is obtained from [UCI machine learning repository](https://archive.ics.uci.edu/ml/datasets/Horse+Colic)<br/><br/>

Aim:
- To classify was the lesion surgical or non-surgical
- To perform classification using Artificial Neural Network (ANN), Support Vector Machine (SVM) and Random Forest (RF)
- To perform clustering using Self-Organizing Map (SOM)<br/><br/>

The pre-processing steps carried out were:
- Remove columns with more than 40% missing values
- Replace missing values with median value of that particular column for numerical data
- Replace missing values with nearest non-missing value for categorical data<br/><br/>

Conclusion:
- ANN is the best classifier in this case, achieving 94.84% classification accuracy compared to SVM (88.2%) and RF (87.3%)
- SOM was able to cluster the data into two distinct group
