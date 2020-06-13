### Compares columns for titles and authors 

library(tidyverse)

df_marc_records <- read.csv(file ="compare_records.csv", stringsAsFactors = FALSE, header = FALSE)


# Remove 245 field, indicators and $a subfields from table
df_marc_records$V3 <- substring(df_marc_records$V3,11)

df_marc_records$V7 <- substring(df_marc_records$V7,11)

# Remove UCSF-NRLF 100 field, indicators and $a subfields from table
df_marc_records$V5 <- substring(df_marc_records$V5,11)


df_edited_records <- df_marc_records

# Check if Millennium titles in UCSF-NRLF titles 
fun = function(x, y) {
  grepl(x, y, ignore.case = TRUE)
}

df_edited_records$TitleMatches <- mapply(fun, df_edited_records$V3, df_edited_records$V7)


# Check if Millennium authors in UCSF-NRLF titles 
df_edited_records$AuthorMatches <- mapply(fun, df_edited_records$V1, df_edited_records$V5)


# Rename and select relevant columns

df_edited_records <- df_edited_records %>%
  select(V1, V3, V4, AuthorMatches, V5, V7, V8, TitleMatches ) %>%

  rename (Millennium_author = V1) %>%
  rename (Millennium_title = V3) %>%
  rename (Millennium_record_number = V4) %>%
  rename (UCSF_NRLF_author = V5) %>%
  rename (UCSF_NRLF_title = V7) %>%
  rename (UCSF_NRLF_record_number = V8)

# Write csv
write.csv(df_edited_records, file = "compare_records_to_review.csv", row.names = FALSE)

