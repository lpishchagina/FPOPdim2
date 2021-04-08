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

The last element of `chpts` is always less than to the length of time series (by default, `chpts = NULL`  for the data without changepoints). 

`means1` vector of successive means for the first univariate time series (by default it is equal to `0`).

`means2` vector of successive means for the second univariate time series (by default it is equal to `0`).

`noise` is a variance of the time series (by default it is equal to `1`).


```r
set.seed(13)

size <- 1000

Data1 <- data_gen2D(size) 
 
Data2 <-  data_gen2D(n = size, chpts = 50, means1 = c(0,1), means2 = c(0,1), noise = 1)
```
## The function FPOP2D

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

beta <- 2 * log(size)

Data1 <- data_gen2D(size) 

FPOP2D(Data1[1,], Data1[2,], penalty = beta, type = 1)

FPOP2D(Data1[1,], Data1[2,], penalty = beta, type = 2)

FPOP2D(Data1[1,], Data1[2,], penalty = beta, type = 3)

```

```
$chpts
numeric(0)

$means1
[1] -0.000587651

$means2
[1] 0.02661018
 
$globalCost
[1] 2.696697e-231

```

```
Data2 <- data_gen2D(n = size, chpts = 50, means1 = c(0,1), means2 = c(0,1), noise = 1)

FPOP2D(Data2[1,], Data2[2,], penalty = beta, type = 1)

FPOP2D(Data2[1,], Data2[2,], penalty = beta, type = 2)

FPOP2D(Data2[1,], Data2[2,], penalty = beta, type = 3)

$chpts
[1] 50

$means1
[1] -0.1255619  0.9782501

$means2
[1] -0.2024644  0.9723707

$globalCost
[1] -13.81551

```

`chpts` is the changepoint vector that gives the last index of each segment.

For the data without changepoints `chpts = numeric(0)`.

`means1` is the vector of successive means for the first time series.

`means2` is the vector of successive means for the second time series.

`globalCost` is the overall Gaussian cost of the segmented data. 

[Back to Top](#top)