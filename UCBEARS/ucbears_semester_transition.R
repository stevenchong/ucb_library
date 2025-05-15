library (tidyverse)
library (readxl)

#Change the following line to the current semester. Note that it is case sensitive and should match the sheet names in Peter and Lillian's spreadsheets
current_semester = "Spring 2025"


### Find this semester's items to pull (Lillian's list). Change the sheet name to the current semester
df_this_semester <- read_xlsx("Current UC Bears - (titles from a previous semester that are used again).xlsx" , sheet = "Summer 2025") %>%
  { filter(. , grepl("ucbears", `UCBEARS URL (any term)`)) } %>% # filter rows to only those that have ucbears URLs
  select (3) %>%
  distinct

### Find last semester's items to reshelve (Peter's list). Change the sheet name to last semester
df_last_semester <- read_xlsx("eReserve pull list.xlsx", sheet = current_semester ) %>%
  select ("MMS ID" = 1) %>%
  distinct

df_reshelve <- anti_join(df_last_semester, df_this_semester) %>%
  distinct


### Clean up reshelve list to display only items that were actually pulled. Change the sheet name to last semester

df_pull_list <- read_xlsx("eReserve pull list.xlsx", sheet = current_semester ) %>%
  select ("MMS ID" = 1, 2:13)

df_reshelve_cleaned <- merge(x= df_reshelve, y=df_pull_list, all.x = TRUE)

write.table (df_reshelve_cleaned, file = "last_semester_items_to_reshelve.txt", na = '""', row.names = FALSE)




##################################################
             
### Find this semester's items to pull


write.table (df_this_semester, file = "current_semester_MMS.txt", row.names = FALSE, quote = FALSE, col.names = FALSE )

# Take the take the list of MMS IDs and run it in the UCBEARS analytics report
# Take the output and remove the appropriate items

#############

#Flag last semester's items already on shelf for circ staff
df_last_semester_items <- read_xlsx("UCBEARS.xlsx") #this is the output from the UC BEARS analytics report with the appropriate items removed

df_already_pulled <- df_last_semester 

df_already_pulled$already_pulled <- "yes"

df_this_semester_items_to_pull <- merge(x = df_last_semester_items, y = df_already_pulled, all.x = TRUE, by.x = "MMS Id", by.y = "MMS ID") %>%
  filter(!is.na(Barcode) )



write.table(df_this_semester_items_to_pull, "UC_BEARS_this_semester_items_to_pull.txt", row.names = FALSE, na = '""' )


df_check <- anti_join(df_this_semester_items_to_pull, df_last_semester_items) #The count should be zero if all goes well
