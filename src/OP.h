#ifndef OP_H
#define OP_H
#include "Disk.h"
#include "Rect.h"
#include "Cost.h"

#include "Geom1.h"
#include "Geom2.h"
#include "Geom3.h"

#include <fstream>
#include <iostream>
#include <vector>
#include <list>
#include <iterator>
#include <Rcpp.h>
#include <string> 

using namespace Rcpp;
using namespace std;

/*
 Class OP
 -------------------------------------------------------------------------------
 Description: 
 Template for the realization of FPOP-Algorithm in 2-dimension. 
 
 Parameters:
 "n" - data length;
 "penalty" - value of penalty;
 
 "sx12" - matrix(n+1x2*p) of sum:x1:xp, x1^2:xp^2;
 
 "chpts" - vector of changepoints;
 "means1" - means of changepoints for the first time series; 
 "means2" - means of changepoints for the second time series;  
 "globalCost" - value of global cost.
 
 "m" - globalCost = m[n+1] - chpts.size()*penalty
 "geom" - geometry
 "list_geom" - list of geometry
 --------------------------------------------------------------------------------
 */

template <class GeomX>
class OP{
private:
  double penalty; //value of penalty 
  unsigned int n; //data length
  double** sx12;  // vector sum x1,x2, x1^2, x2^2
  
