#############################################################################################
#############################################################################################
##                                         Test                                            ##
##                                  Time complexity FPOP3.                                 ##
##                            The data without changepoints                                ##
##                                      n = 1000:1000000                                   ##
#############################################################################################
#############################################################################################
###############################
#    package installation     #
###############################
devtools::install_github("lpishchagina/FPOPdim2")

library(FPOPdim2)

devtools::install_github("lpishchagina/OptPartitioning2D")

library(OptPartitioning2D)

library(simEd)

library(microbenchmark)

library("ggplot2")

library(foreach)

library(iterators)
library(parallel)
library(base)

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
one.simu.fpop  <- function(data1, data2, penalty, type, func = "FPOP3D")
{
  if (type == 1){t <- system.time(FPOP2D(data1, data2, penalty, type = 1))[[1]]}
  if (type == 2){t <- system.time(FPOP2D(data1, data2, penalty, type = 2))[[1]]}
  if (type == 3){t <- system.time(FPOP2D(data1, data2, penalty, type = 3))[[1]]}
  return(t)
}
######################################################################
#                            data length genetation                  #
#                           The data without changepoints            #
######################################################################
###############################
#         data length         #
###############################
length.simu <-NULL
nb.iter <-4
for (i in 1:nb.iter){length.simu <- c(length.simu, 10^(i+2))}
nb.simu <- 10
#nb.iter<- length(length.simu)
###############################
#            tables           #
###############################
tab.FPOP3 <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.FPOP3) <- c("n", paste0("Rep",1:nb.simu))

###############################
#       tables filling        #
###############################
mu1 <- 0
mu2 <- 0
sigma <- 0.3
###############################
#          Cluster            #
###############################
library(parallel)
cores <- detectCores()
cores <- nb.simu 
###############################
#    tables filling FPOP3     #
###############################
t <- 20
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  beta <- 2 * sigma * log(length.simu[i])
  set.seed(t+i)
  data <- data_gen2D(length.simu[i], chp, mu1, mu2, sigma)
  res.nb.simu <- mclapply(1:nb.simu, FUN = one.simu.fpop, data1 = data[1,], data2 = data[2,], penalty = beta, type = 3, mc.cores = cores)
  tab.FPOP3[i,] <- c(length.simu[i], res.nb.simu) 
}
###############################
#    time complexity FPOP3    #
###############################
mean.FPOP3 <- rowMeans(tab.FPOP3[,-1])
write.table(tab.FPOP3, "Table Time complexity FPOP3 1000-1000000.txt" )
write.table(mean.FPOP3, "Time complexity FPOP3 1000-1000000.txt" )
###############################
#  Plot:time complexity FPOP3 #
###############################
png(filename = "Plot Time complexity FPOP3 1000-1000000.png",  width = 1500, height = 1000)
plot(length.simu, mean.FPOP3, xlab = "Data length", ylab = "Mean time in second",  main = "Time complexity of FPOP3", col = "steelblue")
lines(length.simu, mean.FPOP3, col="steelblue")
dev.off()

#################################
#Plot:log(time complexity FPOP3)#
#################################
png(filename = "Plot Time complexity FPOP3 1000-1000000 log.png",  width = 1500, height = 1000)
plot(log(length.simu), log(mean.FPOP3), xlab = "log(Data length)", ylab = "log(Mean time in second)",  main = "Time complexity of FPOP3", col = "steelblue")
lines(length.simu, mean.FPOP3, col="steelblue")
dev.off()
#################################
#Plot:log(time complexity FPOP3)#
#################################
png(filename = "Plot Time complexity FPOP3 1000-1000000 log2.png",  width = 1500, height = 1000)
plot(log(length.simu), mean.FPOP3, xlab = "log(Data length)", ylab = "Mean time in second",  main = "Time complexity of FPOP3", col = "steelblue")
lines(length.simu, mean.FPOP3, col="steelblue")
dev.off()
