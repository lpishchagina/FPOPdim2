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
  fl_empty = true;
}
Geom3::Geom3(unsigned  int t){
  label_t = t;
  disks_t_1.clear();
  fl_empty = false;
}

//------------------------------------------------------------------------------
unsigned int Geom3::get_label_t(){return label_t;}
std::list<Disk> Geom3::get_disks_t_1(){return disks_t_1;}

double Geom3::Dist(double a1, double a2, double b1, double b2){
  double dist = sqrt((a1 - b1)*(a1 - b1) +(a2 - b2)*(a2 - b2));
  return dist;
}
//------------------------------------------------------------------------------
void Geom3::InitialGeometry(std::list<Disk> disks){
  disks_t_1 = disks;
  fl_empty = false;
}
//------------------------------------------------------------------------------
void Geom3::UpdateGeometry(Disk disk_t){
  std::list<Disk>::iterator iter;
  //Remove disks
  iter = disks_t_1.begin();
  while( iter != disks_t_1.end()){
    Disk disk = *iter;
    double dist = Dist(disk_t.get_center1(), disk_t.get_center2(), disk.get_center1(), disk.get_center2());
    
    if (dist >= (disk.get_radius() + disk_t.get_radius())){ iter = disks_t_1.erase(iter);--iter;}
    
    ++iter; 
  }
  //Exclusion
  iter = disks_t_1.begin();
  while( iter != disks_t_1.end()){
    Disk disk = *iter;
    double dist;
    dist = Dist(disk_t.get_center1(), disk_t.get_center2(), disk.get_center1(), disk.get_center2());
    if (dist <= (disk.get_radius() - disk_t.get_radius())){
      fl_empty = true;
      iter = disks_t_1.end();
    }
    else{++iter;}
  }
} 
//------------------------------------------------------------------------------
bool Geom3::EmptyGeometry() { return fl_empty;}
//------------------------------------------------------------------------------
