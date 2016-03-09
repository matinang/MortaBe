library(readr)
library(dplyr)

# 1. Country Selection --------------------------------------------------------

# read data
all_indicators <- read_csv("World_Bank_Data_EU_1970_to_2015.csv")

# filter data
all_indicators %>%
  select(country_name = `<U+FEFF>Country Name`,
         country_code = `Country Code`,
         series_name = `Series Name`,
         series_code = `Series Code`,
         YR2013 = `2013 [YR2013]`) %>%
  filter(series_name == "GNI per capita, Atlas method (current US$)") ->
  gni_pcap_2013

# select the countries to be used for the analysis
gni_pcap_2013$YR2013 <- as.numeric(gni_pcap_2013$YR2013)
gni_pcap_2013 %>% filter(YR2013 > mean(YR2013)) %>% select(country_name)
mean(gni_pcap_2013$YR2013)

# 2. Construction of the dataset ----------------------------------------------


html("http://www.mortality.org/hmd/AUT/STATS/Deaths_1x1.txt")