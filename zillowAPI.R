library(ZillowR)
library(XML)
temp1<-GetSearchResults(address='120 East 7th Street apt5A',citystatezip = '10009', zws_id ='your id' )

#parse XML to R data frame
results <- xmlToList(temp1$response[["results"]]) #extract the top level nodes, assumpting temp1$response is not NULL

getValRange <- function(x, hilo) {
  ifelse(hilo %in% unlist(dimnames(x)), x["text",hilo][[1]], NA)
}

extractZillowXML<-function(property){
  #function extracts the XML result infomation, and return a R normal list
  zpid <- property$zpid
  links <- unlist(property$links)
  address <- unlist(property$address)
  z <- property$zestimate
  zestdf <- list(
    amount=ifelse("text" %in% names(z$amount), z$amount$text, NA),
    lastupdated=z$"last-updated",
    valueChange=ifelse(length(z$valueChange)==0, NA, z$valueChange),
    valueLow=getValRange(z$valuationRange, "low"),
    valueHigh=getValRange(z$valuationRange, "high"),
    percentile=z$percentile)  
  list(id=zpid, links, address, zestdf)
}

out <- apply(results, MAR=2, extractZillowXML)#apply to the second column

data <- as.data.frame(do.call(rbind, lapply(out, unlist)), 
                      row.names=seq_len(length(out)))


#Pack into function:####
ZestimateCheck<-function(StreetAddress,citystatezip,zws_id){
  library(ZillowR)
  library(XML)
  getValRange <- function(x, hilo) {
    ifelse(hilo %in% unlist(dimnames(x)), x["text",hilo][[1]], NA)
  }
  
  extractZillowXML<-function(property){
    zpid <- property$zpid
    links <- unlist(property$links)
    address <- unlist(property$address)
    z <- property$zestimate
    zestdf <- list(
      amount=ifelse("text" %in% names(z$amount), z$amount$text, NA),
      lastupdated=z$"last-updated",
      valueChange=ifelse(length(z$valueChange)==0, NA, z$valueChange),
      valueLow=getValRange(z$valuationRange, "low"),
      valueHigh=getValRange(z$valuationRange, "high"),
      percentile=z$percentile)  
    list(id=zpid, links, address, zestdf)
  }
  #main:
  results<-GetSearchResults(address =StreetAddress,citystatezip = citystatezip,zws_id = zws_id )
  results2list<-xmlToList(results$response[['results']])
  finalResult <- apply(results2list, MAR=2, extractZillowXML)
  df <- as.data.frame(do.call(rbind, lapply(finalResult, unlist)), 
                        row.names=seq_len(length(finalResult)))
  return(df)
  
}

#testing:
valueZestimateCheck(StreetAddress ='120 East 7th Street apt5A',citystatezip = '10009', zws_id ='your id')






