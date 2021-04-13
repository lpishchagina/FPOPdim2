
library(ggplot2)
library(ggpubr)
################################################################################

dim <-NULL
nb.iter <- 4
for (i in 1:nb.iter) dim <- c(dim, 10^(i+2))
Time <- dim

#################################
#             FPOP              #
#################################
TIME_FPOP <- matrix(nrow = length(dim), ncol = 6)
TIME_FPOP[,1] <- Time
for (i in 1:3){
  ffname = paste("Time complexity FPOP",i,"10^3-6 iter7.txt")
  f_data <- readLines(con = ffname, n = -1)
  f_data <- strsplit(f_data,split = ' ')
  f_data <- sapply(f_data, FUN = function(x) {as.double(unlist(x))})
  TIME_FPOP[, i+1] <-f_data
}
#################################
#            PELT               #
#################################

ffname = paste("Time complexity PELT 10^3-6 iter7.txt")
f_data <- readLines(con = ffname, n = -1)
f_data <- strsplit(f_data,split = ' ')
f_data <- sapply(f_data, FUN = function(x) {as.double(unlist(x))})
TIME_FPOP[, 5] <-f_data

#################################
#             OP                #
#################################

ffname = paste("Time complexity OP 10^3-6 iter7.txt")
f_data <- readLines(con = ffname, n = -1)
f_data <- strsplit(f_data,split = ' ')
f_data <- sapply(f_data, FUN = function(x) {as.double(unlist(x))})
TIME_FPOP[, 6] <-f_data


################################################################################
TIME_F <- as.data.frame(TIME_FPOP)
PLOT_TIME_F = list()
PLOT_TIME_F[[1]] <- ggplot(TIME_F, aes(Time))+geom_line(aes(y = TIME_F[,2], color = "FPOP1"), size = 1)+labs( x = "data length", y = "mean time (ms)", title ="FPOP1: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_TIME_F[[2]] <- ggplot(TIME_F, aes(Time))+geom_line(aes(y = TIME_F[,3], color = "FPOP2"), size = 1)+labs( x = "data length", y = "mean time (ms)", title ="FPOP2: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_TIME_F[[3]] <- ggplot(TIME_F, aes(Time))+geom_line(aes(y = TIME_F[,4], color = "FPOP3"), size = 1)+labs( x = "data length", y = "mean time (ms)", title ="FPOP3: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_TIME_F[[4]] <- ggplot(TIME_F, aes(Time))+geom_line(aes(y = TIME_F[,5], color = "PELT"), size = 1)+labs( x = "data length", y = "mean time (ms)", title ="PELT: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
PLOT_TIME_F[[5]] <- ggplot(TIME_F, aes(Time))+geom_line(aes(y = TIME_F[,6], color = "OP"), size = 1)+labs( x = "data length", y = "mean time (ms)", title ="OP: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))


PLOT_TIME_F[[6]] <- ggplot(TIME_F, aes(Time))+geom_line(aes(y = TIME_F[,2], color = "FPOP1"), size = 1)+geom_line(aes(y = TIME_F[,3], color = "FPOP2"), size = 1)+geom_line(aes(y = TIME_F[,4], color = "FPOP3"), size = 1)+geom_line(aes(y = TIME_F[,5], color = "PELT"), size = 1)+geom_line(aes(y = TIME_F[,6], color = "OP"), size = 1)+labs( x = "data length", y = "mean time (ms)", title ="Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))

png(filename = "PLOT FPOP1 time complexity.png",  width = 1000, height = 1000)
ggarrange(PLOT_TIME_F[[1]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT FPOP2 time complexity.png",  width = 1000, height = 1000)
ggarrange(PLOT_TIME_F[[2]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT FPOP3 time complexity.png",  width = 1000, height = 1000)
ggarrange(PLOT_TIME_F[[3]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT PELT time complexity.png",  width = 1000, height = 1000)
ggarrange(PLOT_TIME_F[[4]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT OP time complexity.png",  width = 1000, height = 1000)
ggarrange(PLOT_TIME_F[[5]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT time complexity.png",  width = 1000, height = 1000)
ggarrange(PLOT_TIME_F[[6]],ncol = 1, nrow = 1)
dev.off()
################################################################################
log_PLOT_TIME_F<-list()
log_PLOT_TIME_F[[1]] <- ggplot(log10(TIME_F), aes(log10(Time)))+geom_line(aes(y = log10(TIME_F[,2]), color = "FPOP1"), size = 1)+labs( x = "lg(data length)", y = "lg(mean time) (ms)", title ="FPOP1: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
log_PLOT_TIME_F[[2]] <- ggplot(log10(TIME_F), aes(log10(Time)))+geom_line(aes(y = log10(TIME_F[,3]), color = "FPOP2"), size = 1)+labs( x = "lg(data length)", y = "lg(mean time) (ms)", title ="FPOP2: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
log_PLOT_TIME_F[[3]] <- ggplot(log10(TIME_F), aes(log10(Time)))+geom_line(aes(y = log10(TIME_F[,4]), color = "FPOP3"), size = 1)+labs( x = "lg(data length)", y = "lg(mean time) (ms)", title ="FPOP3: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
log_PLOT_TIME_F[[4]] <- ggplot(log10(TIME_F), aes(log10(Time)))+geom_line(aes(y = log10(TIME_F[,5]), color = "PELT"), size = 1)+labs( x = "lg(data length)", y = "lg(mean time) (ms)", title ="PELT: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
log_PLOT_TIME_F[[5]] <- ggplot(log10(TIME_F), aes(log10(Time)))+geom_line(aes(y = log10(TIME_F[,6]), color = "OP"), size = 1)+labs( x = "lg(data length)", y = "lg(mean time) (ms)", title ="OP: Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))
log_PLOT_TIME_F[[6]] <- ggplot(log10(TIME_F), aes(log10(Time)))+geom_line(aes(y = log10(TIME_F[,2]), color = "FPOP1"), size = 1)+geom_line(aes(y = log10(TIME_F[,3]), color = "FPOP2"), size = 1)+geom_line(aes(y = log10(TIME_F[,4]), color = "FPOP3"), size = 1)+geom_line(aes(y = log10(TIME_F[,5]), color = "PELT"), size = 1)+geom_line(aes(y = log10(TIME_F[,6]), color = "OP"), size = 1)+labs( x = "lg(data length)", y = "lg(mean time) (ms)", title ="Time complexity")+theme(legend.position = c(0, 1),legend.justification = c(0, 1))

png(filename = "PLOT FPOP1 time complexity lg.png",  width = 1000, height = 1000)
ggarrange(log_PLOT_TIME_F[[1]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT FPOP2 time complexity lg.png",  width = 1000, height = 1000)
ggarrange(log_PLOT_TIME_F[[2]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT FPOP3 time complexity lg.png",  width = 1000, height = 1000)
ggarrange(log_PLOT_TIME_F[[3]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT PELT time complexity lg.png",  width = 1000, height = 1000)
ggarrange(log_PLOT_TIME_F[[4]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT OP time complexity lg.png",  width = 1000, height = 1000)
ggarrange(log_PLOT_TIME_F[[5]],ncol = 1, nrow = 1)
dev.off()
png(filename = "PLOT time complexity lg.png",  width = 1000, height = 1000)
ggarrange(log_PLOT_TIME_F[[6]],ncol = 1, nrow = 1)
dev.off()


png(filename = "Time complexity.png",  width = 1000, height = 500)
ggarrange(PLOT_TIME_F[[6]], log_PLOT_TIME_F[[6]],ncol = 2, nrow = 1)
dev.off()



######