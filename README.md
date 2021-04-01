<a id="top"></a>
#  FPOPdim2 Vignette
### Liudmila Pishchagina
### march 1, 2021

## Quick Start

`FPOPdim2` is an R package written in Rcpp/C++ and developed to detection changepoints using the Functional Pruning Optimal Partitioning method (FPOP) in bivariate time series of length `n`. 

The package implements the following types of FPOP-pruning: 

`type = 1`: ("intersection" of sets), approximation - "rectangle"; 

`type = 2`:("intersection" of sets)"minus"("union" of sets), approximation - "rectangle";

`type = 3`: (last disk)"minus"("union" of sets), approximation - "disk".


We present a basic use of the main functions of the `FPOPdim2` package. 

We install the package from Github:

```r
#devtools::install_github("lpishchagina/FPOPdim2")
library(FPOPdim2)
```

## The function data_gen2D

The `data_gen2D` function simulates a bivariate time series of length `n` with the arguments:

`n`  is the time series length.

`chpts` is the changepoint vector that gives the last index of each segment.

The last element of `chpts` always equals to the length of time series.

`means1` vector of successive means for the first univariate time series.

`means2` vector of successive means for the second univariate time series.


`noise` is a variance of the time series (by default it is equal to `1`).


```r
Data =  data_gen2D(n = 10, chpts = c(2, 4, 6, 8, 10), means1 = c (0, 1, 0, 1, 0), means2 = (1, 2, 3, 4, 5), noise = 1)
```
## The function FPOPDp

The `FPOP2D` function returns the result of the segmentation of FPOP-method using the parameters:

`data1` is the first time series.

`data2` is the second time series.

`penalty` is the value of penalty (a non-negative real number).

The `penalty` here equals to a classic `2*(noise^2)*log(n)`. 

`type` is a value defining the  type of geometry for FPOP-pruning.

The `type` must be either `1`, `2` or `3`:

`type = 1`: ("intersection" of sets), approximation - "rectangle"; 

`type = 2`:("intersection" of sets)"minus"("union" of sets), approximation - "rectangle";

`type = 3`: (last disk)"minus"("union" of sets), approximation - "disk".

We choose a Gaussian cost in 2-dimension.

```r
library(base)

set.seed(13)

size <- 1000

sigma <- 1

beta <- 2 * sigma * log(size)

Data <- data_gen2D(n = size, chpts = c(size), means1 = c (0),means1 = c (0), noise = 1) 

resFPOP1 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)

resFPOP2 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)

resFPOP3 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)

```

```
## resFPOP2$chpts
## 
## resFPOP2$means1
## 
## resFPOP2$means2
## 
## resFPOP2$globalCost
##
```

`chpts` is the changepoint vector that gives the last index of each segment.

The last element of `chpts` always equals to the length of time series.

`means1` is the vector of successive means for the first time series.

`means2` is the vector of successive means for the second time series.

`globalCost` is the overall Gaussian cost of the segmented data. 

[Back to Top](#top)