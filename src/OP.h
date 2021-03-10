#ifndef OP_H
#define OP_H
#include "Disk.h"
#include "Rect.h"
#include "Cost.h"

#include "Geom1.h"
#include "Geom2.h"
#include "Geom3.h"

#include <iostream>
#include <vector>
#include <list>
#include <iterator>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;

template <class GeomX>
class OP{
private:
  double penalty;                                       //value of penalty 
  unsigned int n;                                       // data length
  double** sx12;                                        // vector sum y1,y2, y1^2, y2^2
  
  std::vector<unsigned int> chpts;               // changepoints vector 
  std::vector<double> means1;                           // means vector for y1
  std::vector<double> means2;                           // means vector for y2        
  double globalCost;                                    // value of global cost
  double* m;                                            // "globalCost" = m[n+1] - changepoints.size()*penalty
  GeomX geom_activ;
  std::list<GeomX> list_geom;                            //list of geom
  std::list<Disk> list_disks;                    //list of disks

public:

  OP<GeomX>(){};
  OP<GeomX> (std::vector<double>& x1, std::vector<double>& x2, double beta){
    penalty = beta;
    n = x1.size();
    
    sx12 = new double*[n+1]; 
    for(unsigned int i = 0; i < n + 1; i++) {sx12[i] = new double[4];}
    
    m = new double[n + 1];        // "globalCost" = m[n+1] - changepoints.size()*penalty
  }

  ~OP<GeomX>(){
    for(unsigned int i = 0; i < n+1; i++) {delete(sx12[i]);}
    delete [] sx12;
    sx12 = NULL;
    delete [] m;
    m = NULL;
  }

  std::vector< unsigned int > get_chpts() const {return chpts;}
  
  std::vector< double > get_means1() const{return means1;}
  
  std::vector< double > get_means2() const{return means2;}
  
  double get_globalCost() const {return globalCost;}
  
  unsigned int get_n() const {return n;}
  
  double** get_sx12() {return sx12;}
  
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
  
  void algoFPOP(std::vector<double>& x1, std::vector<double>& x2, int type){
    //preprocessing
    n = x1.size();
    sx12 = vect_sx12(x1, x2);           
    m[0] = 0;
    double** last_chpt_mean = new double*[3];         // vectors of best last changepoints, mean1 and mean2
    for(unsigned int i = 0; i < 3; i++) {last_chpt_mean[i] = new double[n];}
    //unsigned int nb_disk;
    //  std::ofstream test_file;
    //  test_file.open("test.txt");
  
    //Algorithm
    for (unsigned int t = 0; t < n ; t++){
      Cost cost_activ;
      double min_val = INFINITY; //min value of cost
      double mean1;                                   //means for (lbl, t)
      double mean2;
      unsigned int lbl; //best last position for t
      
      if (type > 1) {list_disks.clear();}
      typename std::list<GeomX>::iterator it;
      //First run: search min
      it = list_geom.begin();
      while(it!= list_geom.end()){
        unsigned int u = it->get_label_t();
          
        if (type > 1){
          Cost cost = Cost(u, t-1, sx12[u], sx12[t], m[u]);
          double r2 = (m[t] - m[u] - cost.get_coef_Var())/cost.get_coef();
          Disk disk = Disk(cost.get_mu1(),cost.get_mu2(), sqrt(r2));
          list_disks.push_back(disk);
        }
        Cost cost_activ = Cost(u, t, sx12[u], sx12[t + 1], m[u]);
        if(cost_activ.get_min() <= min_val){
          lbl = u;
          min_val = cost_activ.get_min();
          mean1 = cost_activ.get_mu1();
          mean2 = cost_activ.get_mu2();  
        }
        ++it;
      }
      Cost cost_t = Cost(t, t, sx12[t], sx12[t + 1], m[t]);
      if(cost_t.get_min() <= min_val){
        lbl = t;
        min_val = cost_t.get_min();
        mean1 = cost_t.get_mu1();
        mean2 = cost_t.get_mu2();  
      }
      //new min 
      m[t + 1] = min_val + penalty; 
      //best last changepoints and means
      last_chpt_mean[0][t] = lbl;       //last_chpt_mean[0] - vector of best last chpt
      last_chpt_mean[1][t] = mean1;     //last_chpt_mean[1] - vector of means (lbl,t) for y1
      last_chpt_mean[2][t] = mean2;     //last_chpt_mean[2] - vector of means (lbl,t) for y2
      
      //new geom D_tt
      geom_activ = GeomX(t, list_disks); 
      list_geom.push_back(geom_activ);
      
      //Second run: pruning
      it = list_geom.begin();      
      while (it != list_geom.end()){
        
        lbl = it -> get_label_t();
        Cost cost = Cost(lbl, t, sx12[lbl], sx12[t + 1], m[lbl]);
        double r2 = (m[t + 1] - m[lbl] - cost.get_coef_Var())/cost.get_coef();
        if (r2 <= 0){
          it = list_geom.erase(it);
          --it;
        } 
        else{
          Disk disk = Disk(cost.get_mu1(),cost.get_mu1(), sqrt(r2));
          if (type == 1 || type == 2){it->IntersectionD2(disk);}
          
          if (it->IsEmpty()){ it = list_geom.erase(it); --it;}
          
          else{
            if (type == 2 || type == 3){
              it->UpdateDisks(disk);//remove empty intersection
              if (type == 2){
                list_disks = it-> get_disks_t_1();
                //nb_disk = list_disks.size();
                //bool fl = false;
                std::list<Disk>::iterator it_d;
                it_d = list_disks.begin(); 
               
                while(it_d != list_disks.end()){
                  Disk disk_d = *it_d;
                  it->ExclusionD2(disk_d);
                  if (it->IsEmpty()){
                    it = list_geom.erase(it); --it;
                    it_d = list_disks.end(); --it_d;
                  }
                  ++it_d;
                } //if (fl == false){test_file << lbl << " "<<  nb_disk << " ";}
              }
            }  
          }//else
        }//else
        ++it;
      }
    }
    //test_file.close();
    //result vectors
    unsigned int chp = n;
    while (chp > 0){
      chpts.push_back(chp);
      means1.push_back(last_chpt_mean[1][chp-1]);
      means2.push_back(last_chpt_mean[2][chp-1]);
      chp = last_chpt_mean[0][chp-1];
    }
    reverse(chpts.begin(), chpts.end());
    reverse(means1.begin(), means1.end());
    reverse(means2.begin(), means2.end());
    
    globalCost = m[n + 1] - penalty * chpts.size() ;
    //memory
    for(unsigned int i = 0; i < 3; i++) {delete(last_chpt_mean[i]);}
    delete [] last_chpt_mean;
    last_chpt_mean = NULL;
  }
};

#endif //OP_H