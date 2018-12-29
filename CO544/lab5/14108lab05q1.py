import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O

from sklearn.naive_bayes import GaussianNB
from sklearn.naive_bayes import MultinomialNB
from sklearn import neighbors , datasets
from sklearn import svm

from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score

from sklearn.metrics import confusion_matrix

from sklearn import tree

from sklearn.ensemble import RandomForestClassifier

zoo_data = pd.read_csv('zooData.csv')
#print(zoo_data.head())

#print(zoo_data.isnull().sum())

#print(zoo_data.describe())

X = zoo_data.iloc[:,1:17] #features
y = zoo_data.iloc[:,17] #lables(results)

#q2
clf = tree.DecisionTreeClassifier()
clf = clf.fit(X,y)
print()
print("Decision tree classifier by training set")
print('Training Accuracy: ',clf.score(X,y)) # Training accuracy

X_train , X_test , y_train , y_test = train_test_split(X, y, test_size =0.333,random_state =0)
clf.fit(X_train ,y_train)
print()
print("Decision tree classifier by splitting the data as 2/3 for training and 1/3 for testing")
print('Test Accuracy: ',clf.score(X_test ,y_test )) # Test accuracy

scores = cross_val_score(clf, X, y, cv=10) # 10-fold cross validation
print()
print("Decision tree classifier by 10-fold cross validation")
print("10CV Accuracy: %0.2f (+/- %0.2f)" % (scores.mean(),scores.std()*2))

#q3

def split_data(clf,X,y):
    X_train , X_test , y_train , y_test = train_test_split(X, y, test_size =0.333,random_state =0)
    clf.fit(X_train ,y_train) # clf is a classifier.
    y_pred = clf.fit(X_train , y_train ).predict(X_test)
    print(confusion_matrix(y_test , y_pred ))

print("\nConfusion matrix using Decision tree classifier")   
clf = tree.DecisionTreeClassifier()
split_data(clf,X,y)

print("\nConfusion matrix using GaussianNB")   
clf = GaussianNB()
split_data(clf,X,y)

print("\nConfusion matrix using MultinomialNB")
clf=MultinomialNB()
split_data(clf,X,y)

print("\nConfusion matrix using KNeighbors Classifier")
clf = neighbors.KNeighborsClassifier(n_neighbors =1)
split_data(clf,X,y)

print("\nConfusion matrix using SVM")
clf = svm.SVC(kernel='linear', C=1,gamma=1).fit(X, y)
split_data(clf,X,y)

#q4

def cross_val_fun(clf,X,y):
    clf.fit(X,y)
    scores = cross_val_score(clf, X, y, cv=10) # 10-fold cross validation
    print(scores) # Results for all the folds
    print("10CV Accuracy: %0.2f (+/- %0.2f)" % (scores.mean(),scores.std()*2))

print("\n10-fold cross validation accuracy of Decision Tree Classifier\n")   
clf = tree.DecisionTreeClassifier()
cross_val_fun(clf,X,y)

print("\n10-fold cross validation accuracy of GaussianNB\n")   
clf = GaussianNB()
cross_val_fun(clf,X,y)

print("\n10-fold cross validation accuracy of MultinomialNB\n")
clf=MultinomialNB()
cross_val_fun(clf,X,y)

print("\n10-fold cross validation accuracy of KNeighborsClassifier\n")
clf = neighbors.KNeighborsClassifier(n_neighbors =1)
cross_val_fun(clf,X,y)

print("\n10-fold cross validation accuracy of SVM\n")
clf = svm.SVC(kernel='linear', C=1,gamma=1).fit(X, y)
cross_val_fun(clf,X,y)    

#q5
print("\nConfusion matrix using RandomForestClassifier\n")
clf=RandomForestClassifier(n_estimators=100)
split_data(clf,X,y)

print("\n10-fold cross validation accuracy of RandomForestClassifier\n")
clf=RandomForestClassifier(n_estimators=100)
cross_val_fun(clf,X,y)

"""
..................................answers.............................
q2
10 fold cross validation gives the more realistic future performance.
Because, its use whole test set as training set also this option can be use on complex models.


q5 Random Forest Classifier
10 fold cross validation accuracy and the confution matrix by using Random Forest
classifier is very equally same as the those when use the support vector machine
classifier

"""
