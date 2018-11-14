import pandas as pd
import numpy as np

df = pd.read_csv('../lab02Exercise04.csv', names = ['channel1','channel2','channel3','channel4','channel5'])

names = ['channel1','channel2','channel3','channel4','channel5']

print(df)

#replace missing values with mean
for colName in names :
    df[colName].fillna( df[colName].mean() , inplace = True)

print("added missing values")
print(df)

df['class'] = 0

for i in range(0,df.shape[0]) :
    if ( (df["channel1"][i] + df["channel5"][i])/2 < (df["channel2"][i] + df["channel3"][i] + df["channel4"][i])/3 ) :
        df["class"][i] = 1

    else :
        df["class"][i] = 0

#for i in range(0,df.shape[0]) :
 #   df['class'] = np.where( ( (df["channel1"][i] + df["channel5"][i])/2 < (df["channel2"][i] + df["channel3"][i] + df["channel4"][i])/3 ) == True , 1 , 0 )

print("added new col class")
print(df)
