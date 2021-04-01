#ifndef COST_H
#define COST_H

#include <vector>
/*
 Class Cost
 -------------------------------------------------------------------------------
 Description: 
 The Gaussian cost for the interval (i,t) in 2-dimension. 
 
 Parameters:
 "coef" = (t - i + 1);
 "mu1" - the value of mean of the first time series for the interval (i,t);
 "mu2" - the value of mean of the second time series for the interval (i,t);
 "mi_1_p" - sum of the value of the optimal cost at moment (i-1) and penalty;
 "coef_Var" = coef * sumVar(xk_i:t).
 -------------------------------------------------------------------------------
 */

class Cost{
private:
  unsigned int coef;    //(t - i + 1)
  double coef_Var;      //coef * (Var(y1_it) + Var(y2_it))
  double mi_1_p;        //mi_1 + penalty
  double mu1;           //muj = E(yj_it), j =1,2
  double mu2; 
public:

  Cost(){};
  Cost(unsigned int i, unsigned int t, double* si_1, double* st, double mi_1pen);

  unsigned int get_coef() const;
  double get_coef_Var() const;
  double get_mi_1_p() const;
  double get_mu1();
  double get_mu2();
  double get_min();     // q_it is a paraboloid => min{q_it} = coef_Var + mi_1_p


};

#endif // COST_H