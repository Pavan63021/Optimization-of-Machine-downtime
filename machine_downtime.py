#import collected dataset to python
import pandas as pd
md=pd.read_csv("C:\PROJECT 2\Data Set\Machine_Downtime.csv")

#python to postgresql connection
from sqlalchemy import create_engine
import psycopg2
engine=create_engine("postgresql://{user}:{pw}@localhost/{db}"
                     .format(
                     user="postgres",
                     pw='2001',
                     db='machine_downtime'))

md.to_sql('md',con = engine,if_exists = 'replace', chunksize = None ,index = None)

#to describe quantiles, count, mean, std
md.describe()

#information about non-null count, dtypes
md.info()

#data types
md.dtypes

####  type casting
md.Date = md.Date.astype('datetime64')

#columns
md.columns

#last 5
md.tail(5)

#top 5
md.head(5)

######  identify duplicates
duplicates = md.duplicated()
sum(duplicates)

#delete duplicates
md_clean = md.drop_duplicates()

#####  renaming column names
md=md.rename(columns={'Hydraulic_Pressure(bar)':'Hydraulic_Pressure','Coolant_Pressure(bar)':'Coolant_Pressure',
                      'Air_System_Pressure(bar)':'Air_System_Pressure','Hydraulic_Oil_Temperature(°C)':
                      'Hydraulic_Oil_Temperature','Spindle_Bearing_Temperature(°C)':'Spindle_Bearing_Temperature',
                      'Spindle_Vibration(µm)':'Spindle_Vibration','Tool_Vibration(µm)':'Tool_Vibration',
                      'Spindle_Speed(RPM)':'Spindle_Speed','Voltage(volts)':'Voltage','Torque(Nm)':'Torque',
                      'Cutting(kN)':'Cutting'})

###############################################  DESCRIPTIVE STATISTICS  ##############################################
# FIRST MOMENT BUSINESS DECISION - MEASURE OF CENTRAL TENDENCY
md.mean()
md.median()
md.mode()

#SECOND MOMENT BUSINESS DECISION - MEASURE OF DISPERSION
md.var()
md.std()
max(md.Hydraulic_Pressure)-min(md.Hydraulic_Pressure)

#THIRD MOMENT BUSINESS DECISION - MEASURE OF ASYMMETRY
'''-0.5 to 0.5 = normal , -+0.5 to +-1 = moderate , >+1 = positive skewed and <-1 = negative skewed'''
md.skew()

#FOURTH MOMENT BUSINESS DECISION - MEASURE OF PEAKEDNESS
''' 3 =normal or mesokurtic, >3 = postive or leptokurtic , <3 = negative or platykurtic'''
md.kurt()

##################################################  UNI VARIENT ANALYSIS  ###################################################
import seaborn as sns
import matplotlib.pyplot as plt

#barplot
sns.barplot(x=md.Voltage.value_counts(),y=md.Downtime)
sns.show()

b=md.Downtime.value_counts().plot(kind='bar')

plt.bar(x='Downtime', height='Voltage',width=0.5)
plt.show()
#line chart (plot)
md.plot(x='Date',y='Voltage',kind='line')
md.plot()

#histogram - frequency distribution
plt.hist(md.Voltage)

#kde plot - density
sns.kdeplot(md.Voltage)

#dist plot - density
sns.distplot(md.Voltage)

#dis plot - frequency
sns.displot(md.Voltage)

#box plot - to identify outliers
sns.boxplot(md.Hydraulic_Pressure)
sns.boxplot(md.Coolant_Pressure)
sns.boxplot(md.Air_System_Pressure)
sns.boxplot(md.Coolant_Temperature)
sns.boxplot(md.Hydraulic_Oil_Temperature)
sns.boxplot(md.Spindle_Bearing_Temperature)
sns.boxplot(md.Spindle_Vibration)
sns.boxplot(md.Tool_Vibration)
sns.boxplot(md.Spindle_Speed)
sns.boxplot(md.Voltage)
sns.boxplot(md.Torque)
sns.boxplot(md.Cutting)

#Q-Q Plot(probability plot) - check for normal distribution
import scipy.stats as stats
import pylab
stats.probplot(md.Voltage, dist='norm', plot=pylab)

###############################################  BIVARIENT ANALYSIS  ############################################
plt.scatter(x=md.Voltage,y=md.Torque,color='green')

#correlation coefficient
correlation = md.corr(method='pearson')
a=md[['Voltage','Torque']].corr()
##############################################  MULTIVARIENT ANALYSIS  #########################################
sns.pairplot(md)

##############################################  DATA PRE-PROCESSING  ######################################
##############################################  OUTLIER TREATMENT    #######################################
IQR = md.Hydraulic_Pressure.quantile(0.75)-md.Hydraulic_Pressure.quantile(0.25)
upper_fence = md.Hydraulic_Pressure.quantile(0.75)+(IQR*1.5)
lower_fence = md.Hydraulic_Pressure.quantile(0.25)-(IQR*1.5)

