
# Script to scrape data from www.uefa.com/uefaeuro

#library(devtools)
#devtools::install_github("ropensci/RSelenium")
#library(RSelenium)
#library(XML)

#Scrape scorers

url = 'http://www.uefa.com/uefaeuro/season=2016/statistics/round=2000448/players/kind=goals/index.html'

appURL <- url
RSelenium::startServer()
remDr <- RSelenium::remoteDriver(browserName = "chrome")
remDr$open()
remDr$navigate(appURL)
webElem <- remDr$findElement(using = 'id', value = "dbPlayersStats")
tblSource <- webElem$getPageSource()[[1]]
scorers <- XML::readHTMLTable(tblSource)[[1]]

#save file
write.csv(scorers,file="data/scorers.csv", row.names = F)
