# Controlling ggplot title text size : theme & label####

#eg. 
?theme
theme(axis.text.x=element_text(face = "bold.italic", colour = 'red',size = 15,
                               angle=75,hjust = 1),
      title=element_text(face = "bold.italic", colour = 'black',size = 18),
      axis.title=element_text(face = "bold.italic", colour = 'black',size = 18))

      #axis.text.x: x axis text properties
      #title: graph title text 
      #axis.title: control x,y axis.title ( for a specific axis.title eg x axis: axis.title.x)

?label
labs(title="xxxx") + labs(x="xxx", y="xxx")
?geom_vline # geom_hline
geom_vline(aes(xintercept=mean(IRA.balance$Age)),color="blue", size=1) #eg adding a vertical line
geom_hline(aes(yintercept=10000),colour='red')
  
  
?ggsave

#graphing examples####
# 1 bar graph with count & % labels####
#Bar graph for factor level data: with count and percentage label
ggplot(data = IRA.balance,aes(x=IRA.balance$BALANCE.INTERVAL))+geom_bar(fill='blue',alpha=0.6)+
  geom_text(stat='count',aes(label=paste(..count..,'Members','(',round((..count..)/sum(..count..)*100,1),'%',')')),vjust=-1,size=5)


# 2 histogram for continues data####
#histogram for continues data
ggplot(data=IRA.balance, aes(IRA.balance$Age)) + 
  geom_histogram(breaks=seq(1, 100, by = 1), # setting histogram interval
                 col="red", 
                 fill="blue", 
                 alpha = .2) + 
  scale_x_continuous(breaks = seq(10,100,10))+
  geom_text(aes(x=mean(IRA.balance$Age), 
                label=paste("Average Age:",round(mean(IRA.balance$Age),0),"--->"), y=220)
            , colour="blue", angle=360, hjust = 1.2,size=5) #adding geom text 


#3 bar graph with stat_summary####
#through breaking down continues variable
library(Hmisc)
IRA.balance$AgeGroup<-cut(IRA.balance$Age,8,dig.lab = 2) #cutting continues variable into equal interval
mean.n <- function(x){ # for labelling purpose
  return(c(y = mean(x)*1.03, label = round(mean(x),0))) 
  # experiment with the multiplier to find the perfect position
}

ggplot(data=IRA.balance, aes(x=IRA.balance$AgeGroup,IRA.balance$balance.100))+
  stat_summary(fun.y = 'mean',geom = 'bar',fill='blue',alpha = .6)+
  stat_summary(fun.data = mean.n, geom = "text", fun.y = mean, colour = "red",size=6)

 
#4.bouns sorting level before plotting####
#eg kinds is a factor in IRA df
IRA <- within(IRA, 
              kinds <- factor(kinds, 
                              levels=names(sort(table(kinds), 
                                                decreasing=TRUE))))







