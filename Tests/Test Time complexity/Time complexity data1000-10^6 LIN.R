#############################################################################################
#############################################################################################
##                                         Test                                            ##
##                                  Time complexity OP.                                    ##
##                            The data without changepoints                                ##
##                                      n = 1000:1000000                                   ##
#############################################################################################
#############################################################################################
###############################
#    package installation     #
###############################
#devtools::install_github("lpishchagina/FPOPdim2")

library(FPOPdim2)

#devtools::install_github("lpishchagina/OptPartitioning2D")

library(OptPartitioning2D)

library(base)
library(rstream)
library(simEd)
library(iterators)
library(stats)
library(parallel)

set.seed(21)
###############################
#          Cluster            #
###############################
nb.simu <-10
cores <- detectCores()
cores <- nb.simu 
###############################
#     Function one.simu.op    #
###############################
#The function returns the runtime of the algorithm for one simulation

#type = "null" - Optimal Partitioning
#type = "pruning" - PELT

one.simu.op <- function(data, penalty, type, func = "OptPart2D")
{
  if(type == "null"){t <- system.time(OptPart2D(data[1,],data[2,], penalty, type = "null"))[[1]]}
  if(type == "pruning"){t <- system.time(OptPart2D(data[1,],data[2,],penalty, type = "pruning"))[[1]]}
  return(t)
}

###############################
#    Function one.simu.fpop   #
###############################
#The function returns the runtime of the algorithm for one simulation
 
#type = 1 - FPOP: only intersection, approximation of intersection = rectangle
#type = 2 - FPOP: intersection and exclusion, approximation of intersection and exclusion = rectangle
#type = 3 - FPOP: only exclusion, approximation -  disk
one.simu.fpop  <- function(data, penalty, type, func = "FPOP2D")
{
  if (type == 1){t <- system.time(FPOP2D(data[1,],data[2,], penalty, type = 1))[[1]]}
  if (type == 2){t <- system.time(FPOP2D(data[1,],data[2,], penalty, type = 2))[[1]]}
  if (type == 3){t <- system.time(FPOP2D(data[1,],data[2,], penalty, type = 3))[[1]]}
  return(t)
}

######################################################################
#                            data length generation                  #
#                           The data without changepoints            #
######################################################################
###############################
#         data length         #
###############################
length.simu <-NULL
nb.iter <- 5
for (i in 1:nb.iter){length.simu <- c(length.simu, 10^(i+1))}
###############################
#            tables           #
###############################
tab.OP <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.OP) <- c("n", paste0("Rep",1:nb.simu))

tab.PELT <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.PELT) <- c("n", paste0("Rep",1:nb.simu))

tab.FPOP1 <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.FPOP1) <- c("n", paste0("Rep",1:nb.simu))

tab.FPOP2 <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.FPOP2) <- c("n", paste0("Rep",1:nb.simu))

tab.FPOP3 <- data.frame(matrix(0, nb.iter, nb.simu + 1))
colnames(tab.FPOP3) <- c("n", paste0("Rep",1:nb.simu))
###############################
#       tables filling        #
###############################
mu1 <- 0
mu2 <- 0
sigma <- 1
res.nb.simu <- NULL
###############################
#    tables filling FPOP2     #
###############################
for(i in 1:length(length.simu)){
  beta <- 2 * sigma * log(length.simu[i])
  res.nb.simu <- mclapply(1:nb.simu, FUN = one.simu.fpop, data1 = data_gen2D(length.simu[i],length.simu[i], mu1, mu2, sigma), penalty = beta, type = 2, mc.cores = cores)
  tab.FPOP2[i,] <- c(length.simu[i], res.nb.simu) 
}
###############################
#    time complexity FPOP2    #
###############################
mean.FPOP2 <- rowMeans(tab.FPOP2[,-1])
write.table(tab.FPOP2, "Table Time complexity FPOP2 par.txt" )
write.table(mean.FPOP2, "Time complexity FPOP2 par.txt", row.names = FALSE,col.names = FALSE  )
###############################
#  Plot:time complexity FPOP2 #
###############################
png(filename = "Plot log10 Time complexity FPOP2 par.png",  width = 1500, height = 1000)
plot(log10(length.simu), mean.FPOP2, xlab = "log10(data length)", ylab = "Mean time in second",  main = "FPOP2:Time complexity", col = "royalblue3")
lines(log10(length.simu), mean.FPOP2, col="royalblue3", lwd = 3)
dev.off()

###############################
#    tables filling OP        #
###############################



for(i in 1:length(length.simu)){
  beta <- 2 * sigma * log(length.simu[i])
  res.nb.simu <- mclapply(1:nb.simu, FUN = one.simu.op, data1 = data_gen2D(length.simu[i],length.simu[i], mu1, mu2, sigma), penalty = beta, type = "null", mc.cores = cores)
  tab.OP[i,] <- c(length.simu[i], res.nb.simu) 
}

###############################
#    time complexity OP       #
###############################
mean.OP <- rowMeans(tab.OP[,-1])
write.table(tab.OP, "Table Time complexity OP par.txt" )
write.table(mean.OP, "Time complexity OP par.txt",  row.names = FALSE,col.names = FALSE)
###############################
#  Plot:time complexity OP    #
###############################
png(filename = "Plot log10 Time complexity OP par.png",  width = 1500, height = 1000)
plot(log10(length.simu), mean.OP, xlab = "log10(data length)", ylab = "Mean time in second",  main = "OP: Time complexity", col = "palevioletred3")
lines(log10(length.simu), mean.OP, col = "palevioletred3",lwd = 3)
dev.off()

