### HathiTrust Covid-19 Data Cleanup workflow 
### This script removes the records that have an OCLC number from the 
### downloaded Excel files.

# Libraries
library(tidyverse)
library(readxl)
library(openxlsx)

# Subdirectory to store edited files (switch to 8-column folder first)
subDir <- "/edited_files"
dir.create(file.path(getwd(), subDir), showWarnings = FALSE)

# Read 8-column Excel files
list_8_column_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

# Add an OCLC column to each file
for (excel_file in list_8_column_excel_files) {
  
  # Get the filename minus the .xlsx extension
  filename <- basename(excel_file) 
  
  # Read the Excel file
  temp_excel_file <- readWorkbook(excel_file)
  
  # Add the OCLC column
  temp_excel_file$OCLC <- ""
  
  # Remove all NA's from the data frame
  temp_excel_file[is.na(temp_excel_file)] = ""
  

  # Add in hyperlinks for the OskiCat records
  for (i in 1:nrow(temp_excel_file)) {
    url <- paste0("http://oskicat.berkeley.edu/record=", temp_excel_file$`RECORD.#(ITEM)`[i])
    
    url_edit <- substr(url,1, nchar(url)-1)
      
    formula <- paste0('=HYPERLINK("',url_edit,'",A',i+1,')')
    
    temp_excel_file$OskiCat.Record[i] <- formula

  }
  

  # Output the edited Excel file
  write.xlsx(temp_excel_file, file=paste("./edited_files/",filename) )
  
}


# Subdirectory to store edited files (switch to 9-column folder first) 
subDir <- "/edited_files"
dir.create(file.path(getwd(), subDir), showWarnings = FALSE)


# Read 9-column Excel files
list_9_column_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

# Add an OCLC column to each file
for (excel_file in list_9_column_excel_files) {
  
  # Get the filename minus the .xlsx extension
  filename <- basename(excel_file)
  
  # Read the Excel file
  temp_excel_file <- read_excel(excel_file)
    
  # Remove all NA's from the data frame
  temp_excel_file[is.na(temp_excel_file)] = ""
  
  # Filter the Excel file to show only records without OCLC numbers
  temp_excel_file <- temp_excel_file %>%
    filter (OCLC == "") %>%
    filter (`OskiCat Record` != "")
  
  # Add in hyperlinks for the OskiCat records
  for (i in 1:nrow(temp_excel_file)) {
    url <- paste0("http://oskicat.berkeley.edu/record=", temp_excel_file$`RECORD #(ITEM)`[i])
    
    url_edit <- substr(url,1, nchar(url)-1)
    
    formula <- paste0('=HYPERLINK("',url_edit,'",A',i+1,')')
    
    temp_excel_file$`OskiCat Record`[i] <- formula
    
  }
  

  
  
  # Output the edited Excel file
  write.xlsx(temp_excel_file, file=paste("./edited_files/",filename) )
}

# Subdirectory to store edited files (switch to 10-column folder first)
subDir <- "/edited_files"
dir.create(file.path(getwd(), subDir), showWarnings = FALSE)

# Read 10-column Excel files
list_10_column_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

# Add an OCLC column to each file
for (excel_file in list_10_column_excel_files) {
  
  # Get the filename minus the .xlsx extension
  filename <- basename(excel_file) 
  
  # Read the Excel file
  temp_excel_file <- read_excel(excel_file, col_types = "text")
  

  # Rename the OCLC column
  names(temp_excel_file)[9] <- "OCLC"
  
  # Remove all NA's from the data frame
  temp_excel_file[is.na(temp_excel_file)] = ""
  
  # Filter the Excel file to show only records without OCLC numbers
  temp_excel_file <- temp_excel_file %>%
    filter (OCLC == "") %>%
    filter (`OskiCat Record` != "")

  # Add in hyperlinks for the OskiCat records
  for (i in 1:nrow(temp_excel_file)) {
    url <- paste0("http://oskicat.berkeley.edu/record=", temp_excel_file$`RECORD #(ITEM)`[i])
    
    url_edit <- substr(url,1, nchar(url)-1)
    
    formula <- paste0('=HYPERLINK("',url_edit,'",A',i+1,')')
    
    temp_excel_file$`OskiCat Record`[i] <- formula
    
  }

  
  # Output the edited Excel file
  write.xlsx(temp_excel_file, file=paste("./edited_files/",filename) )
}
