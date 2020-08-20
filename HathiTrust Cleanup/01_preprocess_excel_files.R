### HathiTrust Covid-19 Data Cleanup workflow 
### This script cleans the Excel files so they end up as 9 and 10-column standardized files. 
### I manually separated  the files based on the number of columns (8, 9, and 10) and 
### processed each group individually.

# Libraries
library(tidyverse)
library(readxl)

## Create txt files that list the column names and column counts to help reorganize the files
## into separate folders.

# Read in Excel files and combine them (works for 8-column files)
list_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

df_excel_files <- sapply(list_excel_files, read_excel, simplify = FALSE) %>%
  bind_rows() # remove this line when reading in the 10-column files


list_column_names <- sapply(df_excel_files, colnames)

df_column_names <- data.frame(matrix(unlist(list_column_names), nrow=length(list_column_names), byrow=T))  

write.csv(df_column_names, file = "hathi_no_oclc_column_names.csv")

# Output column names to a text file
capture.output(print(list_column_names), file = "My New File2.txt")

# Output number of columns in each file to a text file
capture.output(summary(list_column_names), file = "My New File.txt")

## Use the text files to separate the Excel files into different folders based 
## on the number of columns. Manual edits will need to be done on the spreadsheets to ensure
## the header rows are on the top of each spreadsheet.


####  8-column files
## Read in the 8-column files, and then add a blank column for OCLC numbers.
list_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

df_excel_files <- sapply(list_excel_files, read_excel, simplify = FALSE) %>%
  bind_rows()


df_excel_files$OCLC <- ""

# Remove NA's from the dataframe
df_excel_files[is.na(df_excel_files)] = ""

write.csv(df_excel_files, file = "hathi_9_columns.csv", row.names = FALSE)

#### 9-column files 
## I manually added the 9-column Excel file to the combined 8-column files

####  10-column files
## Read in the 10-column files
list_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

# Read in all columns as text (characters)
df_excel_files <- sapply(list_excel_files, read_excel, simplify = FALSE, col_types = "text") %>%
  bind_rows()

# Remove all of the notes columns
df_excel_files_no_notes <- df_excel_files %>%
  select (1,2,3,4,5,6,7,8,9,12,13,14,16)

# Remove all NA's from the data frame
df_excel_files_no_notes[is.na(df_excel_files_no_notes)] = ""

# Create new column to hold the OCLCs from the multiple OCLC columns
df_excel_files_merged_oclcs <- unite(df_excel_files_no_notes, "OCLC", 9:13 )

# Clean OCLC numbers (remove underscores, periods, and numbers after "E")
df_excel_files_merged_oclcs$OCLC <- gsub('_', '', df_excel_files_merged_oclcs$OCLC)

df_excel_files_merged_oclcs$OCLC <- gsub('\\.', '', df_excel_files_merged_oclcs$OCLC)

df_excel_files_merged_oclcs$OCLC <- gsub('E.*', '', df_excel_files_merged_oclcs$OCLC)

write.csv(df_excel_files_merged_oclcs, file = "hathi_10_columns.csv", row.names = FALSE)