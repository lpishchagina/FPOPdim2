
#############################################################################################
#############################################################################################
##                                         Test                                            ##
##                   Time complexity. One simulation. Microbenchmark                       ##
##                            The data without changepoints                                ##
#############################################################################################
#############################################################################################

###############################
#    package installation     #
###############################
#devtools::install_github("lpishchagina/OptPartitioning2D")
library(OptPartitioning2D)

#devtools::install_github("lpishchagina/FPOPdim2")
library(FPOPdim2)
#library(ggplot2)
#library(ggpubr)
library(base)
library(rstream)
library(simEd)
library(microbenchmark)
library(tidyverse)      # data manipulation and viz
library(ggthemes)       # themes for ggplot2
library(viridis)        # the best color palette
library(rgdal)          # deal with shapefiles
library(microbenchmark) # measure the speed of executing
library(extrafont)      # nice font
library(RColorBrewer)

###############################
#     Function one.simu.op    #
###############################
#The function returns the runtime of the algorithm for one simulation

#type = "null" - Optimal Partitioning
#type = "pruning" - PELT

one.simu.op <- function(n,penalty, type, func = "OptPart2D"){ 
  Data  = data_gen2D(n)
  if(type == "null"){t <- system.time(OptPart2D(Data[1,], Data[2,], penalty, type = "null"))[[1]]}
  if(type == "pruning"){t <- system.time(OptPart2D(Data[1,], Data[2,], penalty, type = "pruning"))[[1]]}
  return(t)
}

###############################
#    Function one.simu.fpop   #
###############################
#The function returns the runtime of the algorithm for one simulation

#type = 1 - FPOP: only intersection, approximation of intersection = rectangle
#type = 2 - FPOP: intersection and exclusion, approximation of intersection and exclusion = rectangle
#type = 3 - FPOP: only exclusion, approximation -  disk
one.simu.fpop  <- function(n, penalty, type, func = "FPOP2D"){
  Data  = data_gen2D(n)
  if (type == 1){t <- system.time(FPOP2D(Data[1,], Data[2,], penalty, type = 1))[[1]]}
  if (type == 2){t <- system.time(FPOP2D(Data[1,], Data[2,], penalty, type = 2))[[1]]}
  if (type == 3){t <- system.time(FPOP2D(Data[1,], Data[2,], penalty, type = 3))[[1]]}
  return(t)
}

######################################################################
#                                data generation                     #
#               The data without changepoints N(c(0,0),1)            #
######################################################################
s = "10^3"
n = NULL
ffname = paste("Microbenchmark",s,"dim2.png")
sigma <- 1
MicrPlot<-list()
res.microbenchmark<-list()
for (i in 3:5) n = c(n, 10^i)
n


##############################
penalty <- 4*sigma*log(n)

set.seed(13)

for (i in 1:length(n)){
  penalty <- 4*sigma*log(n[i])
  res.microbenchmark[[i]] <- microbenchmark("OP" =one.simu.op(n[i], penalty, type = "null", func = "OptPart2D"), "PELT"= one.simu.op(n[i], penalty, type = "pruning", func = "OptPart2D" ), "FPOP1"= one.simu.fpop(n[i], penalty, type = 1, func = "FPOP2D"), "FPOP2" = one.simu.fpop(n[i], penalty, type = 2, func = "FPOP2D"), "FPOP3" = one.simu.fpop(n[i], penalty, type = 3, func = "FPOP2D"), times = 10)
  MicrPlot[[i]] <- autoplot(res.microbenchmark [[i]])+aes(fill = expr)+scale_fill_viridis(discrete = T)+theme(legend.position = "none",axis.text = element_text(size = 15))+labs(title = paste("Length of time series ",n[i]))
}

png(filename = ffname,  width = 1500, height = 500)
ggarrange(MicrPlot[[1]],MicrPlot[[2]],MicrPlot[[3]],ncol = 3, nrow = 1)
dev.off()
#############################################################################################
#############################################################################################
##                                        End Test                                         ##
#############################################################################################
#############################################################################################