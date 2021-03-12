#############################################################################################
#############################################################################################
##                                Exclusions Data                                          ##
##                           The data without changepoints                                 ##
##                             See "Tests\Exclusion Data"                                  ##
#############################################################################################
#############################################################################################
###############################
#    package installation     #
###############################
devtools::install_github("lpishchagina/FPOPdim2")
library(FPOPdim2)


for (i in 1:6){
  size = 10^i;
  data <- readLines(con = paste("data",size,".txt"), n=-1)
  data <- strsplit(data,split = ' ')
  data <- lapply(data, FUN = function(x) {as.double(unlist(x))})
  penalty = 2*log(size);
  res_FPOPt2 <- FPOP2D(data[[1]], data[[2]], penalty, type = 2)
}


for (i in 1:6){
  size = 10^i;
  data <- readLines(con = paste("data",size,".txt"), n=-1)
  data <- strsplit(data,split = ' ')
  data <- lapply(data, FUN = function(x) {as.double(unlist(x))})
  penalty = 2*log(size);
  res_FPOPt2 <- FPOP2D(data[[1]], data[[2]], penalty, type = 3)
}


