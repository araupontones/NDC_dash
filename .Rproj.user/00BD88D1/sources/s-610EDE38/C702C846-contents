#'Create workbook in NDC format
#' @param db tiblle to transform to excel
#' @param  sheetName sheet name of the table
#' @param exfile full path of the exit file




createWB <- function(db,
                     sheetName,
                     exfile,
                     font = "Montserrat"
){
  
  
  headerStyle <- createStyle(
    
    fontName = font,
    fontSize = 9,
    fontColour = "#FFFFFF",
    textDecoration = 'bold',
    border = "TopBottomRight",
    borderColour = "#FFFFFF",
    bgFill = "#152864",
    halign = 'center'
    
  )
  
  bodyStyle<-  createStyle(
    
    fontName = font,
    fontSize = 9,
    fontColour = "black",
    border = "TopBottomRight",
    borderColour = "black",
    halign = "left"
    
  )
  
  
  rowsBody = nrow(db)+1
  colsBody = ncol(db)
  
  wb <- createWorkbook()
  
  addWorksheet(wb, sheetName)
  
  writeData(wb, sheetName, db,startCol = 1)
  
  setColWidths(wb, sheetName, cols = c(1:colsBody), widths = rep(22, colsBody))
  
  addStyle(wb, sheet = sheetName, bodyStyle, rows = 2:rowsBody, cols = 1:colsBody, gridExpand = TRUE)
  
  addStyle(wb, sheet = sheetName, headerStyle, rows = 1, cols = 1:colsBody, gridExpand = F)
  
  conditionalFormatting(wb, sheetName, rows = 1, cols = 1:colsBody, rule = "!=0", style = headerStyle)
  
  
  saveWorkbook(wb, exfile, overwrite = TRUE)
}
