#############################################################################################
#############################################################################################
##                               Data simulation                                           ##
##                            The data without changepoints                                ##
##                                (n = 10^i, i=1:6)                                        ##
##                              See "Tests\Data Simulations"                                ##
#############################################################################################
#############################################################################################

###############################
#    package installation     #
###############################
#devtools::install_github("lpishchagina/FPOPdim2")

library(FPOPdim2)

###############################
#       data generation       #
#The data without changepoints#
###############################

##############################
#parameters mu1, mu2, sigma  #
#       (by default)         #
##############################
mu1 <- c(0)
mu2 <- c(0)
sigma <- 1

# See "Tests\Data Simulations"

for (i in 1:6){
  n =  10^i
  chp = n
  data <- data_gen2D(n, chp, mu1, mu2, sigma)
  write.table(data, paste("data", n,".txt"),sep = " ", eol = "\n", na = "NA", dec = ".", row.names = FALSE, col.names = FALSE)
}

