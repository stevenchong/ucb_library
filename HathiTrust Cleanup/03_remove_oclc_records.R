### HathiTrust Covid-19 Data Cleanup workflow 
### This script removes the records that have an OCLC number from the 
### downloaded Excel files.

# Libraries
library(tidyverse)
library(openxlsx)

### Subdirectory to store edited files (switch to 8-column folder first)
subDir <- "/edited_files"
dir.create(file.path(getwd(), subDir), showWarnings = FALSE)

# Read 8-column Excel files
list_8_column_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

# Add an OCLC column to each file
for (excel_file in list_8_column_excel_files) {
  
  # Get the filename minus the .xlsx extension
  filename <- basename(excel_file) 
  
  # Read the Excel file
  wb <- loadWorkbook(excel_file)
  
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
  

  # Change the hyperlink column cells into hyperlinks
  class(temp_excel_file$OskiCat.Record) <- c(class(temp_excel_file$OskiCat.Record), "formula")
 
  
  # Change the font style for the hyperlink column (column 2)
  hyperlink_column_style <- createStyle (textDecoration = "underline")
  
  addStyle(wb, sheet = 1, hyperlink_column_style, cols = 2, rows = 1 )
  
  # Output the edited Excel file
  writeData(wb, 1, temp_excel_file)
  
  saveWorkbook(wb, file=paste0("./edited_files/",filename), overwrite = TRUE)
}


### Subdirectory to store edited files (switch to 9-column folder first) 
subDir <- "/edited_files"
dir.create(file.path(getwd(), subDir), showWarnings = FALSE)


# Read 9-column Excel files
list_9_column_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

# Add an OCLC column to each file
for (excel_file in list_9_column_excel_files) {
  
  # Get the filename minus the .xlsx extension
  filename <- basename(excel_file)
  
  # Read the Excel file
  wb <- loadWorkbook(excel_file)
  
  temp_excel_file <- readWorkbook(excel_file)
    
  # Remove all NA's from the data frame
  temp_excel_file[is.na(temp_excel_file)] = ""
  
  # Filter the Excel file to show only records without OCLC numbers
  temp_excel_file <- temp_excel_file %>%
    filter (OCLC.number == "") %>%
    filter (OskiCat.Record != "")
  
  # Add in hyperlinks for the OskiCat records
  for (i in 1:nrow(temp_excel_file)) {
    url <- paste0("http://oskicat.berkeley.edu/record=", temp_excel_file$`RECORD.#(ITEM)`[i])
    
    url_edit <- substr(url,1, nchar(url)-1)
    
    formula <- paste0('=HYPERLINK("',url_edit,'",A',i+1,')')
    
    temp_excel_file$OskiCat.Record[i] <- formula
    
  }
  
  # Change the hyperlink column cells into hyperlinks
  class(temp_excel_file$OskiCat.Record) <- c(class(temp_excel_file$OskiCat.Record), "formula")
  
  # Change the font style for the hyperlink column (column 2)
  hyperlink_column_style <- createStyle (textDecoration = "underline")
  
  addStyle(wb, sheet = 1, hyperlink_column_style, cols = 2, rows = 2 )
  
  # Output the edited Excel file
  writeData(wb, 1, temp_excel_file)
  
  saveWorkbook(wb, file=paste0("./edited_files/",filename), overwrite = TRUE)


}

### Subdirectory to store edited files (switch to 10-column folder first)
subDir <- "/edited_files"
dir.create(file.path(getwd(), subDir), showWarnings = FALSE)

# Read 10-column Excel files
list_10_column_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

