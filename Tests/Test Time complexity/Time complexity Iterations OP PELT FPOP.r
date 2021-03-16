#############################################################################################
#############################################################################################
##                                         Test                                            ##
##                                  Time complexity.                                       ##
##                            The data without changepoints                                ##
##                                      n = 1:50000                                        ##
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

library(doParallel)

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

###############################
#          Cluster            #
###############################
#cl <- makeCluster(4)
#registerDoParallel(cl)

######################################################################
#                            data length genetation                  #
#                           The data without changepoints            #
######################################################################
###############################
#         data length         #
###############################
   
length.simu <- c(1000, 2000, 3000, 5000, 8000, 10000, 12000, 15000, 18000, 20000)
nb.simu <- 10
nb.iter <- length(length.simu)
###############################
#            tables           #
###############################
tab.OP <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.OP ) <- c("n", paste0("Rep",1:nb.simu))

tab.PELT <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.PELT ) <- c("n", paste0("Rep",1:nb.simu))

tab.FPOP1 <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.FPOP1 ) <- c("n", paste0("Rep",1:nb.simu))

tab.FPOP2 <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.FPOP2 ) <- c("n", paste0("Rep",1:nb.simu))

tab.FPOP3 <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.FPOP3 ) <- c("n", paste0("Rep",1:nb.simu))
###############################
#       tables filling        #
###############################
mu1 <- 0
mu2 <- 0
sigma <- 0.3

###############################
#    tables filling OP        #
###############################
t <- 20
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  set.seed(t+i)
  data <- data_gen2D(length.simu[i], chp, mu1, mu2, sigma)
  tab.OP[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.op(data[1,], data[2,], penalty, type = "null", func = "OptPart2D"))) 
}
###############################
#    time complexity OP       #
###############################
mean.OP <- rowMeans(tab.OP[,-1])
write.table(tab.OP, "Table Time complexity OP.txt" )
write.table(mean.OP, "Time complexity OP.txt" )
###############################
#  Plot:time complexity OP    #
###############################
png(filename = "Plot Time complexity OP.png",  width = 1500, height = 1000)
plot(length.simu, mean.OP, xlab = "Data length", ylab = "Mean time in second",  main = "Time complexity of OP", col = "steelblue")
lines(length.simu, mean.OP, col="steelblue")
dev.off()

###############################
#    tables filling PELT      #
###############################
t <- 20
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  set.seed(t+i)
  data <- data_gen2D(length.simu[i], chp, mu1, mu2, sigma)
  tab.PELT[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.op(data[1,], data[2,], penalty, type = "pruning", func = "OptPart2D"))) 
}
###############################
#    time complexity PELT     #
###############################
mean.PELT <- rowMeans(tab.PELT[,-1])
write.table(tab.PELT, "Table Time complexity PELT.txt" )
write.table(mean.PELT, "Time complexity PELT.txt" )
###############################
#  Plot:time complexity PELT  #
###############################
png(filename = "Plot Time complexity PELT.png",  width = 1500, height = 1000)
plot(length.simu, mean.PELT, xlab = "Data length", ylab = "Mean time in second",  main = "Time complexity of PELT", col = "steelblue")
lines(length.simu, mean.PELT, col="steelblue")
dev.off()


###############################
#    tables filling FPOP1     #
###############################
t <- 20
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  set.seed(t+i)
  data <- data_gen2D(length.simu[i], chp, mu1, mu2, sigma)
  tab.FPOP1[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.fpop(data[1,], data[2,], penalty, type = 1, func = "FPOP2D"))) 
}
###############################
#    time complexity FPOP1    #
###############################
mean.FPOP1 <- rowMeans(tab.FPOP1[,-1])
write.table(tab.FPOP1, "Table Time complexity FPOP1.txt" )
write.table(mean.FPOP1, "Time complexity FPOP1.txt" )
###############################
#  Plot:time complexity FPOP1 #
###############################
png(filename = "Plot Time complexity FPOP1.png",  width = 1500, height = 1000)
plot(length.simu, mean.FPOP1, xlab = "Data length", ylab = "Mean time in second",  main = "Time complexity of FPOP1", col = "steelblue")
lines(length.simu, mean.FPOP1, col="steelblue")
dev.off()

###############################
#    tables filling FPOP2     #
###############################
t <- 20
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  set.seed(t+i)
  data <- data_gen2D(length.simu[i], chp, mu1, mu2, sigma)
  tab.FPOP2[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.fpop(data[1,], data[2,], penalty, type = 2, func = "FPOP2D"))) 
}
###############################
#    time complexity FPOP2    #
###############################
mean.FPOP2 <- rowMeans(tab.FPOP2[,-1])
write.table(tab.FPOP2, "Table Time complexity FPOP2.txt" )
write.table(mean.FPOP2, "Time complexity FPOP2.txt" )
###############################
#  Plot:time complexity FPOP2 #
###############################
png(filename = "Plot Time complexity FPOP2.png",  width = 1500, height = 1000)
plot(length.simu, mean.FPOP2, xlab = "Data length", ylab = "Mean time in second",  main = "Time complexity of FPOP2", col = "steelblue")
lines(length.simu, mean.FPOP2, col="steelblue")
dev.off()

###############################
#    tables filling FPOP3     #
###############################
t <- 20
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  set.seed(t+i)
  data <- data_gen2D(length.simu[i], chp, mu1, mu2, sigma)
  tab.FPOP2[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.fpop(data[1,], data[2,], penalty, type = 3, func = "FPOP2D"))) 
}
###############################
#    time complexity FPOP3    #
###############################
mean.FPOP3 <- rowMeans(tab.FPOP3[,-1])
write.table(tab.FPOP3, "Table Time complexity FPOP3.txt" )
write.table(mean.FPOP3, "Time complexity FPOP3.txt" )
###############################
#  Plot:time complexity FPOP2 #
###############################
png(filename = "Plot Time complexity FPOP3.png",  width = 1500, height = 1000)
plot(length.simu, mean.FPOP3, xlab = "Data length", ylab = "Mean time in second",  main = "Time complexity of FPOP3", col = "steelblue")
lines(length.simu, mean.FPOP3, col="steelblue")
dev.off()



###############################
#  Plot:time complexity       #
###############################
png(filename = "Plot Time complexity FPOP3.png",  width = 1500, height = 1000)
plot(length.simu, mean.OP, xlab = "Data length", ylab = "Mean time in second",  main = "Time complexity", col = "steelblue")
lines(length.simu, mean.OP, col="steelblue")

points(length.simu, mean.PELT,col = "purple4")
lines(length.simu, mean.PELT, col= "purple4")

points(length.simu, mean.FPOP1, xlab = "Data length", col = "red3")
lines(length.simu, mean.FPOP3, col="red3")

points(length.simu, mean.FPOP2, xlab = "Data length", col = "grey")
lines(length.simu, mean.FPOP2, col="grey")

points(length.simu, mean.FPOP3, xlab = "Data length", col = "blue")
lines(length.simu, mean.FPOP3, col="blue")
############################### 
#       legend                #
###############################
location = "topleft"
labels = c("OP","PELT", "FPOP(type = 1)", , "FPOP(type = 2)", "FPOP(type = 3)")
colors = c("steelblue", "purple4","red3","grey", "blue")
legend(location, labels, fill = colors)
dev.off()
