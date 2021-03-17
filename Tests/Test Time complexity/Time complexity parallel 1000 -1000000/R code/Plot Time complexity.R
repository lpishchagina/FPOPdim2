###############################
#         data length         #
###############################
length.simu <-NULL
nb.iter <-4
for (i in 1:nb.iter){length.simu <- c(length.simu, 10^(i+2))}
###############################
#The data plot:time complexity#
###############################

mean.OP <- readLines(con = 'Time complexity OP parallel.txt', n = -1)
mean.OP <- strsplit(lbl_excl,split = ' ')
mean.OP <- sapply(lbl_excl, FUN = function(x) {as.integer(unlist(x))})

mean.PELT <- readLines(con = 'Time complexity PELT parallel.txt', n = -1)
mean.PELT <- strsplit(lbl_excl,split = ' ')
mean.PELT <- sapply(lbl_excl, FUN = function(x) {as.integer(unlist(x))})

mean.FPOP1 <- readLines(con = 'Time complexity FPOP1 parallel.txt', n = -1)
mean.FPOP1 <- strsplit(lbl_excl,split = ' ')
mean.FPOP1 <- sapply(lbl_excl, FUN = function(x) {as.integer(unlist(x))})

mean.FPOP2 <- readLines(con = 'Time complexity FPOP2 parallel.txt', n = -1)
mean.FPOP2 <- strsplit(lbl_excl,split = ' ')
mean.FPOP2 <- sapply(lbl_excl, FUN = function(x) {as.integer(unlist(x))})

mean.FPOP3 <- readLines(con = 'Time complexity FPOP3 parallel.txt', n = -1)
mean.FPOP3 <- strsplit(lbl_excl,split = ' ')
mean.FPOP3 <- sapply(lbl_excl, FUN = function(x) {as.integer(unlist(x))})

mean.PELT <-
mean.FPOP1 <-
mean.FPOP2 <-
mean.FPOP3 <-
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