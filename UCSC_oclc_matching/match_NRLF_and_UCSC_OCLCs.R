### This script reads in text files containing lists of OCLC files from UCSC and Millennium in separate lines. 
### It pads the UCSC OCLCs with leading zeros to determine if a match can be made with the OCLCs in Millennium.
### CSV files are exported 

library (tidyverse)

# Read in .txt file
Millennium_oclcs <- read.csv(file= "oclcs_in_millenium.txt", header = FALSE, stringsAsFactors = FALSE) %>%
  select (Millennium_oclc = V1) 

# Remove text before the OCLC number
Millennium_oclcs<- data.frame(lapply(Millennium_oclcs, function(x) {
  gsub(".*ocm", "", x)
  } ))

Millennium_oclcs<- data.frame(lapply(Millennium_oclcs, function(x) {
  gsub(".*ocn", "", x)
} ))

Millennium_oclcs<- data.frame(lapply(Millennium_oclcs, function(x) {
  gsub(".*on", "", x)
} ))

# Remove text after the OCLC number
Millennium_oclcs<- data.frame(lapply(Millennium_oclcs, function(x) {
  gsub("Jump.*", "", x)
} ))

# Remove any trailing whitespaces
Millennium_oclcs <- data.frame(lapply(Millennium_oclcs, trimws), stringsAsFactors = FALSE) 

# Export duplicate OCLCs
duplicate_oclcs <- Millennium_oclcs[duplicated(Millennium_oclcs),]

#write.csv(duplicate_oclcs, file = "Millennium_duplicate_oclcs.csv", row.names = FALSE)

# Export CSV of unique OCLCs in Millennium
unique_Millennium_oclcs <- Millennium_oclcs %>%
  distinct()

#write.csv(unique_Millennium_oclcs, file = "unique_oclcs_in_Millennium.csv", row.names = FALSE)


# Read in UCSC OCLCs
ucsc_oclcs <- read.csv(file= "ucsc_all_oclcs.txt", header = FALSE, stringsAsFactors = FALSE) %>%
  select (ucsc_oclc = V1) 


# Remove text after "Jump"
ucsc_oclcs <- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub("Jump.*", "", x)
} ))

# Remove the =001
ucsc_oclcs <- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub("=001  ", "", x) 
  } ))

# Remove the backslashes
ucsc_oclcs <- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub("\\\\", "", x) 
  } ))

# Remove the $9ExL
ucsc_oclcs <- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub("\\$9ExL", "", x) 
} ))

# Remove text before "the OCLC number "ocm"
ucsc_oclcs<- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub(".*ocm", "", x)} ))

# Replace $a and $z with spaces
ucsc_oclcs<- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub("\\$a", " ", x)
  } ))

ucsc_oclcs<- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub("\\$z", " ", x)
} ))

# Remove any trailing whitespaces
ucsc_oclcs <- data.frame(lapply(ucsc_oclcs, trimws), stringsAsFactors = FALSE) 

# Separate rows by white space
ucsc_oclcs <- separate_rows(ucsc_oclcs, ucsc_oclc, convert = TRUE, sep = " " )


# Remove text before the right parenthesis
ucsc_oclcs<- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub(".*)", "", x) } ))

# Remove any letters
ucsc_oclcs<- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub("[[:alpha:]]", "", x) } ))

# Remove any left parenthesis
ucsc_oclcs<- data.frame(lapply(ucsc_oclcs, function(x) {
  gsub("[(]", "", x) 
  } ))

# Remove any empty rows and get unique rows
ucsc_oclcs <- ucsc_oclcs %>%
  filter (ucsc_oclc != "") %>%
  distinct()


# Export CSV of unique UCSC OCLCs
#write.csv(ucsc_oclcs, file = "unique_ucsc_oclcs.csv", row.names = FALSE)

### Pad UCSC OCLCs with zeros up to 8,9, and 10 digits, add to the unique UCSC OCLC dataframe
unique_ucsc_oclcs <- as.data.frame(as.character(ucsc_oclcs$ucsc_oclc), stringsAsFactors = FALSE)
 
names(unique_ucsc_oclcs)[1] <- "ucsc_oclc"
   

unique_ucsc_oclcs$UCSC_OCLCs_8_digits <- str_pad (unique_ucsc_oclcs$ucsc_oclc, 8, pad = "0")

# Pad UCSC OCLCs with zeros up to 9 digits, add to the unique UCSC OCLC dataframe
unique_ucsc_oclcs$UCSC_OCLCs_9_digits <- str_pad (unique_ucsc_oclcs$ucsc_oclc, 9, pad = "0") 

