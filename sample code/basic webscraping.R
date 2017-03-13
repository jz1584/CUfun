
library(rvest)
#example: https://www.r-bloggers.com/using-rvest-to-scrape-an-html-table/

#Extract properties price table data from trulia 


url<-read_html("https://www.trulia.com/home_prices/New_York/Kings_County-heat_map/")

HomePrice<-url %>% html_nodes(xpath = '//*[@id="heatmap_table"]/table')%>%
  html_table()

HomePrice<-HomePrice[[1]]
names(HomePrice)<-HomePrice[1,]
HomePrice[-c(1:2),]


