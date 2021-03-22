#############################################################################################
#############################################################################################
##                                         Test                                            ##
##                   Time complexity. One simulation. Microbenchmark                       ##
##                            The data without changepoints                                ##
##                                      n = 10000                                           ##
#############################################################################################
#############################################################################################

###############################
#    package installation     #
###############################
#devtools::install_github("lpishchagina/FPOPdim2")
library(FPOPdim2)

devtools::install_github("lpishchagina/OptPartitioning2D")
library(OptPartitioning2D)

library(simEd)
library(microbenchmark)

library("ggplot2")

###############################
#     Function one.simu.op    #
###############################
#The function returns the runtime of the algorithm for one simulation

#type = "null" - Optimal Partitioning
#type = "pruning" - PELT

one.simu.op <- function(data1, data2, penalty, type, func = "OptPart2D")
{
  if(type == "null"){t <- system.time(OptPart2D(data1, data2, penalty, type = "null"))[[1]]}
  if(type == "pruning"){t <- system.time(OptPart2D(data1, data2, penalty, type = "pruning"))[[1]]}
  return(t)
}

###############################
#    Function one.simu.fpop   #
###############################
#The function returns the runtime of the algorithm for one simulation
 
#type = 1 - FPOP: only intersection, approximation of intersection = rectangle
#type = 2 - FPOP: intersection and exclusion, approximation of intersection and exclusion = rectangle
#type = 3 - FPOP: only exclusion, approximation -  disk
one.simu.fpop  <- function(data1, data2, penalty, type, func = "FPOP2D")
{
  if (type == 1){t <- system.time(FPOP2D(data1, data2, penalty, type = 1))[[1]]}
  if (type == 2){t <- system.time(FPOP2D(data1, data2, penalty, type = 2))[[1]]}
  if (type == 3){t <- system.time(FPOP2D(data1, data2, penalty, type = 3))[[1]]}
  return(t)
}

######################################################################
#                                data generation                     #
#                           The data without changepoints            #
######################################################################

##############################
#parameters mu1, mu2, sigma  #
#       (by default)         #
##############################
mu1 <- 0
mu2 <- 0
sigma <- 1
##############################
n <- 100000
##############################
chp <- n
penalty <- 2*log(n)

set.seed(21)
data <- data_gen2D(n, chp, mu1, mu2, sigma)
write.table(data, paste("data", n,".txt"),sep = " ", eol = "\n", na = "NA", dec = ".", row.names = FALSE, col.names = FALSE)
#data[,1] [1] 0.7930132 0.6785635

###############################
#           Algorithm         #
###############################

#resOP <- OptPart2D(data[1,], data[2,], penalty, type = "null")
#resPELT <- OptPart2D(data[1,], data[2,], penalty, type = "pruning")
#resFPOP1 <- FPOP2D(data[1,], data[2,], penalty, type = 1)
#resFPOP2 <- FPOP2D(data[1,], data[2,], penalty, type = 2)
#resFPOP3 <- FPOP2D(data[1,], data[2,], penalty, type = 3)


###############################
#The data without changepoints#
#The runtime One simulation   #
###############################

#one.runtimeOP <- one.simu.op(data[1,], data[2,], penalty, type = "null", func = "OptPart2D")
#one.runtimePELT <- one.simu.op(data[1,], data[2,], penalty, type = "pruning", func = "OptPart2D")
#one.runtimeFPOP1 <- one.simu.fpop(data[1,], data[2,], penalty, type = 1, func = "FPOP2D")
#one.runtimeFPOP2 <- one.simu.fpop(data[1,], data[2,], penalty, type = 2, func = "FPOP2D")
#one.runtimeFPOP3 <- one.simu.fpop(data[1,], data[2,], penalty, type = 3, func = "FPOP2D")
#one.runtimeOP		one.runtimePELT		one.runtimeFPOP1		one.runtimeFPOP2		one.runtimeFPOP3


###############################
#       microbenchmark        #
###############################
res.microbenchmark <- microbenchmark("OP" =one.simu.op(data[1,], data[2,], penalty, type = "null", func = "OptPart2D"), "PELT"= one.simu.op(data[1,], data[2,], penalty, type = "pruning", func = "OptPart2D" ), "FPOP1"= one.simu.fpop(data[1,], data[2,], penalty, type = 1, func = "FPOP2D"), "FPOP2" = one.simu.fpop(data[1,], data[2,], penalty, type = 2, func = "FPOP2D"), "FPOP3" = one.simu.fpop(data[1,], data[2,], penalty, type = 3, func = "FPOP2D"), times = 10)
png(filename = "microbenchmark data10^5.png",  width = 1500, height = 1000)
autoplot(res.microbenchmark)
dev.off()

#############################################################################################
#############################################################################################
##                                        End Test                                         ##
#############################################################################################
#############################################################################################