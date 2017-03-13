
library(rvest)
#example: https://www.r-bloggers.com/using-rvest-to-scrape-an-html-table/

#Extract properties price table data from trulia 

# 
# kingsUrl<-read_html("https://www.trulia.com/home_prices/New_York/Kings_County-heat_map/")
# queensUrl<-read_html("https://www.trulia.com/home_prices/New_York/Queens_County-heat_map/")
# nycUrl<-read_html('https://www.trulia.com/home_prices/New_York/New_York_County-heat_map/')
# bronxUrl<-read_html('https://www.trulia.com/home_prices/New_York/Bronx_County-heat_map/')
# statenislandUrl<-read_html('https://www.trulia.com/home_prices/New_York/Richmond_County-heat_map/')


HomePrice<-queensUrl %>% html_nodes(xpath = '//*[@id="heatmap_table"]/table') %>% html_table()

HomePrice<-HomePrice[[1]]
names(HomePrice)<-HomePrice[1,]
HomePrice[-c(1:2),]



HP<-matrix(NA,nrow=1,ncol = 5)#create a empty matrix 
for (i in c('Kings_County','Queens_County','New_York_County','Bronx_County','Richmond_County')){
  
  url<-paste0("https://www.trulia.com/home_prices/New_York/",i,'-heat_map/')
  rhtml<-read_html(url)
  HomePrice<-rhtml%>% html_nodes(xpath = '//*[@id="heatmap_table"]/table') %>% html_table()
  HomePrice<-HomePrice[[1]]
  names(HomePrice)<-HomePrice[1,]
  HomePrice<-HomePrice[-c(1:2),]
  
  HomePrice$County<-i
  HP<-rbind(HP,as.matrix(HomePrice))
  
  print('-------------------------------------Stop Line\n')
  write.csv(HomePrice,file = paste('data/',i,'(',names(HomePrice)[3],').csv'))
}

HP<-as.data.frame(HP)
write.csv(HP,file = paste('data/All',names(HP)[4],'.csv'),row.names = F)



