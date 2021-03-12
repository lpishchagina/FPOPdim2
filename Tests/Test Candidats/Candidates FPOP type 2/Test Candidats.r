#############################################################################################
#############################################################################################
##                                Test  Candidates                                         ##
##             The number of candidate changepoints stored over time by FPOP               ##
##                            The data withoutchangepoints                                 ##
##                              See Tests\Test Candidats                                   ## 
#############################################################################################
#############################################################################################

#For this test, you need to set the length of the time series and the number of iterations 
#by default, nb_Iter = 100, size = 100000
nb_Iter = 100
size <-100000

chp <- c(size)
mu1 <- c(10)
mu2 <- c(5)
sigma <- 1

penalty <- 2*log(size)

matrix_candidates <- matrix(0, nrow = size, ncol = nb_Iter)

for ( k in 1:nb_Iter){
  data <- data_gen2D(size, chp, mu1, mu2, sigma)
  res_FPOP2<- FPOP2D(data[1,], data[2,], penalty, type = 2)
  
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
png(filename = "Plot Candidats data100000 iter=100.png",  width = 1500, height = 1000)

plot(means_candidates, xlab = "Time", ylab = "Number of candidates(mean) being considered", col = "red3")
lines(means_candidates, col= "red3")
abline(h = mean_value,lty = 2, col= "grey")
abline(v = chp, lty = 2, col = "grey")

dev.off()

#############################################################################################
#############################################################################################
##                                        End Test                                         ##
#############################################################################################
#############################################################################################
