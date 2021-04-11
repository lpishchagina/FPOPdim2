#############################################################################################
#############################################################################################
##                                Test                                                     ## 
#############################################################################################
#############################################################################################


devtools::install_github("lpishchagina/FPOPdim2")

devtools::install_github("lpishchagina/OptPartitioning2D")

library(OptPartitioning2D)
library(FPOPdim2)

library(base)
library(rstream)

#Remarque 1 : probl?me globalCost

set.seed(13)
size <-10
beta <- 2 * log(size)
#[1] 4.60517
#Data <- data_gen2D(n, c(n/2,n), c(0,1), c(0,1),0)
Data <- data_gen2D(size, c(size/2), c(0,1), c(0,1),0)
#     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#[1,]    0    0    0    0    0    1    1    1    1     1
#[2,]    0    0    0    0    0    1    1    1    1     1

r1 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)
r2 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)
r3 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 3)
r5 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 5)

#$chpts
#[1] 5

#$means1
#[1] 0 1

#$means2
#[1] 0 1
#$globalCost
#[1] 0
beta <- 2 * log(100)
Data <- data_gen2D(100, c(100/2), c(0,1), c(0,1),0.5)
r1 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)
r2 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)
r3 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 3)
r5 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 5)

#$chpts
#[1] 51

#$means1
#[1] 0.009335243 0.947604816

#$means2
#[1] -0.0364832  1.0904791

#$globalCost
#[1] 50.79613

beta <- 2 * log(100)
Data <- data_gen2D(100, c(10,50), c(0,1,3), c(0,1,3),0.5)
r1 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)
r2 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)
r3 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 3)
r5 = FPOP2D(Data[1,], Data[2,], penalty = beta, type = 5)

#$chpts
#[1]  10 50

#$means1
#[1] 0.06097928 0.79970169 2.96463931

#$means2
#[1] -0.1695328  1.0854681  3.1607837

#$globalCost
#[1] 56.38801




#Remarque 4 : problème avec la dimension 1

#Avec des données sans change-point sur x et un change-point sur y, type 1 ne fonctionne pas
n <- 1000
beta <- 2 * log(n)
Data <- data_gen2D(n, c(n/2), c(0,0), c(0,1), 1)
f1 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)
f2 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)
f3 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 3)
f5 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 5)

cat(c(f1$chpts, f1$means1, f1$means2))
cat(c(f2$chpts, f2$means1, f2$means2))
cat(c(f3$chpts, f3$means1, f3$means2))
cat(c(f5$chpts, f5$means1, f5$means2))
#500 0.06075954 -0.05495222 0.02755059 1.006849
#500 0.06075954 -0.05495222 0.02755059 1.006849
#500 0.06075954 -0.05495222 0.02755059 1.006849
#500 0.06075954 -0.05495222 0.02755059 1.006849

Data <- data_gen2D(n, c(n/2), c(0,1), c(0,0), 1)
f1 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)
f2 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)
f3 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 3)
f5 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 5)

cat(c(f1$chpts, f1$means1, f1$means2))
cat(c(f2$chpts, f2$means1, f2$means2))
cat(c(f3$chpts, f3$means1, f3$means2))
cat(c(f5$chpts, f5$means1, f5$means2))

#505 -0.04679074 1.087025 0.02248882 -0.0536203
#505 -0.04679074 1.087025 0.02248882 -0.0536203
#505 -0.04679074 1.087025 0.02248882 -0.0536203
#509 -0.03234543 1.081287 0.02001434 -0.05167514 !!!!!!

Data <- data_gen2D(n, c(n/2), c(0,-1), c(1,1), 1)
f1 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)
f2 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)
f3 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 3)
f5 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 5)

cat(c(f1$chpts, f1$means1, f1$means2))
cat(c(f2$chpts, f2$means1, f2$means2))
cat(c(f3$chpts, f3$means1, f3$means2))
cat(c(f5$chpts, f5$means1, f5$means2))
#500 0.02130101 -1.073133 1.013464 1.033413
#500 0.02130101 -1.073133 1.013464 1.033413
#500 0.02130101 -1.073133 1.013464 1.033413
#500 0.02130101 -1.073133 1.013464 1.033413


#Remarque 5 : type = 0 pour PELT?
#Après tous ces essais, je me suis convaincu qu'il est important de rajouter le type type = 0 qui donnera le résultat de PELT (ou OP).
#ça permet de savoir quel algorithme est vraiment juste quand ceux-ci donnent des résultats différents (par exemple dans la remarque 4)

#exemple ici avec 3 résultats différents... Lequel est le bon??
#set.seed(13)
#n <- 1000
#beta <- 2 * log(n)
#Data <- data_gen2D(n, c(n/2,n), c(0,0), c(0,1), 1)
#f1 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)
#f2 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 3)
#f3 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 5)

#cat(c(f1$chpts, f1$means1, f1$means2))
#cat(c(f2$chpts, f2$means1, f2$means2))
#cat(c(f3$chpts, f3$means1, f3$means2))
set.seed(13)
n <- 1000
beta <- 2 * log(n)
Data <- data_gen2D(n, c(n/2), c(0,0), c(0,1), 1)

f1 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 1)
f2 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 2)
f3 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 3)
f5 <- FPOP2D(Data[1,], Data[2,], penalty = beta, type = 5)

cat(c(f1$chpts, f1$means1, f1$means2))
cat(c(f2$chpts, f2$means1, f2$means2))
cat(c(f3$chpts, f3$means1, f3$means2))
cat(c(f5$chpts, f5$means1, f5$means2))

#505 0.002761134 -0.009105648 0.01552523 0.9959043
#505 0.002761134 -0.009105648 0.01552523 0.9959043
#505 0.002761134 -0.009105648 0.01552523 0.9959043
#512 -0.00565909 -0.0004415351 0.02308229 1.002038

library(OptPartitioning2D)
op = OptPart2D(Data[1,], Data[2,], beta, type="null")
pelt= OptPart2D(Data[1,], Data[2,], beta, type="pruning")

cat(c(op$changepoints, op$means1, op$means2))
cat(c(pelt$changepoints, pelt$means1, pelt$means2))
#505 1000 0.002761134 -0.009105648 0.01552523 0.9959043
#505 1000 0.002761134 -0.009105648 0.01552523 0.9959043

