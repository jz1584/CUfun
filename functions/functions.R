make_circles <- function(centers, radius, nPoints = 100){
  # centers: the data frame of centers with ID
  # radius: radius measured in kilometer
  #
  meanLat <- mean(centers$latT)
  # length per longitude changes with lattitude, so need correction
  radiusLon <- radius /111 / cos(meanLat/57.3) 
  radiusLat <- radius / 111
  circleDF <- data.frame(ID = rep(centers$ID, each = nPoints))
  angle <- seq(0,2*pi,length.out = nPoints)
  
  circleDF$lon <- unlist(lapply(centers$lonT, function(x) x + radiusLon * cos(angle)))
  circleDF$lat <- unlist(lapply(centers$latT, function(x) x + radiusLat * sin(angle)))
  return(circleDF)
}


Address2LonLat<-function(location){
  for (i in 1:dim(location)[1]){
    lonlat<-geocode(location$address[i],source = 'google')
    cat("\nchecking:",i)
    location$lon[i]<-lonlat$lon
    location$lat[i]<-lonlat$lat }
  return(location)
}


