#avec bruit
n <- 100
chp <- c(n)
mu1 <- c(0)
mu2 <- c(0)
sigma <- 0.3
penalty <- 2 * sigma * log(10)

data <- data_gen2D(n, chp, mu1, mu2, sigma)
data

resFPOPt1 <- FPOP2D(data[1,], data[2,], penalty, type = 1)
resFPOPt1

resFPOPt2 <- FPOP2D(data[1,], data[2,], penalty, type = 2)
resFPOPt2

resFPOPt3 <- FPOP2D(data[1,], data[2,], penalty, type = 3)
resFPOPt3

#avec bruit
n <- 10
chp <- c(5,n)
mu1 <- c(0,10)
mu2 <- c(0,10)
sigma <- 0.3
penalty <- 2 * sigma * log(10)

data <- data_gen2D(n, chp, mu1, mu2, sigma)
data

resFPOPt1 <- FPOP2D(data[1,], data[2,], penalty, type = 1)
resFPOPt1

resFPOPt2 <- FPOP2D(data[1,], data[2,], penalty, type = 2)
resFPOPt2

resFPOPt3 <- FPOP2D(data[1,], data[2,], penalty, type = 3)
resFPOPt3

#avec bruit
n <- 100
chp <- c(5,n)
mu1 <- c(10,0)
mu2 <- c(10,0)
sigma <- 0.3
penalty <- 2 * sigma * log(10)

data <- data_gen2D(n, chp, mu1, mu2, sigma)
data

resFPOPt1 <- FPOP2D(data[1,], data[2,], penalty, type = 1)
resFPOPt1

resFPOPt2 <- FPOP2D(data[1,], data[2,], penalty, type = 2)
resFPOPt2

resFPOPt3 <- FPOP2D(data[1,], data[2,], penalty, type = 3)
resFPOPt3