#############################################################################################
#############################################################################################
##                                Test  Candidates: FPOP3                                  ##
##             The number of candidate changepoints stored over time by FPOP               ##
##                            The data without changepoints                                ##
##                              See Tests\Test Candidates                                  ## 
#############################################################################################
#############################################################################################

#For this test, you need to set the length of the time series and the number of iterations 
#by default, nb_Iter = 10, size = 1000

#devtools::install_github("lpishchagina/FPOPdim2")

library(FPOPdim2)
library(base)
library(rstream)
library(simEd)

nb_Iter = 10
size <-1000

chp <- size
mu1 <- 0
mu2 <- 0
sigma <- 1

penalty <- 2*sigma*log(size)

matrix_candidates <- matrix(0, nrow = size, ncol = nb_Iter)
t = 20
for ( k in 1:nb_Iter){
  set.seed(t+k)
  data <- data_gen2D(size, chp, mu1, mu2, sigma)
  res_FPOP3<- FPOP2D(data[1,], data[2,], penalty, type = 3)
  
  ###############################
  #     matrix "lbl_excl"       #
  ###############################
  #"lbl_excl"  is the matrix with n rows.
  #Each row contains a sequence of pairs of integer numbers for the moment t (t = 1:n).
  #Each pair contains two values: candidate of changepoint and quantity of exclusion for this candidate.
  ## The values of matrix "lbl_excl" is contained in the papier "Test The data without changepoints".
  lbl_excl <- readLines(con = 'test.txt', n = -1)
  lbl_excl <- strsplit(lbl_excl,split = ' ')
  lbl_excl <- sapply(lbl_excl, FUN = function(x) {as.integer(unlist(x))})
  
  ###############################
  #     number of canditates    #
  ###############################
  nb_canditates = NULL
  for (i in 1:length(lbl_excl)){ nb_canditates[i] = length(lbl_excl[[i]])/2}
  matrix_candidates[,k] = nb_canditates
}
###############################
# mean number of canditates   #
###############################
means_candidates = apply(matrix_candidates, 1, mean)

max_value  <- max(means_candidates)
mean_value <- mean(means_candidates)

######################################
# plot "Mean number of candidates"   #
######################################
png(filename = "Plot FPOP3 Candidats data1000 iter10.png",  width = 1500, height = 1000)

plot(means_candidates, main = "FPOP3:Candidates", xlab = "Time", ylab = "Number of candidates(mean) being considered", col = "purple3")
lines(means_candidates, col= "purple3")
abline(h = mean_value,lty = 2, col= "grey")
abline(v = chp, lty = 2, col = "grey")

dev.off()

write.table(means_candidates, "FPOP3 Candidates  data1000 iter10.txt",  row.names = FALSE,col.names = FALSE  ) 

#############################################################################################
#############################################################################################
##                                        End Test                                         ##
#############################################################################################
#############################################################################################
