list.files(dashboard)
list.files(db_reference)
infile <- file.path(dashboard, "1.1.1_chg.xlsx")
in_ref <- file.path(db_reference, "KPI 1.1.1. Jan 2021 Baseline.xlsx")
#this is because I am filling the report
exfile <- infile
exfile

db_reference
t <- import(infile)
r <- import(in_ref)



#clean reference

r_c <- r |>
  rename(country = "Member Countries") |>
  select(country, starts_with("G")) |>
  rename_at(vars(contains("GHG ")),function(x)str_remove(x," Emissions ")) |>
  mutate(country = case_when(country == "Democratic Republic of the Congo" ~ "Congo, Dem. Rep.",
                             country == "Eswatini (Swaziland)" ~ "Eswatini",  
                             country == "Gambia" ~ "The Gambia",
                             country == "United States of America" ~ "United States",
                             country == "Guinea" ~ "Guinea (Conakry)",
                             country == "Marshall Islands" ~"Marshall Islands (RMI)",
                             country == "Republic of the Congo" ~ "Congo, Rep.",
                             country == "Saint Kitts and Nevis" ~ "St. Kitts and Nevis",
                             country ==  "Saint Lucia" ~  "St. Lucia",
                             T ~ country))



setdiff(r_c$country,t$country)

View(t)


t_f<- t |>
  left_join(r_c, by="country") |>
  mutate(`2017` = GHG2017,
         `2018` = GHG2018) |>
  select(-contains('GHG'))
exfile


createWB(db = t_f,
         sheetName = "1.1.1_chg",
         exfile = file.path(dashboard, "1.1.1_chg.xlsx"))
