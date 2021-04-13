library(ggplot2)
library(ggpubr)

list_means<- list()
dim <- c(2:10)
s = "10^3"

for (i in 1:length(dim)){
  ffname = paste("dim",dim[i],s,"FPOP3","Mean number of exclusions.txt")
  f_data <- readLines(con = ffname, n = -1)
  f_data <- strsplit(f_data,split = ' ')
  f_data <- sapply(f_data, FUN = function(x) {as.double(unlist(x))})
  list_means[[i]] <-f_data
}

time_max = 0
excl_max = 0

for (i in 1:length(list_means)){
  if (time_max < length(list_means[[i]])) time_max = length(list_means[[i]])
  if (excl_max < max(list_means[[i]])) excl_max = max(list_means[[i]])
}
Time = c(1:time_max)
excl_max
dataexcl = matrix(0, nrow = time_max, ncol = length(list_means)+1)
dataexcl[,1] = Time
for (i in 1:length(list_means)){
  for (j in 1:length(list_means[[i]])) dataexcl[j,i+1] = list_means[[i]][j]
}

frdataexcl = as.data.frame(dataexcl)
Plot1<- ggplot(frdataexcl, aes(Time))+geom_line(aes(y = dataexcl[,2], color = "dim 2"), size = 1)+geom_line(aes(y = dataexcl[,3], color = "dim 3"), size = 1)+geom_line(aes(y = dataexcl[,4], color = "dim 4"), size = 1)+geom_line(aes(y = dataexcl[,5], color = "dim 5"), size = 1)+geom_line(aes(y = dataexcl[,6], color = "dim 6"), size = 1)+geom_line(aes(y = dataexcl[,7], color = "dim 7"), size = 1) +geom_line(aes(y = dataexcl[,8], color = "dim 8"), size = 1)+geom_line(aes(y = dataexcl[,9], color = "dim 9"), size = 1)+geom_line(aes(y = dataexcl[,10], color = "dim 10"), size = 1)+labs( x = "Time", y = "Number of exclusion being considered", title ="FPOP3:Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))

png(filename = "Plot FPOP3 Exclusions data10^3.png",  width = 1500, height = 1000)

ggplot(frdataexcl, aes(Time))+geom_line(aes(y = dataexcl[,2], color = "dim 2"), size = 1)+geom_line(aes(y = dataexcl[,3], color = "dim 3"), size = 1)+geom_line(aes(y = dataexcl[,4], color = "dim 4"), size = 1)+geom_line(aes(y = dataexcl[,5], color = "dim 5"), size = 1)+geom_line(aes(y = dataexcl[,6], color = "dim 6"), size = 1)+geom_line(aes(y = dataexcl[,7], color = "dim 7"), size = 1) +geom_line(aes(y = dataexcl[,8], color = "dim 8"), size = 1)+geom_line(aes(y = dataexcl[,9], color = "dim 9"), size = 1)+geom_line(aes(y = dataexcl[,10], color = "dim 10"), size = 1)+labs( x = "Time", y = "Number of exclusion being considered", title ="FPOP3:Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))

dev.off()

############################################################################
list_means<- list()
dim <- c(2:10)
s = "10^3"

for (i in 1:length(dim)){
  ffname = paste("dim",dim[i],s,"FPOP2","Mean number of exclusions.txt")
  f_data <- readLines(con = ffname, n = -1)
  f_data <- strsplit(f_data,split = ' ')
  f_data <- sapply(f_data, FUN = function(x) {as.double(unlist(x))})
  list_means[[i]] <-f_data
}

time_max = 0
excl_max = 0

for (i in 1:length(list_means)){
  if (time_max < length(list_means[[i]])) time_max = length(list_means[[i]])
  if (excl_max < max(list_means[[i]])) excl_max = max(list_means[[i]])
}
Time2 = c(1:time_max)
excl_max
dataexcl2 = matrix(0, nrow = time_max, ncol = length(list_means)+1)
dataexcl2[,1] = Time2
for (i in 1:length(list_means)){
  for (j in 1:length(list_means[[i]])) dataexcl2[j,i+1] = list_means[[i]][j]
}

frdataexcl2 = as.data.frame(dataexcl2)
Plot2 <-ggplot(frdataexcl2, aes(Time2))+geom_line(aes(y = dataexcl2[,2], color = "dim 2"), size = 1)+geom_line(aes(y = dataexcl2[,3], color = "dim 3"), size = 1)+geom_line(aes(y = dataexcl2[,4], color = "dim 4"), size = 1)+geom_line(aes(y = dataexcl2[,5], color = "dim 5"), size = 1)+geom_line(aes(y = dataexcl2[,6], color = "dim 6"), size = 1)+geom_line(aes(y = dataexcl2[,7], color = "dim 7"), size = 1) +geom_line(aes(y = dataexcl2[,8], color = "dim 8"), size = 1)+geom_line(aes(y = dataexcl2[,9], color = "dim 9"), size = 1)+geom_line(aes(y = dataexcl2[,10], color = "dim 10"), size = 1)+labs( x = "Time", y = "Number of exclusion being considered", title ="FPOP2:Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))


png(filename = "Plot FPOP2 Exclusions data10^3.png",  width = 1500, height = 1000)

ggplot(frdataexcl2, aes(Time))+geom_line(aes(y = dataexcl2[,2], color = "dim 2"), size = 1)+geom_line(aes(y = dataexcl2[,3], color = "dim 3"), size = 1)+geom_line(aes(y = dataexcl2[,4], color = "dim 4"), size = 1)+geom_line(aes(y = dataexcl2[,5], color = "dim 5"), size = 1)+geom_line(aes(y = dataexcl2[,6], color = "dim 6"), size = 1)+geom_line(aes(y = dataexcl2[,7], color = "dim 7"), size = 1) +geom_line(aes(y = dataexcl2[,8], color = "dim 8"), size = 1)+geom_line(aes(y = dataexcl2[,9], color = "dim 9"), size = 1)+geom_line(aes(y = dataexcl2[,10], color = "dim 10"), size = 1)+labs( x = "Time", y = "Number of exclusion being considered", title ="FPOP2:Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))

dev.off()


png(filename = "Plot FPOP Exclusions data10^3.png",  width = 1500, height = (500))
ggarrange(Plot2, Plot1,ncol = 2, nrow=1)
dev.off()
###############################################################################
PLOT_FPOP = list()
tdif = length(dataexcl2[,10]) -length(dataexcl[,10])
Time = Time2
Fdim10 = data.frame(Time,dataexcl2[,10],c(dataexcl[,10], seq(0,0,length.out = tdif)))
Fdim9 = data.frame(Time,dataexcl2[,9],c(dataexcl[,9], seq(0,0,length.out = tdif)))
Fdim8 = data.frame(Time,dataexcl2[,8],c(dataexcl[,8], seq(0,0,length.out = tdif)))
Fdim7 = data.frame(Time,dataexcl2[,7],c(dataexcl[,7], seq(0,0,length.out = tdif)))
Fdim6 = data.frame(Time,dataexcl2[,6],c(dataexcl[,6], seq(0,0,length.out = tdif)))
Fdim5 = data.frame(Time,dataexcl2[,5],c(dataexcl[,5], seq(0,0,length.out = tdif)))
Fdim4 = data.frame(Time,dataexcl2[,4],c(dataexcl[,4], seq(0,0,length.out = tdif)))
Fdim3 = data.frame(Time,dataexcl2[,3],c(dataexcl[,3], seq(0,0,length.out = tdif)))
Fdim2 = data.frame(Time,dataexcl2[,2],c(dataexcl[,2], seq(0,0,length.out = tdif)))

PLOT_FPOP = list()
PLOT_FPOP[[1]] <- ggplot(Fdim10, aes(Time))+geom_line(aes(y = Fdim10[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim10[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 10: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))
PLOT_FPOP[[2]] <- ggplot(Fdim2, aes(Time))+geom_line(aes(y = Fdim2[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim2[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 2: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))
PLOT_FPOP[[3]] <- ggplot(Fdim3, aes(Time))+geom_line(aes(y = Fdim3[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim3[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 3: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))
PLOT_FPOP[[4]] <- ggplot(Fdim4, aes(Time))+geom_line(aes(y = Fdim4[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim4[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 4: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))
PLOT_FPOP[[5]] <- ggplot(Fdim5, aes(Time))+geom_line(aes(y = Fdim5[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim5[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 5: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))
PLOT_FPOP[[6]] <- ggplot(Fdim6, aes(Time))+geom_line(aes(y = Fdim6[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim6[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 6: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))
PLOT_FPOP[[7]] <- ggplot(Fdim7, aes(Time))+geom_line(aes(y = Fdim7[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim7[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 7: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))
PLOT_FPOP[[8]] <- ggplot(Fdim8, aes(Time))+geom_line(aes(y = Fdim8[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim8[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 8: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))
PLOT_FPOP[[9]] <- ggplot(Fdim9, aes(Time))+geom_line(aes(y = Fdim9[,2], color = "FPOP2"), size = 1)+geom_line(aes(y = Fdim9[,3], color = "FPOP3"), size = 1)+labs( x = "Time", y = "Number of exclusions being considered", title ="Dimension 9: Exclusions")+theme(legend.position = c(1, 1),legend.justification = c(1, 1))

png(filename = "dim 2 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[2]],ncol = 1)
dev.off()

png(filename = "dim 3 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[3]],ncol = 1)
dev.off()

png(filename = "dim 4 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[4]],ncol = 1)
dev.off()

png(filename = "dim 5 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[5]],ncol = 1)
dev.off()

png(filename = "dim 6 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[6]],ncol = 1)
dev.off()

png(filename = "dim 7 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[7]],ncol = 1)
dev.off()

png(filename = "dim 8 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[8]],ncol = 1)
dev.off()

png(filename = "dim 9 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[9]],ncol = 1)
dev.off()

png(filename = "dim 10 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[1]],ncol = 1)
dev.off()

png(filename = "dim 2-10 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[2]],PLOT_FPOP[[3]],PLOT_FPOP[[4]],PLOT_FPOP[[5]],PLOT_FPOP[[6]],PLOT_FPOP[[7]],PLOT_FPOP[[8]],PLOT_FPOP[[9]],PLOT_FPOP[[1]],ncol = 3, nrow = 3)
dev.off()

png(filename = "dim 2,3,4 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[2]],PLOT_FPOP[[3]],PLOT_FPOP[[4]],ncol = 1)
dev.off()

png(filename = "dim 5,6,7 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[5]],PLOT_FPOP[[6]],PLOT_FPOP[[7]],ncol = 1)
dev.off()

png(filename = "dim 8,9,10 PLOT FPOP 10^3 MultiTest Exclusions.png",  width = 1500, height = 1000)
ggarrange(PLOT_FPOP[[8]],PLOT_FPOP[[9]],PLOT_FPOP[[1]],ncol = 1)
dev.off()





                        