#TRIM OUTLIERS
import numpy as np
OUTLIER = np.where(md.Hydraulic_Pressure>upper_fence,True,np.where(md.Hydraulic_Pressure<lower_fence,True,False))
outliers = md.loc[OUTLIER,]
df_trim_outliers = md.loc[~(OUTLIER)]
df_trim_outliers.shape

# NOW VIEW OUTLIERS
sns.boxplot(df_trim_outliers.Hydraulic_Pressure)

#REPLACE OUTLIERS
IQR = md.Voltage.quantile(0.75)-md.Voltage.quantile(0.25)
upper_fence = md.Voltage.quantile(0.75)+(IQR*1.5)
lower_fence = md.Voltage.quantile(0.25)-(IQR*1.5)
md.Voltage = pd.DataFrame(np.where(md.Voltage>upper_fence,upper_fence,np.where(md.Voltage<lower_fence,lower_fence,md.Voltage)))
sns.boxplot(md.Voltage)

#WINSORIZATION - RETAINING OUTLIERS
from feature_engine.outliers import Winsorizer
#By IQR method
retained = Winsorizer(capping_method= 'iqr',
                      tail = 'both',  # cap left, right or both tails
                      fold= 1.5,
                      variables=['Hydraulic_Pressure','Coolant_Pressure','Air_System_Pressure','Coolant_Temperature',
                                 'Hydraulic_Oil_Temperature','Spindle_Bearing_Temperature','Spindle_Vibration','Tool_Vibration',
                                 'Spindle_Speed','Voltage','Torque'])
help(Winsorizer())
md = retained.fit_transform(md[['Date','Machine_ID','Assembly_Line_No','Hydraulic_Pressure','Coolant_Pressure',
                                'Air_System_Pressure','Coolant_Temperature','Hydraulic_Oil_Temperature','Spindle_Bearing_Temperature','Spindle_Vibration',
                                'Tool_Vibration','Spindle_Speed','Voltage','Torque','Cutting','Downtime']])

sns.boxplot(md.Torque)

'''ValueError: Some of the variables in the dataset contain NaN. Check and remove those before using this transformer.'''

############################################  MISSING VALUES IMPUTATION  ############################################
from sklearn.impute import SimpleImputer
import numpy as np
#If Outliers exists mean is influenced by outliers so perform median imputation
median_impute = SimpleImputer(missing_values=np.nan,strategy='median')

#Fit back to data frame
md.Voltage = pd.DataFrame(median_impute.fit_transform(md[['Voltage']]))

#recheck 
md.isna().sum()
md.Voltage.isnull()

md.dropna()

md.Hydraulic_Pressure = pd.DataFrame(median_impute.fit_transform(md[['Hydraulic_Pressure']]))
md.Coolant_Pressure  =  pd.DataFrame(median_impute.fit_transform(md[['Coolant_Pressure']]))
md.Air_System_Pressure  =  pd.DataFrame(median_impute.fit_transform(md[['Air_System_Pressure']]))
md.Coolant_Temperature = pd.DataFrame(median_impute.fit_transform(md[['Coolant_Temperature']]))
md.Hydraulic_Oil_Temperature  =  pd.DataFrame(median_impute.fit_transform(md[['Hydraulic_Oil_Temperature']]))
md.Spindle_Bearing_Temperature  =  pd.DataFrame(median_impute.fit_transform(md[['Spindle_Bearing_Temperature']]))
md.Spindle_Vibration  =  pd.DataFrame(median_impute.fit_transform(md[['Spindle_Vibration']]))
md.Tool_Vibration  =  pd.DataFrame(median_impute.fit_transform(md[['Tool_Vibration']]))
md.Spindle_Speed  =  pd.DataFrame(median_impute.fit_transform(md[['Spindle_Speed']]))
md.Voltage  =  pd.DataFrame(median_impute.fit_transform(md[['Voltage']]))
md.Torque  =  pd.DataFrame(median_impute.fit_transform(md[['Torque']]))

#To fix all changes at a time
median_impute = SimpleImputer(missing_values = np.nan, strategy = 'median')
md[["Hydraulic_Pressure","Coolant_Pressure","Air_System_Pressure",
              "Coolant_Temperature","Hydraulic_Oil_Temperature","Spindle_Bearing_Temperature",
              "Spindle_Vibration","Tool_Vibration","Spindle_Speed","Voltage","Torque"]] = pd.DataFrame(
                  median_impute.fit_transform(md[["Hydraulic_Pressure","Coolant_Pressure","Air_System_Pressure",
                                "Coolant_Temperature","Hydraulic_Oil_Temperature","Spindle_Bearing_Temperature",
                                "Spindle_Vibration","Tool_Vibration","Spindle_Speed","Voltage","Torque"]]))
                  
