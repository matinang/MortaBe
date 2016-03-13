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

# Selecting sub-populations for France, Germany and the UK
selected_cntr %>%
  # selecting the total population dataset for France
  mutate(cntr_code = replace(cntr_code, cntr_code == "FRA", "FRATNP")) %>%
  # taking into account West Germany only
  mutate(cntr_name = replace(cntr_name, cntr_code == "DEU", "West Germany")) %>%
  mutate(cntr_code = replace(cntr_code, cntr_code == "DEU", "DEUTW")) %>%
  # taking into account England & Wales instead of the complete UK dataset
  mutate(cntr_name = replace(cntr_name, cntr_code == "GBR", "England & Wales")) %>%
  mutate(cntr_code = replace(cntr_code, cntr_code == "GBR", "GBRTENW")) ->
  selected_pop

lapply(selected_pop$cntr_code,
       function(x){
         read_table(
           paste0("Data/human-mortality-database/Deaths_1x1/",
                  x, ".Deaths_1x1.txt"), skip = 2,
           col_types = cols(Year = "i", Age = "i",
                            Female = "d", Male = "d", Total = "d")) %>%
           mutate(cntr_code = as.character(x))
         }) %>% rbind_all -> deathDB