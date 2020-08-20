### HathiTrust Covid-19 Data Cleanup workflow 
### This script combines the standardized Excel files into one spreadsheet. It then outputs
### the records that contain OCLC numbers.


# Libraries
library(tidyverse)

## Combine all of the output CSV files
df_9_column_csvs <- read.csv(file = "hathi_all_9_columns.csv", stringsAsFactors = FALSE)

df_10_column_csvs <- read.csv(file = "hathi_10_columns.csv", stringsAsFactors = FALSE)

df_combined_csvs <- bind_rows(df_9_column_csvs, df_10_column_csvs) %>%
  filter(OskiCat.Record != "") %>%
  distinct()

# Remove NA's from the dataframe
df_combined_csvs[is.na(df_combined_csvs)] = ""

## Extract records having OCLC numbers
df_all_oclc_numbers <- df_combined_csvs %>%
  filter(OCLC != "")

## Add in hyperlinks for the OskiCat records
for (i in 1:nrow(df_all_oclc_numbers)) {
  url <- paste0("http://oskicat.berkeley.edu/record=", df_all_oclc_numbers$`RECORD...ITEM.`[i])
  
  url_edit <- substr(url,1, nchar(url)-1)
  
  formula <- paste0('=HYPERLINK("',url_edit,'",A',i+1,')')
  
  df_all_oclc_numbers$OskiCat.Record[i] <- formula
  
}

# Write output file
write.csv(df_all_oclc_numbers, file = "hathi_all_oclc_numbers.csv", row.names = FALSE)