# Add an OCLC column to each file
for (excel_file in list_10_column_excel_files) {
  
  # Get the filename minus the .xlsx extension
  filename <- basename(excel_file) 
  
  # Read the Excel file
  wb <- loadWorkbook(excel_file)
  
  temp_excel_file <- readWorkbook(wb, na.strings=c("","\n","NA")) # replace blank and newlines with NA

  # Rename the OCLC column
  names(temp_excel_file)[9] <- "OCLC"
  
  # Rename the notes column
  names(temp_excel_file)[10] <- "Notes" 
  
  
  
  # Remove all NA's from the data frame
  temp_excel_file[is.na(temp_excel_file)] = ""
  
  # Get length of Excel file
  excel_file_length <- length(temp_excel_file)
   
  # Replace the rows containing OCLC numbers with blanks

  for (j in 1:nrow(temp_excel_file)) {

    if (temp_excel_file$OCLC[j] != "") {
     
      temp_excel_file$`RECORD.#(ITEM)`[j] <- ""
      temp_excel_file$`OskiCat.Record`[j] <- ""
      temp_excel_file$I.TYPE[j] <- ""
      temp_excel_file$LOCATION[j] <- ""
      temp_excel_file$`CALL.#`[j] <- ""
      temp_excel_file$Hathi.Record[j] <- ""
      temp_excel_file$NRLF.Barcode[j] <- ""
      temp_excel_file$UCB.Barcode[j] <- ""
      temp_excel_file$OCLC[j] <- ""
      temp_excel_file$Notes[j] <- ""

    }

  }
  
  # Add in hyperlinks for the OskiCat records
  for (i in 1:nrow(temp_excel_file)) {
    url <- paste0("http://oskicat.berkeley.edu/record=", temp_excel_file$`RECORD.#(ITEM)`[i])
    
    url_edit <- substr(url,1, nchar(url)-1)
    
    formula <- paste0('=HYPERLINK("',url_edit,'",A',i+1,')')
    
    temp_excel_file$OskiCat.Record[i] <- formula
    
  }
  
  # Change the hyperlink column cells into hyperlinks
  class(temp_excel_file$OskiCat.Record) <- c(class(temp_excel_file$OskiCat.Record), "formula")
  
  # Change the font style for the hyperlink column (column 2)
  hyperlink_column_style <- createStyle (textDecoration = "underline")
  
  addStyle(wb, sheet = 1, hyperlink_column_style, cols = 2, rows = 1 )
  
  
  # Output the edited Excel file
  writeData(wb, sheet = 1, temp_excel_file)
   
  saveWorkbook(wb, file=paste0("./edited_files/",filename), overwrite = TRUE)
  
  
}

### Subdirectory to store edited files (switch to 11-column folder first)
subDir <- "/edited_files"
dir.create(file.path(getwd(), subDir), showWarnings = FALSE)

# Read 11-column Excel files
list_11_column_excel_files <- list.files(full.names = TRUE, pattern = ".xlsx")

# Add an OCLC column to each file
for (excel_file in list_11_column_excel_files) {
  
  # Get the filename minus the .xlsx extension
  filename <- basename(excel_file) 
  
  # Read the Excel file
  wb <- loadWorkbook(excel_file)
  
  temp_excel_file <- readWorkbook(wb, na.strings=c("","\n","NA")) # replace blank and newlines with NA
  
  # Rename the OCLC column
  names(temp_excel_file)[9] <- "OCLC"
  
  # Remove all NA's from the data frame
  temp_excel_file[is.na(temp_excel_file)] = ""
  
  # Get length of Excel file
  excel_file_length <- length(temp_excel_file)
  
  # Replace the rows containing OCLC numbers with blanks
  
  for (j in 1:nrow(temp_excel_file)) {
    
    if (temp_excel_file$OCLC[j] != "") {
      
      temp_excel_file$`RECORD.#(ITEM)`[j] <- ""
      temp_excel_file$`OskiCat.Record`[j] <- ""
      temp_excel_file$I.TYPE[j] <- ""
      temp_excel_file$LOCATION[j] <- ""
      temp_excel_file$`CALL.#`[j] <- ""
      temp_excel_file$Hathi.Record[j] <- ""
      temp_excel_file$NRLF.Barcode[j] <- ""
      temp_excel_file$UCB.Barcode[j] <- ""
      temp_excel_file$OCLC[j] <- ""
      temp_excel_file$Notes[j] <- ""
      temp_excel_file$FOR.FINAL.SORT[j] <- ""
      temp_excel_file$Language[j] <- ""
      temp_excel_file$NOTES[j] <- ""
      
    }
    
  }
  
  # Select only the number of columns that are in the original Excel file
  temp_excel_file <- temp_excel_file %>%
    select (1:excel_file_length)
  
  
  # Add in hyperlinks for the OskiCat records
  for (i in 1:nrow(temp_excel_file)) {
    url <- paste0("http://oskicat.berkeley.edu/record=", temp_excel_file$`RECORD.#(ITEM)`[i])
    
    url_edit <- substr(url,1, nchar(url)-1)
    
    formula <- paste0('=HYPERLINK("',url_edit,'",A',i+1,')')
    
    temp_excel_file$OskiCat.Record[i] <- formula
    
  }
  
  # Change the hyperlink column cells into hyperlinks
  class(temp_excel_file$OskiCat.Record) <- c(class(temp_excel_file$OskiCat.Record), "formula")
  
  # Change the font style for the hyperlink column (column 2)
  hyperlink_column_style <- createStyle (textDecoration = "underline")
  
  addStyle(wb, sheet = 1, hyperlink_column_style, cols = 2, rows = 1 )
 
  
  # Output the edited Excel file
  writeData(wb, sheet = 1, temp_excel_file)
  
  saveWorkbook(wb, file=paste0("./edited_files/",filename), overwrite = TRUE)
  
  
}




