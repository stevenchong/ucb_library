### Extract OCLC numbers from UCSC 035s $z 

library(tidyverse)

ucsc_oclcs <- read.csv(file = "UCSC_records_with_035_z.txt", header = FALSE, stringsAsFactors = FALSE)

oclc_string <- as.list(str_split(ucsc_oclcs, "=002") )

df_oclc_string <- as.data.frame(str_split(oclc_string, "OCoLC") )

df_oclc_string <- select (df_oclc_string, oclc = c..c...c.....ï................558852824....tJump.to.Record....1...................... )


df_clean_oclc <- data.frame(lapply(df_oclc_string, function(x) {
  gsub("\\\\.*", "", x)} ))


df_clean_oclc <- data.frame(lapply(df_clean_oclc, function(x) {
  gsub("[)(]", "", x)} )) %>%
  filter(oclc != 'c"c') %>%
  distinct()

write.csv(df_clean_oclc, file = "035_z_clean_oclcs.csv", row.names = FALSE)