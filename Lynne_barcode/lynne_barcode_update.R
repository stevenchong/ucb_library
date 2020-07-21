### Script for Lynne to arrange spreadsheet rows by barcode rather than record number. There 
### are multiple item numbers attached to each barcode.

#Libraries
library(tidyverse)
library(readxl)
library(data.table)

#Read in Excel file
df_barcodes <- read_excel("lynne_barcode_dups_update.xlsx")

#Convert data frame to a data table
dt_barcodes <- data.table(df_barcodes)

# Add index column that is a counter for the items associated with each barcode 
dt_barcodes_edit <- dt_barcodes[ , Index := 1:.N , by = c("barcode") ]


#Convert the data table back to a data frame
df_barcodes_edit <- data.frame(dt_barcodes_edit)

#Create data frame with the unique barcodes and their counts to merge into
df_unique_barcodes_and_counts <- df_barcodes_edit %>%
  select (barcode, countofbarcode) %>%
  distinct()

#First merge
df_barcodes_first <- df_barcodes_edit %>%
  filter (Index == 1) %>%
  select (barcode, "itemno1" = "itemno", "location1" = "location", ) # rename itemno and location

df_merged_barcodes <- merge(df_unique_barcodes_and_counts, df_barcodes_first, by = "barcode", all.x = TRUE)

#Second merge
df_barcodes_second <- df_barcodes_edit %>%
  filter (Index == 2) %>%
  select (barcode, "itemno2" = "itemno", "location2" = "location", ) # rename itemno and location

df_merged_barcodes <- merge(df_merged_barcodes, df_barcodes_second, by = "barcode", all.x = TRUE)

#Third merge
df_barcodes_third <- df_barcodes_edit %>%
  filter (Index == 3) %>%
  select (barcode, "itemno3" = "itemno", "location3" = "location", ) # rename itemno and location

df_merged_barcodes <- merge(df_merged_barcodes, df_barcodes_third, by = "barcode", all.x = TRUE)

#Fourth merge
df_barcodes_fourth <- df_barcodes_edit %>%
  filter (Index == 4) %>%
  select (barcode, "itemno4" = "itemno", "location4" = "location", ) # rename itemno and location

df_merged_barcodes <- merge(df_merged_barcodes, df_barcodes_fourth, by = "barcode", all.x = TRUE)

#Remove NA's
df_merged_barcodes[is.na(df_merged_barcodes)] = ""

#Rearrange column order
df_merged_barcodes <- df_merged_barcodes %>%
  select (countofbarcode, barcode, location1, itemno1, location2, itemno2, location3, itemno3, location4, itemno4)

#Write csv
write.csv(df_merged_barcodes, file = "barcode_dupes_update_SC.csv", row.names = FALSE)
