library(ZillowR)
library(XML)
temp1<-GetSearchResults(address='984 KINGS PARKWAY',citystatezip = 'BALDWIN, NY 11510', zws_id ='X1-ZWz1fdr7ftjn63_6jziz' )

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

out <- apply(results, MAR=2, extractZillowXML())#apply to the second column

data <- as.data.frame(do.call(rbind, lapply(out, unlist)), 
                      row.names=seq_len(length(out)))



