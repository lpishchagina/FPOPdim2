#include "OP.h"
#include "Disk.h"
#include "Rect.h"
#include "Cost.h"

#include "Geom1.h"
#include "Geom2.h"
#include "Geom3.h"
#include "Geom5.h"

#include "math.h"
#include <Rcpp.h>

//using namespace Rcpp;
//using namespace std;

//' @title FPOP2D 
//'                                                                                                        
//' @description Detecting changepoints using the functional pruning optimal partitioning method (fpop) in bivariate time series.                         
//'                                                                                                       
//' @param data1 is a vector of data1(a univariate time series).                                
//' @param data2 is a vector of data2(a univariate time series).                                
//' @param penalty is a value of penalty (a non-negative real number).                                        
//' @param type is a value defining the  type of geometry for FPOP-pruning: type=1: ("intersection" of sets), approximation - rectangle; type=2:("intersection" of sets)"minus"("union" of sets), approximation - rectangle; type=3: (last disk)"minus"("union" of sets), approximation - disk.       
//'                                                                                                          
//' @return a list of 4 elements  = (chpts, means1, means2, globalCost).                    
//'  
//' \describe{
//' \item{\code{chpts}}{is the vector of changepoints.}
//' \item{\code{means1}}{is the vector of successive means for data1.}
//' \item{\code{means2}}{is the vector of successive means for data2.}
//' \item{\code{globalCost}}{is a number equal to the global cost.}
//' }                                                                                                                                                                             #     
//'             
//' @examples FPOP2D (data1 = c(0,0,0,1,1,1), data2 = c(2,2,2,0,0,0), penalty = 2*log(6),  type = 1) 
// [[Rcpp::export]]
List FPOP2D(std::vector<double> data1, std::vector<double> data2, double penalty, int type) {
  //----------stop--------------------------------------------------------------
  if(data1.size() != data2.size()){throw std::range_error("data1 and data2 have different length");}
  if(penalty < 0) {throw std::range_error("penalty should be a non-negative number");}
  if(type < 1 || type > 5)
  {throw std::range_error("type must be one of: 1,2,3 or 5");}
  //----------------------------------------------------------------------------
  List res;
  bool test;
  test = false;
  if (type == 1){
    //test = true;//
    OP<Geom1> X = OP<Geom1>(data1, data2, penalty);
    X.algoFPOP(data1, data2, type, test);     
    res["chpts"] = X.get_chpts();
    res["means1"] = X.get_means1();
    res["means2"] = X.get_means2();
    res["globalCost"] = X.get_globalCost();
  }
  if (type == 2){
    //test = true;//
    OP<Geom2> Y = OP<Geom2>(data1, data2, penalty);
    Y.algoFPOP(data1, data2, type, test);   
    res["chpts"] = Y.get_chpts();
    res["means1"] = Y.get_means1();
    res["means2"] = Y.get_means2();
    res["globalCost"] = Y.get_globalCost();
  }
  if (type == 3){
    //test = true;//
    OP<Geom3> Z = OP<Geom3>(data1, data2, penalty);
    Z.algoFPOP(data1, data2, type, test);   
    res["chpts"] = Z.get_chpts();
    res["means1"] = Z.get_means1();
    res["means2"] = Z.get_means2();
    res["globalCost"] = Z.get_globalCost();
  }
  if (type == 5){
    //test = true;//
    OP<Geom5> Z = OP<Geom5>(data1, data2, penalty);
    Z.algoFPOP(data1, data2, type, test);   
    res["chpts"] = Z.get_chpts();
    res["means1"] = Z.get_means1();
    res["means2"] = Z.get_means2();
    res["globalCost"] = Z.get_globalCost();
  }
  return res;
}
