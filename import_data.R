
# Script to scrape data from www.uefa.com/uefaeuro

#library(devtools)
#devtools::install_github("ropensci/RSelenium")
#library(RSelenium)
#library(XML)


#function to change url
url = function(x)
  sprintf('http://www.uefa.com/uefaeuro/season=2016/statistics/round=2000448/players/kind=%s/index.html',x)

RSelenium::startServer()
remDr <- RSelenium::remoteDriver(browserName = "chrome")
remDr$open()

#get goal stats
appURL <- url("goals")
remDr$navigate(appURL)
webElem <- remDr$findElement(using = 'id', value = "dbPlayersStats")
tblSource <- webElem$getPageSource()[[1]]
scorers <- XML::readHTMLTable(tblSource,stringsAsFactors=F,
                              colClasses = c("character",rep("integer",4),rep("character",1)))[[1]]
remDr$navigate(appURL)
webElem <- remDr$findElement(using = 'id', value = "dbPlayersStats")
tblSource <- webElem$getPageSource()[[1]]
scorers <- XML::readHTMLTable(tblSource)[[1]]

#save file
write.csv(scorers,file="data/scorers.csv", row.names = F)
