#' @title data_gen2D
#'  
#' @description Generation of data of dimension 2 with a given values of means and changepoints
#' 
#' @param n number of data point.
#' @param chpts a vector of increasing changepoint indices. Last index is always less than 'n'.
#' By default, 'chpts = NULL' (the data without changepoints). 
#' @param means1 vector of successive means1 for data1, by default 'means1 = 0'.
#' @param means2 vector of successive means2 for data2, by default 'means2 = 0'.
#' @param noise standard deviation of an additional normal noise, by default 'noise = 1'.
#'  
#' @return matrix of data of dimension 2 x n with a given values of means by the segmentation.
#'  
#' @examples
#' Data <- data_gen2D(n = 10, chpts = NULL, means1 = 0, means2 = 0, noise = 1)

data_gen2D <- function(n, chpts = NULL, means1 = 0, means2 = 0, noise = 1)
{
  #---stop---#
  if (!is.null(chpts) && n <= chpts[length(chpts)]){stop('last element of changepoints is always less than n')}
  if(!is.null(chpts) && !is.numeric(chpts)){stop('changepoints are not all numeric')}
  if(is.unsorted(chpts)){stop('changepoints should be an increasing vector')}
  
  if(!is.numeric(means1)){stop('means1 are not all numeric')}
  if(!is.numeric(means2)){stop('means2 are not all numeric')}
  
  if ((length(chpts)+1) !=  length(means1)){stop('The length of the means1 is always equal to the number of changepoints plus one')}
  if ((length(chpts)+1) !=  length(means2)){stop('The length of the means2 is always equal to the number of changepoints plus one')}  
    
  if(length(means1) != (length(means2))){stop('means1 and means2 vectors are of different size')}
  
  if(!is.double(noise)){stop('noise is not a double')}
  if(noise < 0){stop('noise must be non-negative')}
  #---function---#	
  data <- matrix(0,2,n)
  InttT<- diff(c(0,chpts,n))
  # rnorm(mu,noise) = mu + rnorm(0,noise)
  data[1,] <- rep(means1, InttT) + rnorm(n, 0, noise)
  data[2,] <- rep(means2, InttT) + rnorm(n, 0, noise)
  return(data)
}

#' @title plotFPOP2D
#'  
#' @description Plot of data with a  values of means and changepoints.
#' 
#' @param data matrix of data of dimension 2 x data length.
#' @param chpts a vector of increasing changepoint indices. Last index is always less than data length.
#' @param means1 vector of successive means1 for data1.
#' @param means2 vector of successive means2 for data2.

#' @return Plot of data with a given values of means and changepoints.
#'  
#' @examples
#' Data <- data_gen2D(n = 10, chpts = NULL, means1 = 0, means2 = 1, noise = 1)
#' plotFPOP2D(data = Data, chpts = NULL, means1 = 0, means2 = 1)

plotFPOP2D <- function (data, chpts, means1, means2)
{
  #---stop---#
  if ((chpts!=NULL) && length(data[1,]) <= chpts[length(chpts)]){stop('last element of changepoints is always less than n')}
  
  if(!is.numeric(data)){stop('data values are not all numeric')}
  if(is.unsorted(chpts)){stop('changepoints should be an increasing vector')}
  if(!is.numeric(means1)){stop('means1 are not all numeric')}
  if(!is.numeric(means2)){stop('means2 are not all numeric')}
  
  if ((length(chpts)+1) !=  length(means1)){stop('The length of the means1 is always equal to the number of changepoints plus one')}
  if ((length(chpts)+1) !=  length(means2)){stop('The length of the means2 is always equal to the number of changepoints plus one')}  
  
  if( length(means1) != (length(means2)) ){stop('means1 and means2 vectors are of different size')}

  #---function---#
  tau <- c(0, chpts, length(data[1,]))
  par(mfrow = rbind(2,1))
  plot(c(1:length(data[1,])), data[1,], main = "FPOP Y1", xlab = "time", ylab = "Y1", col = "blue")
  abline(v = chpts, lty = 2, col = "grey")
  i<-1
  while(i != length(tau)){
    lines(c(tau[i],tau[i+1]), c(means1[i],means1[i]), type = "l", col = "red")
    i<-i+1
  }
  plot(c(1:length(data[2,])), data[2,], main = "FPOP Y2 ", xlab = "time", ylab = "Y2", col = "red")
  abline(v = chpts, lty = 2, col = "grey")
  i<-1
  while(i != length(tau)){
    lines(c(tau[i],tau[i+1]), c(means2[i],means2[i]), type = "l", col = "blue")
    i<-i+1
  }
}


