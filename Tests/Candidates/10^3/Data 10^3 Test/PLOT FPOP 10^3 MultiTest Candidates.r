
library(ggplot2)
library(ggpubr)
################################################################################

fname <- "PLOT FPOP 10^3 MultiTest Candidates.png"

f1name <- "PLOT FPOP1 10^3 MultiTest Candidates.png"
f2name <- "PLOT FPOP2 10^3 MultiTest Candidates.png"
f3name <- "PLOT FPOP3 10^3 MultiTest Candidates.png"

################################################################################
dim <- c(2:10)
s = "10^3"
size <-1000
Time <-c(1:size)

dimension <- c("dim 2","dim 3","dim 4","dim 5","dim 6","dim 7","dim 8","dim 9","dim 10")

#################################
#             FPOP1             #
#################################
F1C <- matrix(nrow = size, ncol = length(dim)+1)
F1C[,1] <- Time

for (i in 1:length(dim)){
  ffname = paste("dim",dim[i],"FPOP1",s,"MultiTest Candidates.txt")
  f_data <- readLines(con = ffname, n = -1)
  f_data <- strsplit(f_data,split = ' ')
  f_data <- sapply(f_data, FUN = function(x) {as.double(unlist(x))})
  F1C[, i+1] <-f_data
}
#################################
#             FPOP2             #
#################################
F2C <- matrix(nrow = size, ncol = length(dim)+1)
F2C[,1] <- Time

for (i in 1:length(dim)){
  ffname = paste("dim",dim[i],"FPOP2",s,"MultiTest Candidates.txt")
  f_data <- readLines(con = ffname, n = -1)
  f_data <- strsplit(f_data,split = ' ')
  f_data <- sapply(f_data, FUN = function(x) {as.double(unlist(x))})
  F2C[, i+1] <-f_data
}
#################################
#             FPOP3             #
#################################
F3C <- matrix(nrow = size, ncol = length(dim)+1)
F3C[,1] <- Time

for (i in 1:length(dim)){
  ffname = paste("dim",dim[i],"FPOP3",s,"MultiTest Candidates.txt")
  f_data <- readLines(con = ffname, n = -1)
  f_data <- strsplit(f_data,split = ' ')
  f_data <- sapply(f_data, FUN = function(x) {as.double(unlist(x))})
  F3C[, i+1] <-f_data
}
################################################################################
F1 <- as.data.frame(F1C)
F2 <- as.data.frame(F2C)
F3 <- as.data.frame(F3C)

