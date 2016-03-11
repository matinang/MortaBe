## MortaBe
A replication of the construction of the 2015 IA|BE mortality tables

#### Context

#### Input

##### Country selection
The input mortality data refers to 14 european countries (or sub-populations), namely: Belgium, The Netherlands, Luxembourg, Norway, Switzerland, Austria, Ireland, Sweden, Denmark, West Germany, Finland, Iceland, England & Wales and France. The selection criterion is having a GNP per capita (based on the World Bank [GNI per capita](http://data.worldbank.org/indicator/NY.GNP.PCAP.CD) indicator) higher than the European average as of year 2013. 

##### Construction of the dataset

Mortality data for the selected countries has been obtained from the [Human Mortality Database](http://www.mortality.org/). The used tables are 1x1 (age x year) 'Deaths' and 'Exposure to risk' tables. The timeframe is years 1970 to 2009 included. For Belgium the selection is extended to 2012 and observations on death and exposure to risk for 2013 are used to supplement the dataset.

*Comments regarding this repo:*

- *The country selection has not been reproduced yet, as the initial selection of European countries is not specified in the IA|BE report.*
- *In conformity with the [HMD User Agreement](http://www.mortality.org/Public/UserAgreement.php), the input data files are not distributed in this repository.*
- *The data source as of 2013 for Belgium has not been specified, therefore the relevant data has not been included in the replication. The impact of this differences is to be estimated*


