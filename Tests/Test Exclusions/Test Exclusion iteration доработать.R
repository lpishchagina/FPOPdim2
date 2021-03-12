#############################################################################################
#############################################################################################
##                                Test Exclusions                                          ##
##                 The quantity of exclusions stored over time                             ##
##                            The data without changepoints                                ##
##                               See Tests\Test Exclusions                                 ##
#############################################################################################
#############################################################################################

#For this test, you need to set the length of the time series and the number of iterations 
#by default, nb_Iter = 100, size = 100000
nb_Iter = 100
size  =10000

chp <- c(size)
mu1 <- c(10)
mu2 <- c(5)
sigma <- 1

penalty <- 2*log(size)

#initialization of list
mean_value_exclusions = list(NULL) 
for (i in 1:nb_Iter) { mean_value_exclusions [i] = 0}


for (k in 1: nb_Iter){
  
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
  # matrix "matrix_exclusion"   #
  ###############################
  #"matrix_exclusion"  is the matrix with  "length(lbl_excl) - 1" rows and "length(lbl_excl)" columns.
  #Each position contains the number of exclusions for the given label(the row number) at the time t(the column number).
  #If the element does not exist, position and value "NA".
  matrix_exclusion <- matrix(NA,nrow = length(lbl_excl) - 1, ncol= length(lbl_excl))
  for (i in 2:length(lbl_excl)){
    j<- 1
    while (j <= length(lbl_excl[[i]])){
      matrix_exclusion[lbl_excl[[i]][j],i] <- lbl_excl[[i]][j+1]
      j <- j+2
    }
  }
  
  ###############################
  #     list "list_exclusion"   #
  ###############################
  #"list_exclusion"  is the list with  "length(lbl_excl) - 1" list elements.
  #Each list "list_exclusion[[label]]" contains the number of exclusions for the given label.
  #If label do not have exclusions this list have  a length = 0.
  list_exclusion <-lapply(seq_len(nrow(matrix_exclusion)), function(i) matrix_exclusion[i,])
  for (i in  1:length(list_exclusion)){list_exclusion [[i]] = list_exclusion [[i]][!is.na(list_exclusion [[i]])]}
  
  ###############################
  #     max_quantity_exclusion  #
  #     max_length_interval     #
  ###############################
  # max_quantity_exclusion is the range of the number of exclusions 
  # max_length_interval is the range of  the interval length 
  max_length_interval = 0
  for (i in  1:length(list_exclusion)){if (length(list_exclusion [[i]]) != 0){max_length_interval = max(max_length_interval,length(list_exclusion[[i]])) }}
  #initialization of list
  mean_plot = list(NULL) 
  n_plot = 0
  for (i in 1:max_length_interval) {mean_plot[i] = 0}
  #sum calculation for t
  for (i in 1:length(list_exclusion)){
    if (length(list_exclusion [[i]]) != 0){
      n_plot = n_plot+1
      for (j in 1:length(list_exclusion[[i]])){
        mean_plot[[j]]= mean_plot[[j]] + list_exclusion[[i]][j]
      }
    }
  }
  #value of mean for t
  for (i in 1:max_length_interval) {
    mean_plot[[i]] = mean_plot[[i]]/n_plot
  }
  #list -> vector
  v_mean_plot <- unlist(mean_plot)
  mean_value_exclusions[[k]] = v_mean_plot
}  


max_length_interval = 0
for (i in  1:length(mean_value_exclusions)){max_length_interval = max(max_length_interval,length(mean_value_exclusions[[i]]))}
Mean_plot = list(NULL)
for (i in 1:max_length_interval+1) {Mean_plot[i] = 0}

for (i in 1:nb_Iter){
    for (j in 1:length(mean_value_exclusions [[i]])){Mean_plot[[j]]= Mean_plot[[j]] + mean_value_exclusions[[i]][j]}
}

for (i in 1:max_length_interval) {Mean_plot[[i]] = mean_value_exclusions [[i]]/nb_Iter}
v_Mean_plot <- unlist(Mean_plot)

png("Plot Exclusions data10000 Iter100.png",  width = 1500, height = 1000)
plot(c(0, max_length_interval),main = "The mean number of exclusion in the interval(iteration)", xlab = "Time interval", ylab =  "Number of exclusions", type = "n")
points(c(v_Mean_plot, 0),col = "steelblue")
lines(c(v_Mean_plot, 0),col = "steelblue", lwd = 3)
  
############################### legend ########################################
location = "topright"
labels = c("Mean number of exclusions")
colors = c("steelblue")
legend(location, labels, fill = colors)
dev.off()
  