PLOT_dim = list()
PLOT_dim[[1]] <- ggplot(F1, aes(Time))+geom_line(aes(y = F1C[,10], color = "dim 10"), size = 1)+geom_line(aes(y = F1C[,9], color = "dim 9"), size = 1)+geom_line(aes(y = F1C[,8], color = "dim 8"), size = 1)+geom_line(aes(y = F1C[,7], color = "dim 7"), size = 1)+geom_line(aes(y = F1C[,6], color = "dim 6"), size = 1)+geom_line(aes(y = F1C[,5], color = "dim 5"), size = 1)+geom_line(aes(y = F1C[,4], color = "dim 4"), size = 1)+geom_line(aes(y = F1C[,3], color = "dim 3"), size = 1)+geom_line(aes(y = F1C[,2], color = "dim 2"), size = 2)+labs( x = "Time", y = "Number of candidates being considered", title ="FPOP1:Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_dim[[2]] <- ggplot(F2, aes(Time))+geom_line(aes(y = F2C[,10], color = "dim 10"), size = 1)+geom_line(aes(y = F2C[,9], color = "dim 9"), size = 1)+geom_line(aes(y = F2C[,8], color = "dim 8"), size = 1)+geom_line(aes(y = F2C[,7], color = "dim 7"), size = 1)+geom_line(aes(y = F2C[,6], color = "dim 6"), size = 1)+geom_line(aes(y = F2C[,5], color = "dim 5"), size = 1)+geom_line(aes(y = F2C[,4], color = "dim 4"), size = 1)+geom_line(aes(y = F2C[,3], color = "dim 3"), size = 1)+geom_line(aes(y = F2C[,2], color = "dim 2"), size = 2)+labs( x = "Time", y = "Number of candidates being considered", title ="FPOP2:Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_dim[[3]] <- ggplot(F3, aes(Time))+geom_line(aes(y = F3C[,10], color = "dim 10"), size = 1)+geom_line(aes(y = F3C[,9], color = "dim 9"), size = 1)+geom_line(aes(y = F3C[,8], color = "dim 8"), size = 1)+geom_line(aes(y = F3C[,7], color = "dim 7"), size = 1)+geom_line(aes(y = F3C[,6], color = "dim 6"), size = 1)+geom_line(aes(y = F3C[,5], color = "dim 5"), size = 1)+geom_line(aes(y = F3C[,4], color = "dim 4"), size = 1)+geom_line(aes(y = F3C[,3], color = "dim 3"), size = 1)+geom_line(aes(y = F3C[,2], color = "dim 2"), size = 2)+labs( x = "Time", y = "Number of candidates being considered", title ="FPOP3:Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))

png(filename = fname,  width = 1500, height = 1000)
ggarrange(PLOT_dim[[1]],PLOT_dim[[2]],PLOT_dim[[3]],ncol = 1)
dev.off()

png(filename = f1name,  width = 1500, height = 1000)
ggarrange(PLOT_dim[[1]],ncol = 1)
dev.off()

png(filename = f2name,  width = 1500, height = 1000)
ggarrange(PLOT_dim[[2]],ncol = 1)
dev.off()

png(filename = f3name,  width = 1500, height = 1000)
ggarrange(PLOT_dim[[3]],ncol = 1)
dev.off()

################################################################################
Fdim10 = data.frame(Time,F1C[,10],F2C[,10],F3C[,10])
Fdim9 = data.frame(Time,F1C[,9],F2C[,9],F3C[,9])
Fdim8 = data.frame(Time,F1C[,8],F2C[,8],F3C[,8])
Fdim7 = data.frame(Time,F1C[,7],F2C[,7],F3C[,7])
Fdim6 = data.frame(Time,F1C[,6],F2C[,6],F3C[,6])
Fdim5 = data.frame(Time,F1C[,5],F2C[,5],F3C[,5])
Fdim4 = data.frame(Time,F1C[,4],F2C[,4],F3C[,4])
Fdim3 = data.frame(Time,F1C[,3],F2C[,3],F3C[,3])
Fdim2 = data.frame(Time,F1C[,2],F2C[,2],F3C[,2])

PLOT_FPOP = list()
PLOT_FPOP[[2]] <- ggplot(Fdim2, aes(Time))+geom_line(aes(y = F1C[,2], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,2], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 2: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_FPOP[[3]] <- ggplot(Fdim3, aes(Time))+geom_line(aes(y = F1C[,3], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,3], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 3: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_FPOP[[4]] <- ggplot(Fdim4, aes(Time))+geom_line(aes(y = F1C[,4], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,4], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,4], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 4: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_FPOP[[5]] <- ggplot(Fdim5, aes(Time))+geom_line(aes(y = F1C[,5], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,5], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,5], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 5: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_FPOP[[6]] <- ggplot(Fdim6, aes(Time))+geom_line(aes(y = F1C[,6], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,6], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,6], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 6: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_FPOP[[7]] <- ggplot(Fdim7, aes(Time))+geom_line(aes(y = F1C[,7], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,7], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,7], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 7: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_FPOP[[8]] <- ggplot(Fdim8, aes(Time))+geom_line(aes(y = F1C[,8], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,8], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,8], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 8: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_FPOP[[9]] <- ggplot(Fdim9, aes(Time))+geom_line(aes(y = F1C[,9], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,9], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,9], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 9: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_FPOP[[1]] <- ggplot(Fdim10, aes(Time))+geom_line(aes(y = F1C[,10], color = "FPOP1"), size = 1)+geom_line(aes(y = F2C[,10], color = "FPOP2"), size = 1)+geom_line(aes(y = F3C[,10], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of candidates being considered", title ="Dimension 10: Candidates")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))

png(filename = "dim 2 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[2]],ncol = 1)
dev.off()

png(filename = "dim 3 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[3]],ncol = 1)
dev.off()

png(filename = "dim 4 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[4]],ncol = 1)
dev.off()

png(filename = "dim 5 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[5]],ncol = 1)
dev.off()

png(filename = "dim 6 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[6]],ncol = 1)
dev.off()

png(filename = "dim 7 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[7]],ncol = 1)
dev.off()

png(filename = "dim 8 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[8]],ncol = 1)
dev.off()

png(filename = "dim 9 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[9]],ncol = 1)
dev.off()

png(filename = "dim 10 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[1]],ncol = 1)
dev.off()


png(filename = "dim 2-10 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[2]],PLOT_FPOP[[3]],PLOT_FPOP[[4]],PLOT_FPOP[[5]],PLOT_FPOP[[6]],PLOT_FPOP[[7]],PLOT_FPOP[[8]],PLOT_FPOP[[9]],PLOT_FPOP[[1]],ncol = 1)
dev.off()

png(filename = "dim 2,3,4 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[2]],PLOT_FPOP[[3]],PLOT_FPOP[[4]],ncol = 1)
dev.off()

png(filename = "dim 5,6,7 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[5]],PLOT_FPOP[[6]],PLOT_FPOP[[7]],ncol = 1)
dev.off()

png(filename = "dim 8,9,10 PLOT FPOP 10^3 MultiTest Candidates.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[8]],PLOT_FPOP[[9]],PLOT_FPOP[[1]],ncol = 1)
dev.off()





