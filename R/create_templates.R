list.files(db_reference)
infile <- file.path(db_reference, "1.CODEBOOK.xlsx")
infile_countries <- file.path(dashboard, "0.countries.xlsx")

templatesReady <- c("climate_financing", "ghg") 


#import data -------------------------------------------------------------------
cb <- import(infile)
countries <- import(infile_countries) |>
  filter(status %in% c("Engaged", "Member"))



#create excel files for each indicator
for(i in 1 :nrow(cb)){
  id = cb$ID[i]
  indicator = cb$name[i]
  exfile = file.path(dashboard,cb$excel[i])
  period = cb$period[i]
  
  
  if(!indicator %in% templatesReady){
    
    message(indicator)
    #init data
    dat <- tibble(
      country = countries$country

    )

    if(period == "quarterly"){

      dat2 <- dat |>
        create_quarters(indicator = indicator)

    } else if(period == "yearly"){
      dat2 <- dat |>
        create_years(indicator = indicator)

    }

    createWB(db = dat2,
             sheetName = indicator,
             font = "Montserrat",
             exfile = exfile)
    
  }
}






names(test)
