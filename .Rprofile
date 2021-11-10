cli::cli_alert("NDC dashboard")



#define paths ==================================================================
dropbox <- "C:/Users/andre/Dropbox/NDC/4. Dashboard"
db_reference <- file.path(dropbox, "reference")


dashboard <- "dashboard"
dash_ref <- file.path(dashboard, "reference")
dash_temp <- file.path(dashboard, "templates")


#define libraries =============================================================
libraries <- c(
  
  "rio", "dplyr", "tidyr",
  "stringr", 
  "openxlsx", "wbstats", "janitor"
  
)


options(defaultPackages = c(getOption("defaultPackages"),
                            
                            libraries                        
                            
))


gmdacr::load_functions("functions")


