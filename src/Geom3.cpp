#include "Disk.h"
#include "Rect.h"
#include "Geom3.h"

#include <iostream>
#include <iterator>
#include <list>
#include <math.h>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;

//------------------------------------------------------------------------------
Geom3::Geom3(){
  label_t = 0;
  disks_t_1.clear();
}
Geom3::Geom3(unsigned  int t){
  label_t = t;
  disks_t_1.clear();
}

//------------------------------------------------------------------------------
unsigned int Geom3::get_label_t(){return label_t;}
std::list<Disk> Geom3::get_disks_t_1(){return disks_t_1;}

double Geom3::Dist(double a1, double a2, double b1, double b2){
  double dist = sqrt((a1 - b1)*(a1 - b1) +(a2 - b2)*(a2 - b2));
  return dist;
}
//------------------------------------------------------------------------------
void Geom3::InitialGeometry(std::list<Disk> disks){disks_t_1 = disks;
  Rcpp::Rcout << "Initial disks size = " << endl;Rcpp::Rcout << disks_t_1.size()<< endl;}
//------------------------------------------------------------------------------
void Geom3::UpdateGeometry(Disk disk_t){
  Rcpp::Rcout << "__________UpdateGeometry__________" << endl;
  Rcpp::Rcout << "disks do: size = " << endl;Rcpp::Rcout << disks_t_1.size()<< endl;
  std::list<Disk>::iterator iter;
  iter = disks_t_1.begin();
  while( iter != disks_t_1.end()){
    Disk disk = *iter;
    double dist = Dist(disk_t.get_center1(), disk_t.get_center2(), disk.get_center1(), disk.get_center2());
    
    
    Rcpp::Rcout << "dist" << endl;
    Rcpp::Rcout << dist << endl;
    Rcpp::Rcout << "r+R" << endl;
    Rcpp::Rcout << (disk.get_radius() + disk_t.get_radius()) << endl;
    
    if (dist >= (disk.get_radius() + disk_t.get_radius())){ iter = disks_t_1.erase(iter);--iter;
    
    Rcpp::Rcout << "Nugno Udalit disk t_1" << endl;
    
    }
    ++iter; 
  }
  Rcpp::Rcout << "disks posle size = " << endl; Rcpp::Rcout << disks_t_1.size()<< endl;
  
  iter = disks_t_1.begin();
  while( iter != disks_t_1.end()){
    Disk disk = *iter;
    double dist;
    dist = Dist(disk_t.get_center1(), disk_t.get_center2(), disk.get_center1(), disk.get_center2());
    Rcpp::Rcout << "dist excl" << endl;
    Rcpp::Rcout << dist << endl;
    Rcpp::Rcout << "R-r" << endl;
    Rcpp::Rcout << (disk.get_radius() + disk_t.get_radius()) << endl;

    
    if (dist <= (disk.get_radius() - disk_t.get_radius())){
      Rcpp::Rcout << "vnutri,  FPOP!!! " << endl;
      label_t = INFINITY;
      iter = disks_t_1.end();
    }
    else{++iter;}
  }
} 
//------------------------------------------------------------------------------
bool Geom3::EmptyGeometry(){ if (label_t == INFINITY) {return true;} else {return false;}}
//------------------------------------------------------------------------------
