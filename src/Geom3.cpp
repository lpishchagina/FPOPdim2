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

//constructor*******************************************************************
Geom3::Geom3(){
  label_t = 0;
  fl_empty = false;
}
Geom3::Geom3(unsigned  int t){
  label_t = t; 
  fl_empty = false;
}

//accessory*********************************************************************
unsigned int Geom3::get_label_t() const {return label_t;}
std::list<Disk> Geom3::get_disks_t_1()const {return disks_t_1;}

//Dist**************************************************************************
double Geom3::Dist(double a1, double a2, double b1, double b2){ return sqrt((a1 - b1)*(a1 - b1) +(a2 - b2)*(a2 - b2));}

//InitialGeometry***************************************************************
void Geom3::InitialGeometry(unsigned int i, const std::list<Disk> &disks){
  label_t = i;
  disks_t_1.clear();
  disks_t_1 = disks;
  fl_empty = false;
}

//UpdateGeometry****************************************************************
void Geom3::UpdateGeometry(const Disk &disk_t){
  double dist;
  std::list<Disk>::iterator iter = disks_t_1.begin();
  while( iter != disks_t_1.end()){
    dist = Dist(disk_t.get_center1(), disk_t.get_center2(), (*iter).get_center1(), (*iter).get_center2());
    if (dist < ((*iter).get_radius() + disk_t.get_radius())){
      if (dist <= ((*iter).get_radius() - disk_t.get_radius())){
        fl_empty = true;
        return;
      }
      else {++iter;}
    }
    else { iter = disks_t_1.erase(iter);}//Remove disks
  }
} 

//EmptyGeometry*****************************************************************
bool Geom3::EmptyGeometry() { return fl_empty;}

//******************************************************************************
