#include "Cost.h"
#include "Disk.h"
#include "Rect.h"
#include "Geom1.h"

#include <math.h>
#include <iostream>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;

Geom1::Geom1(){
  label_t = 0;
  rect_t = Rect();
}
Geom1::Geom1(unsigned  int t, std::list<Disk> disks){
  label_t = t;
  rect_t = Rect();
}

unsigned int Geom1::get_label_t(){return label_t;}

Rect Geom1::get_rect_t(){return rect_t;}

std::list<Disk> Geom1::get_disks_t_1(){
  std::list<Disk> nul_disk;
  nul_disk.clear();
  return nul_disk;
}

bool Geom1::IsEmpty(){return rect_t.IsEmpty_rect();}

void Geom1::IntersectionD2(Disk disk){ rect_t.Intersection_disk(disk);}
