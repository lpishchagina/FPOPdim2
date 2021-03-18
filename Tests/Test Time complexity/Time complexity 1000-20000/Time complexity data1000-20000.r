#############################################################################################
#############################################################################################
##                                         Test                                            ##
##                                  Time complexity.                                       ##
##                            The data without changepoints                                ##
##                                      n = 1000:20000                                     ##
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
set.seed(21)

###############################
#     Function one.simu.op    #
###############################
#The function returns the runtime of the algorithm for one simulation

#type = "null" - Optimal Partitioning
#type = "pruning" - PELT

one.simu.op <- function(data, penalty, type, func = "OptPart2D")
{
  if(type == "null"){t <- system.time(OptPart2D(data[1,], data[2,], penalty, type = "null"))[[1]]}
  if(type == "pruning"){t <- system.time(OptPart2D(data[1,], data[2,], penalty, type = "pruning"))[[1]]}
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
  if (type == 1){t <- system.time(FPOP2D(data[1,], data[2,],  penalty, type = 1))[[1]]}
  if (type == 2){t <- system.time(FPOP2D(data[1,], data[2,], penalty, type = 2))[[1]]}
  if (type == 3){t <- system.time(FPOP2D(data[1,], data[2,],penalty, type = 3))[[1]]}
  return(t)
}

######################################################################
#                            data length generation                  #
#                           The data without changepoints            #
######################################################################
###############################
#         data length         #
###############################
   
length.simu <- seq(from = 1000, to = 20000, by = 1000)
nb.simu <- 10
nb.iter <- length(length.simu)
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

###############################
#    tables filling OP        #
###############################
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  tab.OP[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.op(data = data_gen2D(length.simu[i], chp, mu1, mu2, sigma), penalty, type = "null", func = "OptPart2D"))) 
}
###############################
#    time complexity OP       #
###############################
mean.OP <- rowMeans(tab.OP[,-1])
write.table(tab.OP, "Table Time complexity OP.txt" )
write.table(mean.OP, "Time complexity OP.txt",  row.names = FALSE,col.names = FALSE)
###############################
#  Plot:time complexity OP    #
###############################
png(filename = "Plot Time complexity OP.png",  width = 1500, height = 1000)
plot(length.simu, mean.OP, xlab = "Data length", ylab = "Mean time in second",  main = "OP: Time complexity", col = "palevioletred3")
lines(length.simu, mean.OP, col = "palevioletred3", lwd = 3)
dev.off()

png(filename = "Plot log Time complexity OP.png",  width = 1500, height = 1000)
plot(log(length.simu), mean.OP, xlab = "log(data length)", ylab = "Mean time in second",  main = "OP: Time complexity", col = "palevioletred3")
lines(log(length.simu), mean.OP, col = "palevioletred3",lwd = 3)
dev.off()

###############################
#    tables filling PELT      #
###############################
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  tab.PELT[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.op(data = data_gen2D(length.simu[i], chp, mu1, mu2, sigma), penalty, type = "pruning", func = "OptPart2D"))) 
}
###############################
#    time complexity PELT     #
###############################
mean.PELT <- rowMeans(tab.PELT[,-1])
write.table(tab.PELT, "Table Time complexity PELT.txt" )
write.table(mean.PELT, "Time complexity PELT.txt", row.names = FALSE,col.names = FALSE  )
###############################
#  Plot:time complexity PELT  #
###############################
png(filename = "Plot Time complexity PELT.png",  width = 1500, height = 1000)
plot(length.simu, mean.PELT, xlab = "Data length", ylab = "Mean time in second",  main = "PELT: Time complexity", col = "orchid3")
lines(length.simu, mean.PELT, col="orchid3", lwd = 3)
dev.off()

png(filename = "Plot log Time complexity PELT.png",  width = 1500, height = 1000)
plot(log(length.simu), mean.PELT, xlab = "log(data length)", ylab = "Mean time in second",  main = "PELT: Time complexity", col = "orchid3")
lines(log(length.simu), mean.PELT, col="orchid3", lwd = 3)
dev.off()


###############################
#    tables filling FPOP1     #
###############################

for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  tab.FPOP1[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.fpop(data = data_gen2D(length.simu[i], chp, mu1, mu2, sigma), penalty, type = 1, func = "FPOP2D"))) 
}
###############################
#    time complexity FPOP1    #
###############################
mean.FPOP1 <- rowMeans(tab.FPOP1[,-1])
write.table(tab.FPOP1, "Table Time complexity FPOP1.txt" )
write.table(mean.FPOP1, "Time complexity FPOP1.txt", row.names = FALSE, col.names = FALSE)
###############################
#  Plot:time complexity FPOP1 #
###############################
png(filename = "Plot Time complexity FPOP1.png",  width = 1500, height = 1000)
plot(length.simu, mean.FPOP1, xlab = "Data length", ylab = "Mean time in second",  main = "FPOP1: Time complexity", col = "skyblue3")
lines(length.simu, mean.FPOP1, col="skyblue3", lwd = 3)
dev.off()

png(filename = "Plot log Time complexity FPOP1.png",  width = 1500, height = 1000)
plot(log(length.simu), mean.FPOP1, xlab = "log(data length)", ylab = "Mean time in second",  main = "FPOP1: Time complexity", col = "skyblue3")
lines(log(length.simu), mean.FPOP1, col="skyblue3", lwd = 3)
dev.off()

