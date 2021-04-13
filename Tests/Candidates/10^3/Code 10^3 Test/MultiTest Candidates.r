#############################################################################################
#############################################################################################
##                                Test  Candidates: FPOP                                   ##
##             The number of candidate changepoints stored over time by FPOP               ##
##                            The data without changepoints                                ##
##                              See Tests\Test Candidates                                  ## 
#############################################################################################
#############################################################################################

#For this test, you need to set the length of the time series "size", the vector of dimension "dim", the number of iterations"nb_Iter", "type"  and "fileresult"


devtools::install_github("lpishchagina/FPOPapprox2D")

library(FPOPapprox2D)
library(base)
library(rstream)

nb_Iter = 10
size <-10000
dim <- 2
tp <- 2
chp <- size
mu <- matrix(0, nrow = dim, ncol = 1)

fileresult = "11 dim2 FPOP2 10^4 MultiTest Candidates.txt"

sigma <- 1
penalty <- 2*sigma*log(size)

matrix_candidates <- matrix(0, nrow = size, ncol = nb_Iter)

t = 20
for ( k in 1:nb_Iter){
  set.seed(t+k)
  Data <- data_genDp(dim, size, chp, mu, sigma)
  res_FPOP<- FPOPDp(Data, penalty, type = 2)
  
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
  for (i in 1:length(lbl_excl)){ nb_canditates[i] = length(lbl_excl[[i]])}
  matrix_candidates[,k] = nb_canditates
}
###############################
# mean number of canditates   #
###############################
means_candidates = apply(matrix_candidates, 1, mean)

max_value  <- max(means_candidates)
mean_value <- mean(means_candidates)

write.table(means_candidates, fileresult,  row.names = FALSE,col.names = FALSE) 



#############################################################################################
#############################################################################################
##                                        End Test                                         ##
#############################################################################################
#############################################################################################
