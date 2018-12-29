import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O

from sklearn.model_selection import train_test_split

from sklearn import tree
import pydotplus

from IPython.display import Image
from PIL import Image , ImageDraw

from sklearn.metrics import accuracy_score

filename = 'breaset-cancer.csv'
cancer_data = pd.read_csv(filename, encoding = "ISO-8859-1")

cancer_data = cancer_data.fillna(cancer_data.mean())#fill missing val with mean of col

del cancer_data['COUNTRY'] #remove country col

y = np.zeros((cancer_data['BREASTCANCERPER100TH'].size,1)) #take as lable

#col val change to binary |BREASTCANCERPER100TH
for i in range(cancer_data['BREASTCANCERPER100TH'].size):
    if cancer_data['BREASTCANCERPER100TH'].values[i] <= 20:
        y[i] = 0
    else:
        y[i] = 1

del cancer_data['BREASTCANCERPER100TH'] #remove BREASTCANCERPER100TH col

#other col value change to binary

X = np.zeros((cancer_data.iloc[:,0:15].values[:,0].size,cancer_data.shape[1])) #features

# Convert other values to nominal
for i in range(cancer_data.shape[1]):
    val_mean = cancer_data.iloc[:,0:15].values[:,i].mean()

    for j in range(cancer_data.iloc[:,0:15].values[:,i].size):
        if cancer_data.iloc[:,0:15].values[:,i][j] <= val_mean:
            X[:,i][j] = 0
        else:
            X[:,i][j] = 1

#split data as 2/3 for training and 1/3 for testing
X_train , X_test , y_train , y_test = train_test_split(X, y, test_size =0.333,random_state =0)

clf = tree.DecisionTreeClassifier()#classifier
clf.fit(X_train ,y_train)

header_list = ['INCOMEPERPERSON', 'ALCCONSUMPTION', 'ARMEDFORCESRATE', 'CO2EMISSIONS', 'FEMALEEMPLOYRATE', 'HIVRATE', 'INTERNETUSERATE', 'LIFEEXPECTANCY', 'OILPERPERSON', 'POLITYSCORE', 'RELECTRICPERPERSON', 'SUICIDEPER100TH', 'EMPLOYRATE', 'urbanrate']

#draw png decission tree
dot_data = tree.export_graphviz(clf, out_file=None ,filled=True , feature_names=header_list, rounded=True ,special_characters=True)
graph = pydotplus.graph_from_dot_data(dot_data)
graph.write_png("cancer.png")

y_pred = clf.fit(X_train , y_train ).predict(X_test)
print('\nTest Accuracy: ',accuracy_score(y_test , y_pred)) # Test accuracy

image = Image.open("cancer.png")
image.show()    