###############################
#    tables filling PELT      #
###############################

for(i in 1:length(length.simu)){
  beta <- 2 * sigma * log(length.simu[i])
  res.nb.simu <- mclapply(1:nb.simu, FUN = one.simu.op, data1 = data_gen2D(length.simu[i],length.simu[i], mu1, mu2, sigma), penalty = beta, type = "pruning", mc.cores = cores)
  tab.PELT[i,] <- c(length.simu[i], res.nb.simu) 
}

###############################
#    time complexity PELT     #
###############################
mean.PELT <- rowMeans(tab.PELT[,-1])
write.table(tab.PELT, "Table Time complexity PELT par.txt" )
write.table(mean.PELT, "Time complexity PELT par.txt", row.names = FALSE,col.names = FALSE  )
###############################
#  Plot:time complexity PELT  #
###############################


png(filename = "Plot log10 Time complexity PELT par.png",  width = 1500, height = 1000)
plot(log10(length.simu), mean.PELT, xlab = "log10(data length)", ylab = "Mean time in second",  main = "PELT: Time complexity", col = "orchid3")
lines(log10(length.simu), mean.PELT, col="orchid3", lwd = 3)
dev.off()


###############################
#    tables filling FPOP3     #
###############################
for(i in 1:length(length.simu)){
  beta <- 2 * sigma * log(length.simu[i])
  res.nb.simu <- mclapply(1:nb.simu, FUN = one.simu.fpop, data1 = data_gen2D(length.simu[i],length.simu[i], mu1, mu2, sigma), penalty = beta, type = 3, mc.cores = cores)
  tab.FPOP3[i,] <- c(length.simu[i], res.nb.simu) 
}
###############################
#    time complexity FPOP3    #
###############################
mean.FPOP3 <- rowMeans(tab.FPOP3[,-1])
write.table(tab.FPOP3, "Table Time complexity FPOP3 par.txt" )
write.table(mean.FPOP3, "Time complexity FPOP3 par.txt", row.names = FALSE,col.names = FALSE)
###############################
#  Plot:time complexity FPOP3 #
###############################
png(filename = "Plot log10 Time complexity FPOP3 par.png",  width = 1500, height = 1000)
plot(log10(length.simu), mean.FPOP3, xlab = "log10(data length)", ylab = "Mean time in second",  main = "FPOP3: Time complexity", col = "purple3")
lines(log10(length.simu), mean.FPOP3, col="purple3", lwd = 3)
dev.off()

###############################
#    tables filling FPOP1     #
###############################
for(i in 1:length(length.simu)){
  beta <- 2 * sigma * log10(length.simu[i])
  res.nb.simu <- mclapply(1:nb.simu, FUN = one.simu.fpop, data1 = data_gen2D(length.simu[i],length.simu[i], mu1, mu2, sigma), penalty = beta, type = 1, mc.cores = cores)
  tab.FPOP1[i,] <- c(length.simu[i], res.nb.simu) 
}

###############################
#    time complexity FPOP1    #
###############################
mean.FPOP1 <- rowMeans(tab.FPOP1[,-1])
write.table(tab.FPOP1, "Table Time complexity FPOP1 par.txt" )
write.table(mean.FPOP1, "Time complexity FPOP1 par.txt", row.names = FALSE, col.names = FALSE)
###############################
#  Plot:time complexity FPOP1 #
###############################
png(filename = "Plot log10 Time complexity FPOP1 par.png",  width = 1500, height = 1000)
plot(log10(length.simu), mean.FPOP1, xlab = "log10(data length)", ylab = "Mean time in second",  main = "FPOP1: Time complexity", col = "skyblue3")
lines(log10(length.simu), mean.FPOP1, col="skyblue3", lwd = 3)
dev.off()

###############################
#  Plot:time complexity       #
###############################
png(filename = "Plot log10 Time complexity Comparison par.png",  width = 1500, height = 1000)

plot(log10(length.simu), mean.FPOP1, col = "skyblue3",, xlab = "log10(data length)", ylab = "Mean time in second",  main = "Time complexity")
lines(log10(length.simu), mean.FPOP1, col="skyblue3", lwd = 3)


points(log10(length.simu), mean.FPOP3, col = "purple3" )
lines(log10(length.simu), mean.FPOP3, col="purple3", lwd = 3)

points(log10(length.simu), mean.OP, col = "palevioletred3")
lines(log10(length.simu), mean.OP, col="palevioletred3", lwd = 3)

points(log10(length.simu), mean.PELT,col = "orchid3")
lines(log10(length.simu), mean.PELT, col= "orchid3", lwd = 3)


points(log10(length.simu), mean.FPOP2, col = "royalblue3")
lines(log10(length.simu), mean.FPOP2, col="royalblue3", lwd = 3)


############################### 
#       legend                #
###############################
location = "topleft"
labels = c("OP","PELT", "FPOP1", "FPOP2", "FPOP3")
colors = c("palevioletred3", "orchid3","skyblue3","royalblue3", "purple3")
legend(location, labels, fill = colors)
dev.off()


############################### 
#  stop cluster               #
###############################

#stop cluster
stopCluster(cores)