#mean imputation
mean_impute = SimpleImputer(missing_values=np.nan,strategy='mean')
md.Cutting = pd.DataFrame(mean_impute.fit_transform(md[['Cutting']]))

#retaining By stddev method
gaussian = Winsorizer(capping_method='gaussian',
                      tail='both',
                      fold=3,
                      variables=['Hydraulic_Pressure'])

md.Hydraulic_Pressure = gaussian.fit_transform(md[['Hydraulic_Pressure']])

#retaining by percentile method
percentile = Winsorizer(capping_method='quantiles',
                        tail='both', # cap left, right or both tails
                        fold=0.05,  # limits will be the 5th and 95th percentiles
                        variables=['Air_System_Pressure'])

md.Air_System_Pressure = percentile.fit_transform(md[['Air_System_Pressure']])

########################################  DISCRETISATION/BINARISATION  ##################################################
# numerical to categorical

md['Coolant_Pressure']=pd.cut(md['Coolant_Pressure'],
                                     bins=[min(md['Coolant_Pressure']),
                                              md['Coolant_Pressure'].mean(),
                                              max(md['Coolant_Pressure'])],
                                     include_lowest=True,
                                     labels=["low",'high'])
help(pd.cut)

######################################## DUMMY VARIABLE CREATION  ###############################################
# categorical to numerical
dummy_columns = pd.get_dummies(md['Machine_ID'],drop_first=True)
md=pd.concat([md,dummy_columns],axis=1)
md=md.drop(['Machine_ID'],axis=1)

######################################  ONE HOT ENCODING / BINARY ENCODING #######################################
#nominal data to numerical
from sklearn.preprocessing import OneHotEncoder
onehot = OneHotEncoder()
df=pd.DataFrame(onehot.fit_transform(md.iloc[:,14:15]).toarray())
md=pd.concat([md,df],axis=1)
md=md.drop(['Downtime'],axis=1)

####################################  LABEL ENCODING  ######################################################
#ordinal data to numerical
from sklearn.preprocessing import LabelEncoder
label = LabelEncoder()
X = md.iloc[:,:] #input variable
Y = md.iloc[:,:] #output variable
md.Assembly_Line_No= label.fit_transform(X[['Assembly_Line_No']])

##################################  TRANSFORMATION  ###################################################
#log transformation
import numpy as np
md.Voltage = np.log(md.Voltage)

import scipy.stats as stats
import pylab
stats.probplot(md.Tool_Vibration,dist='norm',plot=pylab)
fitted_data, fitted_lambda = stats.boxcox(md.Tool_Vibration)
stats.probplot(fitted_data,dist='norm',plot=pylab)
stats.probplot(np.log(md.Tool_Vibration),dist='norm',plot=pylab)
stats.probplot(np.sqrt(md.Tool_Vibration),dist='norm',plot=pylab)
stats.probplot(np.exp(md.Tool_Vibration),dist='norm',plot=pylab)

#yeo jhonson transformation on one column
from feature_engine import transformation
ss=transformation.YeoJohnsonTransformer(variables='Spindle_Speed')
md['Spindle_Speed'] = ss.fit_transform(md[['Spindle_Speed']])

stats.probplot(md.Spindle_Speed,dist='norm',plot=pylab)

#yeo jhonson transformation on multiple columns
multiple = transformation.YeoJohnsonTransformer(variables=['Torque','Hydraulic_Oil_Temperature'])
md[['Torque','Hydraulic_Oil_Temperature']] = multiple.fit_transform(md[['Torque','Hydraulic_Oil_Temperature']])

################################### DATA SCALING ###################################################
#normalisation
from sklearn.preprocessing import MinMaxScaler
minmax = MinMaxScaler()
md.Tool_Vibration = minmax.fit_transform(md[['Tool_Vibration']])

#standardization
from sklearn.preprocessing import StandardScaler
standard = StandardScaler()
md.Spindle_Vibration = standard.fit_transform(md[['Spindle_Vibration']])

#robust scaling
from sklearn.preprocessing import RobustScaler
robust = RobustScaler()
md[['Hydraulic_Pressure','Hydraulic_Pressure']] = robust.fit_transform(md[['Hydraulic_Pressure','Hydraulic_Pressure']])


#AUTO EDA
#sweetviz library
import sweetviz as sv
s=sv.analyze(md)
s.show_html()

#dtale library
import dtale
dt = dtale.show(md)
dt.open_browser()

#Auto viz
pip install autoviz --upgrade

from autoviz.AutoViz_Class import AutoViz_Class

# Instantiate AutoViz_Class
av = AutoViz_Class()

# Use AutoViz to visualize the dataset
a = av.AutoViz(r'C:\PROJECT 2\Data Set\Machine_Downtime.csv', chart_format='html')

