#include <iostream>
#include <vector>
#include "math.h"
#include "Cost.h"
#include <Rcpp.h>

using namespace std;

using namespace Rcpp;

//constructor*******************************************************************
Cost::Cost(unsigned int i, unsigned int t, double* si_1, double* st, double mi_1pen)
{
  coef = t - i + 1;
  mu1 = (st[0] - si_1[0])/(t - i + 1);
  mu2 = (st[1] - si_1[1])/(t - i + 1);
  coef_Var = (st[2] - si_1[2]) + (st[3] - si_1[3]) - coef * (mu1 * mu1 + mu2 * mu2);
  mi_1_p = mi_1pen;
}

//accessory*********************************************************************
unsigned int Cost::get_coef() const {return coef;}

double Cost::get_coef_Var() const {return coef_Var;}

double Cost::get_mi_1_p() const {return mi_1_p;}

double Cost::get_mu1() const {return mu1;}

double Cost::get_mu2() const {return mu2;}

double Cost::get_min(){ return(coef_Var + mi_1_p);}// q_it is a paraboloid => min{q_it} = coef_Var + mi_1_p

//******************************************************************************





