#ifndef COST_H
#define COST_H

#include <vector>

// q_it(theta1, theta2) = mi_1+penalty + (t - i + 1) * [(theta1 - E(y1_it))^2 + (theta2 - E(y2_it))^2] + (t - i + 1) * (Var(y1_it) + Var(y2_it))
//coef_Var = coef*(Var(y1_it) + Var(y2_it))
//mi_1_p =mi_1+penalty
//coef = (t - i + 1) 
//(mu1,mu2) = (E(y1_it), E(y2_it) )
// q_it = mi_1_p + coef * [(theta1 - mu1)^2 + (theta2 - mu2^2)] + coef_Var

//Class Cost
//------------------------------------------------------------------------------
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