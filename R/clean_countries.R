infile <- file.path(db_reference, "countries.xlsx")
infile2 <- file.path(db_reference, "countries_status.xlsx")
exfile <- file.path(dashboard, "0.countries.xlsx")
list.files(db_reference)



#read world bank countries
wb_countries <- wb_countries(lang = "en") |>
  #select relevant variables --------------------------------------------------
select(
  iso2 = iso2c,
  iso3 = iso3c, 
  country,capital_city, longitude, latitude, region, income_level) %>%
  #keep only countries (drop regions or aggregates)
  filter(!is.na(capital_city)) |>
  select(-capital_city) |>
  mutate(country = case_when(country == "Cote d'Ivoire" ~ "Côte d'Ivoire",
                             country == "Micronesia, Fed. Sts." ~ "Micronesia",
                             country == "Vietnam" ~ "Viet Nam",
                             country == "Bahamas, The" ~ "Bahamas",
                             country == "Gambia, The" ~ "The Gambia",
                             country == 'Sao Tome and Principe' ~ "Sao Tome e Principe",
                             country == "Venezuela, RB" ~ "Venezuela",
                             country == "Yemen, Rep." ~ "Yemen",
                             country == "Syrian Arab Republic" ~ "Syria",
                             country == "Slovak Republic" ~ "Slovakia",
                             country == "Korea, Dem. People's Rep." ~ "North Korea",
                             country == "Korea, Rep." ~ "South Korea",
                             country == "Russian Federation" ~ "Russia",
                             country == "Iran, Islamic Rep." ~ "Iran",
                             country == "Egypt, Arab Rep." ~ "Egypt",
                             country == "Czech Republic" ~ "Czechia",
                             country == "Brunei Darussalam" ~ "Brunei",
                             #country == "Sao Tome e Principe" ~ "Sao Tome and Principe",
                             country == 'Marshall Islands' ~ "Marshall Islands (RMI)",
                             country == "Guinea" ~ "Guinea (Conakry)",
                             country == "Kyrgyzstan" ~ "Kyrgyz Republic",
                             T ~ country))






#Join with status file ===========================================================
r2 <- import(infile2)
c2 <- r2 |>
  rename(status = Status)|>
  mutate(country = case_when(country == "Kyrgyzstan" ~ "Kyrgyz Republic",
                             country == "Sao Tome and Principe" ~ "Sao Tome e Principe",
                             T ~ country)) |>
  left_join(wb_countries, by = "country")

#join with institutions==========================================================
r <- import(infile)



  c <- r |>
  mutate(stakeholders = str_extract(country, "(?<=\\().*(?=\\))"),
         stakeholders = case_when(stakeholders == "Swaziland" ~ NA_character_,
                                  stakeholders == "CAR" ~ NA_character_, 
                                 T ~ stakeholders),
         country = str_remove_all(country, " \\(.*\\)"),
         country = case_when(country == "United States of America" ~ "United States",
                             country == "Saint Vincent and the Grenadines" ~"St. Vincent and the Grenadines" ,
                             country == "Saint Kitts and Nevis" ~ "St. Kitts and Nevis",  
                             country == "Saint Lucia" ~ "St. Lucia",
                             country == "Democratic Republic of the Congo" ~ "Congo, Dem. Rep.",
                             country == "Republic of the Congo" ~ "Congo, Rep.",
                             country == "State of Palestine" ~ "Palestine",
                             country == "Marshall Islands" ~ "Marshall Islands (RMI)",
                             country == "Guinea" ~ "Guinea (Conakry)",
                             T ~country)
  ) |>
  right_join(c2, by = "country") |>
  relocate(stakeholders, .after = status)



#export ========================================================================
createWB(db = c,
         sheetName = "countries",
         font = "Montserrat",
         exfile = exfile)