###############################
#    tables filling FPOP2     #
###############################
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  tab.FPOP2[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.fpop(data= data_gen2D(length.simu[i], chp, mu1, mu2, sigma), penalty, type = 2, func = "FPOP2D"))) 
}
###############################
#    time complexity FPOP2    #
###############################
mean.FPOP2 <- rowMeans(tab.FPOP2[,-1])
write.table(tab.FPOP2, "Table Time complexity FPOP2.txt" )
write.table(mean.FPOP2, "Time complexity FPOP2.txt", row.names = FALSE,col.names = FALSE  )
###############################
#  Plot:time complexity FPOP2 #
###############################
png(filename = "Plot Time complexity FPOP2.png",  width = 1500, height = 1000)
plot(length.simu, mean.FPOP2, xlab = "Data length", ylab = "Mean time in second",  main = "FPOP2: Time complexity", col = "royalblue3")
lines(length.simu, mean.FPOP2, col="royalblue3", lwd = 3)
dev.off()

png(filename = "Plot log Time complexity FPOP2.png",  width = 1500, height = 1000)
plot(log(length.simu), mean.FPOP2, xlab = "log(data length)", ylab = "Mean time in second",  main = "FPOP2:Time complexity", col = "royalblue3")
lines(log(length.simu), mean.FPOP2, col="royalblue3", lwd = 3)
dev.off()

###############################
#    tables filling FPOP3     #
###############################
for(i in 1:length(length.simu)){
  chp <- c(length.simu[i])
  penalty <- 2 * sigma * log(length.simu[i])
  tab.FPOP3[i,] <- c(length.simu[i], replicate(nb.simu, one.simu.fpop(data = data_gen2D(length.simu[i], chp, mu1, mu2, sigma), penalty, type = 3, func = "FPOP2D"))) 
}
###############################
#    time complexity FPOP3    #
###############################
mean.FPOP3 <- rowMeans(tab.FPOP3[,-1])
write.table(tab.FPOP3, "Table Time complexity FPOP3.txt" )
write.table(mean.FPOP3, "Time complexity FPOP3.txt", row.names = FALSE,col.names = FALSE)
###############################
#  Plot:time complexity FPOP3 #
###############################
png(filename = "Plot Time complexity FPOP3.png",  width = 1500, height = 1000)
plot(length.simu, mean.FPOP3, xlab = "Data length", ylab = "Mean time in second",  main = "FPOP3: Time complexity", col = "purple3")
lines(length.simu, mean.FPOP3, col="purple3", lwd = 3)
dev.off()

png(filename = "Plot log Time complexity FPOP3.png",  width = 1500, height = 1000)
plot(log(length.simu), mean.FPOP3, xlab = "log(data length)", ylab = "Mean time in second",  main = "FPOP3: Time complexity", col = "purple3")
lines(log(length.simu), mean.FPOP3, col="purple3", lwd = 3)
dev.off()

###############################
#  Plot:time complexity       #
###############################
png(filename = "Plot Time complexity Comparison.png",  width = 1500, height = 1000)

plot(length.simu, mean.FPOP3, col = "purple3", xlab = "Data length", ylab = "Mean time in second",  main = "Time complexity")
lines(length.simu, mean.FPOP3, col="purple3", lwd = 3)

lines(length.simu, mean.OP, col = "palevioletred3")
lines(length.simu, mean.OP, col="palevioletred3", lwd = 3)

points(length.simu, mean.PELT,col = "orchid3")
lines(length.simu, mean.PELT, col= "orchid3", lwd = 3)

points(length.simu, mean.FPOP1, col = "skyblue3")
lines(length.simu, mean.FPOP1, col="skyblue3", lwd = 3)

points(length.simu, mean.FPOP2, col = "royalblue3")
lines(length.simu, mean.FPOP2, col="royalblue3", lwd = 3)


############################### 
#       legend                #
###############################
location = "topleft"
labels = c("OP","PELT", "FPOP1", "FPOP2", "FPOP3")
colors = c("palevioletred3", "orchid3","skyblue3","royalblue3", "purple3")
legend(location, labels, fill = colors)
dev.off()


png(filename = "Plot log Time complexity Comparison.png",  width = 1500, height = 1000)

plot(log(length.simu), mean.FPOP3, col = "purple3", xlab = "log(data length)", ylab = "Mean time in second",  main = "Time complexity" )
lines(log(length.simu), mean.FPOP3, col="purple3", lwd = 3)

points(log(length.simu), mean.OP, col = "palevioletred3")
lines(log(length.simu), mean.OP, col="palevioletred3", lwd = 3)

points(log(length.simu), mean.PELT,col = "orchid3")
lines(log(length.simu), mean.PELT, col= "orchid3", lwd = 3)

points(log(length.simu), mean.FPOP1, col = "skyblue3")
lines(log(length.simu), mean.FPOP1, col="skyblue3", lwd = 3)

points(log(length.simu), mean.FPOP2, col = "royalblue3")
lines(log(length.simu), mean.FPOP2, col="royalblue3", lwd = 3)


############################### 
#       legend                #
###############################
location = "topleft"
labels = c("OP","PELT", "FPOP1", "FPOP2", "FPOP3")
colors = c("palevioletred3", "orchid3","skyblue3","royalblue3", "purple3")
legend(location, labels, fill = colors)
dev.off()
