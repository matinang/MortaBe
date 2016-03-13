library(readr)
library(dplyr)

# 1. Country Selection --------------------------------------------------------

# read data
all_indicators <- read_csv("Data/world-bank/World_Bank_Data_Eur_allyrs.csv")

# filter data
all_indicators %>%
  select(cntr_name = `<U+FEFF>Country Name`,
         cntr_code = `Country Code`,
         series_name = `Series Name`,
         series_code = `Series Code`,
         YR2013 = `2013 [YR2013]`) %>%
  filter(series_name == "GNI per capita, Atlas method (current US$)") ->
  gni_pcap_2013

# select the countries to be used for the analysis
gni_pcap_2013$YR2013 <- as.numeric(gni_pcap_2013$YR2013)

gni_pcap_2013[c(1,3:22,24:29),] %>% # removing Russia, Belarus and Ukraine
  filter(YR2013 > mean(YR2013)) %>%
  select(cntr_name, cntr_code) -> selected_cntr

# verify that the mean is equal to the reported one
mean(gni_pcap_2013[c(1,3:22,24:29),]$YR2013)

# 2. Construction of the dataset ----------------------------------------------


