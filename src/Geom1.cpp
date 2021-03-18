#include "Cost.h"
#include "Disk.h"
#include "Rect.h"
#include "Geom1.h"

#include <math.h>
#include <iostream>
#include <list>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;
//------------------------------------------------------------------------------
Geom1::Geom1(){
  label_t = 0;
  rect_t = Rect();
}
Geom1::Geom1(unsigned  int t){
  label_t = t;
  rect_t = Rect();
}
//------------------------------------------------------------------------------
int Geom1::get_label_t(){return label_t;}
Rect Geom1::get_rect_t(){return rect_t;}
std::list<Disk> Geom1::get_disks_t_1(){
  std::list<Disk> list_NULL;
  list_NULL.clear();
  return list_NULL;
  }
//------------------------------------------------------------------------------
void Geom1::InitialGeometry(std::list<Disk> disks){ rect_t = Rect();}
//------------------------------------------------------------------------------
void Geom1::UpdateGeometry(Disk disk_t){rect_t.Intersection_disk(disk_t);}
//------------------------------------------------------------------------------
bool Geom1::EmptyGeometry(){return rect_t.IsEmpty_rect();}
//------------------------------------------------------------------------------