# Pad UCSC OCLCs with zeros up to 9 digits, add to the unique UCSC OCLC dataframe
unique_ucsc_oclcs$UCSC_OCLCs_10_digits <- str_pad (unique_ucsc_oclcs$ucsc_oclc, 10, pad = "0") 

# Combine the different variations of the UCSC OCLC numbers into a single column
df_ucsc_original_oclc <- unique_ucsc_oclcs %>%
  select (ucsc_oclc) %>%
  select ("oclc" = "ucsc_oclc")

df_8_digits <- unique_ucsc_oclcs %>%
  select (UCSC_OCLCs_8_digits) %>%
  select ("oclc" = "UCSC_OCLCs_8_digits")
  
df_9_digits <- unique_ucsc_oclcs %>%
  select (UCSC_OCLCs_9_digits) %>%
  select ("oclc" = "UCSC_OCLCs_9_digits")

df_10_digits <- unique_ucsc_oclcs %>%
  select (UCSC_OCLCs_10_digits) %>%
  select ("oclc" = "UCSC_OCLCs_10_digits")

df_single_column <- rbind(df_ucsc_original_oclc, df_8_digits, df_9_digits, df_10_digits) %>%
  distinct


# Join UCSC OCLCs to Millennium OCLCs
unique_Millennium_oclcs$match_in_Millennium_found <- "yes"


df_joined <- merge(y = unique_Millennium_oclcs, x = df_single_column, by.y = "Millennium_oclc",
                   by.x = "oclc", all.x = TRUE) 
  

df_joined[is.na(df_joined)] <- "no"


### Counts of original (untransformed) UCSC OCLCs without matches in Millennium

df_count_nos <- df_joined %>%
  filter(match_in_Millennium_found == "no") %>%
  distinct()


df_no_matches <- df_ucsc_original_oclc %>%
  distinct()

df_no_matches <- merge(df_count_nos, df_no_matches, by = "oclc") %>%
  distinct()


### Counts of OCLCs with matches in Millennium

df_joined <- df_joined %>%
  filter(match_in_Millennium_found == "yes")

# Merge joined with original UCSC numbers
df_ucsc_original_oclc$UCSC_original_oclc <- df_ucsc_original_oclc$oclc

df_joined <- merge(x = df_joined, y = df_ucsc_original_oclc, by.x = "oclc",
                       by.y = "oclc", all.x = TRUE)

# Merge joined with 8-digit, 9-digit, and 10-digit UCSC numbers
df_8_digits$new_8_digit_oclc <- df_8_digits$oclc

df_joined <- merge(x = df_joined, y = df_8_digits, by.x = "oclc",
                  by.y = "oclc", all.x = TRUE)

df_joined[is.na(df_joined)] <- ""

df_joined <- transform(df_joined, new_8_digit_oclc = ifelse(UCSC_original_oclc == "" , oclc, "" ))


df_9_digits$new_9_digit_oclc <- df_9_digits$oclc

df_joined <- merge(x = df_joined, y = df_9_digits, by.x = "oclc",
                  by.y = "oclc", all.x = TRUE)

df_joined <- transform(df_joined, new_9_digit_oclc = ifelse(UCSC_original_oclc == "" &&
                                                            new_8_digit_oclc == "", 
                                                            oclc, ""))


df_10_digits$new_10_digit_oclc <- df_10_digits$oclc

df_joined <- merge(x = df_joined, y = df_10_digits, by.x = "oclc",
                   by.y = "oclc", all.x = TRUE)

df_joined <- transform(df_joined, new_10_digit_oclc = ifelse(UCSC_original_oclc == "" &&
                                                               new_8_digit_oclc == "" &&
                                                              new_9_digit_oclc == "", 
                                                            oclc, ""))


df_joined <- df_joined %>%
  distinct()

# Change column names
df_joined <- df_joined %>%
  rename ("oclc_all_variations" = "oclc") %>%
  rename ("padded_8_UCSC_digit_oclc" = "new_8_digit_oclc") %>%
  rename ("padded_9_UCSC_digit_oclc" = "new_9_digit_oclc") %>%
  rename ("padded_10_UCSC_digit_oclc" = "new_10_digit_oclc")


# Export CSVs
write.csv(df_joined, file = "ucsc_oclc_matches_in_Millennium.csv", row.names = FALSE)




### Checking counts
df_count_yes <- df_joined %>%
  select(UCSC_original_oclc) %>%
  filter (UCSC_original_oclc != "")

df_test <- df_joined %>%
  filter (UCSC_original_oclc == "") %>%
  filter (padded_8_digit_oclc == "" ) 


for (row in 1:nrow(df_test)){
  if (nchar ( df_test$oclc_all_variations[row] ) >8){
    print(df_test$oclc_all_variations[row])
  }
  
}