  std::vector< unsigned int> chpts;    //changepoints vector 
  std::vector<double> means1;         //means vector for y1
  std::vector<double> means2;         //means vector for y2        
  double globalCost;                  //value of global cost
  double* m;                          //globalCost = m[n+1] - chpts.size()*penalty
  GeomX geom;
  std::list<GeomX> list_geom;    //list of geometry
public:
  OP<GeomX>(){};
  //----------------------------------------------------------------------------
  OP<GeomX> (std::vector<double>& x1, std::vector<double>& x2, double beta){
    n = x1.size();
    penalty = beta;
    sx12 = new double*[n+1]; 
    for(unsigned int i = 0; i < n + 1; i++) {sx12[i] = new double[4];}
    m = new double[n + 1];        // "globalCost" = m[n+1] - chpts.size()*penalty
  }
  //----------------------------------------------------------------------------
  ~OP<GeomX>(){
    for(unsigned int i = 0; i < n+1; i++) {delete(sx12[i]);}
    delete [] sx12;
    sx12 = NULL;
    delete [] m;
    m = NULL;
  }
  //----------------------------------------------------------------------------
  std::vector< unsigned int > get_chpts() const {return chpts;}
  std::vector< double > get_means1() const{return means1;}
  std::vector< double > get_means2() const{return means2;}
  double get_globalCost() const {return globalCost;}
  unsigned int get_n() const {return n;}
  double get_penalty() const {return penalty;}
  //----------------------------------------------------------------------------
  double** vect_sx12(std::vector<double>& x1, std::vector<double>& x2) {
    unsigned int n = x1.size();
    for (unsigned i = 0; i < 4; i++){ sx12[0][i] = 0;}
    for (unsigned int j = 1; j < (n + 1); j++){
      sx12[j][0] = sx12[j - 1][0] + x1[j - 1];
      sx12[j][1] = sx12[j - 1][1] + x2[j - 1];
      sx12[j][2] = sx12[j - 1][2] + x1[j - 1] * x1[j - 1];
      sx12[j][3] = sx12[j - 1][3] + x2[j - 1] * x2[j - 1];
    }
    return(sx12);
  }
  //----------------------------------------------------------------------------
  void algoFPOP(std::vector<double>& x1, std::vector<double>& x2, int type, bool test_mode){
    //preprocessing-------------------------------------------------------------
    sx12 = vect_sx12(x1, x2); 
    m[0] = 0;
    double** last_chpt_mean = new double*[3];// vectors of best last changepoints, mean1 and mean2
    for(unsigned int i = 0; i < 3; i++) {last_chpt_mean[i] = new double[n];}
    
    std::ofstream test_file;
    if (test_mode == true){test_file.open("test.txt");}
    
    //Algorithm-----------------------------------------------------------------
    double min_val;  // définitions itératives (*)
    double mean1;
    double mean2;
    double r2;
    unsigned int lbl; 
    unsigned int u; 
    std::list<Disk> list_disk;//list of active disks(t-1)
    geom = GeomX(0); //changer une positon(**)
    for (unsigned int t = 0; t < n ; t++){
      Cost cost = Cost(t, t, sx12[t], sx12[t+1], m[t]);
      min_val = cost.get_min(); //min value of cost  //suprimer définitions itératives (*)
      mean1 =  cost.get_mu1();   //means for (lbl, t)
      mean2 = cost.get_mu2(); 
      lbl = t;         //best last position
      
      list_disk.clear();
      
      //First run: searching min------------------------------------------------
      typename std::list<GeomX>::reverse_iterator rit_geom = list_geom.rbegin(); // supprimer ligne rit_geom = list_geom.rbegin();
      while(rit_geom!= list_geom.rend()){
        u = rit_geom -> get_label_t(); //suprimer définitions itératives (*)
        // Searching: min
        cost = Cost(u, t, sx12[u], sx12[t + 1], m[u]);
        if( min_val >= cost.get_min()){
          lbl = u;
          min_val = cost.get_min();
          mean1 = cost.get_mu1();
          mean2 = cost.get_mu2();  
        }
        //list of active disks(t-1)
        Cost cost_t_1 = Cost(u, t-1, sx12[u], sx12[t], m[u]);
        r2 = (m[t] - m[u] - cost_t_1.get_coef_Var())/cost_t_1.get_coef();  //suprimer définitions itératives (*)
        list_disk.push_back(Disk(cost_t_1.get_mu1(),cost_t_1.get_mu2(), sqrt(r2)));// replacer  Disk disk = Disk(cost_t_1.get_mu1(),cost_t_1.get_mu2(), sqrt(r2));list_disk.push_back(disk);
    
        ++rit_geom;
      }
      //best last changepoints and means
      last_chpt_mean[0][t] = lbl;       //vector of best last chpt
      last_chpt_mean[1][t] = mean1;     //vector of means (lbl,t) for y1
      last_chpt_mean[2][t] = mean2;     //vector of means (lbl,t) for y2
      //new min 
      
      m[t + 1] = min_val + penalty; 
      
      //Initialisation of geometry----------------------------------------------
      geom.InitialGeometry(t, list_disk);
      list_geom.push_back(geom);//(**) geom = GeomX(t)
      
      //Second run: Update list of geometry-------------------------------------
      typename std::list<GeomX>::iterator it_geom = list_geom.begin();//supprimer ligne it_geom = list_geom.begin(); 
      while (it_geom != list_geom.end()){
        lbl = it_geom -> get_label_t();
        cost = Cost(lbl, t, sx12[lbl], sx12[t + 1], m[lbl]);
        r2 = (m[t + 1] - m[lbl] - cost.get_coef_Var())/cost.get_coef();//suprimer définitions itératives (*)
        //PELT
        if (r2 <= 0){it_geom = list_geom.erase(it_geom); --it_geom;}
        //FPOP
        if (r2 > 0){
          it_geom -> UpdateGeometry(Disk(cost.get_mu1(), cost.get_mu2(), sqrt(r2))); //suprimer définitions itératives (*)
          if (it_geom -> EmptyGeometry()){it_geom = list_geom.erase(it_geom);--it_geom;}
          else {if (test_mode == true && (type == 2 || type == 3)){ test_file << it_geom ->get_label_t() << " "<< it_geom ->get_disks_t_1().size() << " ";}}
        }//else
        ++it_geom;
      }
      if (test_mode == true){test_file << "\n";} 
    }
    if (test_mode == true){test_file.close();}
    //Result vectors------------------------------------------------------------
    unsigned int chp = n;
    while (chp > 0){
      chpts.push_back(chp);
      means1.push_back(last_chpt_mean[1][chp-1]);
      means2.push_back(last_chpt_mean[2][chp-1]);
      chp = last_chpt_mean[0][chp-1];
    }
    reverse(chpts.begin(), chpts.end());
    chpts.pop_back();                 // vector chpt (tau1,.., tauk) sans n!!!!
    reverse(means1.begin(), means1.end());
    reverse(means2.begin(), means2.end());
    
    globalCost = m[n + 1] - penalty * chpts.size();   // c'est vrai ou non??????
    //memory--------------------------------------------------------------------
    for(unsigned int i = 0; i < 3; i++) {delete(last_chpt_mean[i]);}
    delete [] last_chpt_mean;
    last_chpt_mean = NULL;
  }
  //----------------------------------------------------------------------------
};


#endif //OP_H      
    