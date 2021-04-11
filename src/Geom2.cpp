#include "Disk.h"
#include "Rect.h"
#include "Geom2.h"

#include <stdio.h>
#include <fstream>
#include <iostream>
#include <math.h>
//#include <list>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;
//constructor ******************************************************************
Geom2::Geom2(){
  label_t = 0;
  rect_t = Rect();
}
Geom2::Geom2(unsigned int t){
  label_t = t;
  rect_t = Rect();
}

//accessory*********************************************************************
unsigned int Geom2::get_label_t() const {return label_t;}

Rect Geom2::get_rect_t() const {return rect_t;}

std::list<Disk> Geom2::get_disks_t_1() const {return disks_t_1;}

//InitialGeometry***************************************************************
void Geom2::InitialGeometry(unsigned int i, const std::list<Disk> &disks){
  label_t = i; 
  rect_t = Rect(-INFINITY, -INFINITY, INFINITY, INFINITY);
  disks_t_1.clear();
  disks_t_1 = disks; 
}

//UpdateGeometry****************************************************************
void Geom2::UpdateGeometry(const Disk &disk_t){
  //Intersection
  rect_t.Intersection_disk(disk_t);
  // Exclusions
  std::list<Disk>::iterator iter = disks_t_1.begin();
  while(iter != disks_t_1.end() && (!rect_t.IsEmpty_rect())){
    if (rect_t.EmptyIntersection(*iter)) {iter = disks_t_1.erase(iter);}//isn't intersection => Remove disks 
    else {
      rect_t.Exclusion_disk(*iter);
      ++iter;
    }
  }
}

//EmptyGeometry*****************************************************************
bool Geom2::EmptyGeometry(){return rect_t.IsEmpty_rect();}

//******************************************************************************

