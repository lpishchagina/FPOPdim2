#include "Disk.h"
#include "Rect.h"
#include "Geom34.h"
#include <iostream>
#include <math.h>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;

//-----------------------------constructor--------------------------------------//
Geom34::Geom34(){
  label_t = 0;
  disks_t_1.clear();
}

Geom34::Geom34(unsigned  int t,  std::list<Disk> disks){
  label_t = t;
  disks_t_1 = disks;
}

unsigned int Geom34::get_label_t(){return label_t;}

std::list<Disk> Geom34::get_disks_t_1(){return disks_t_1;}


bool Geom34::IsEmpty(){return false;}

double Geom34::Dist(double a1, double a2, double b1, double b2){
  double dist = sqrt((a1 - b1)*(a1 - b1) +(a2 - b2)*(a2 - b2));
  return dist;
}

void Geom34::UpdateDisks(Disk disk_t){
  std::list<Disk>::iterator iter;
  iter = disks_t_1.begin();
  while( iter != disks_t_1.end()){
    Disk disk = *iter;
    double dist = Dist(disk_t.get_center1(), disk_t.get_center2(), disk.get_center1(), disk.get_center2());
    if (dist >= (disk.get_radius() + disk_t.get_radius())){ iter = disks_t_1.erase(iter);--iter;}
  }
}