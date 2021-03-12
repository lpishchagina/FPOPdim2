#include "Disk.h"
#include "Rect.h"
#include "Geom3.h"
#include <iostream>
#include <math.h>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;

//-----------------------------constructor--------------------------------------//
Geom3::Geom3(){
  label_t = 0;
  disks_t_1.clear();
}

Geom3::Geom3(unsigned  int t,  std::list<Disk> disks){
  label_t = t;
  disks_t_1 = disks;
}

unsigned int Geom3::get_label_t(){return label_t;}

std::list<Disk> Geom3::get_disks_t_1(){return disks_t_1;}


bool Geom3::IsEmpty(){return false;}

void Geom3::UpdateDisks(Disk disk_t){
  std::list<Disk>::iterator iter;
  iter = disks_t_1.begin();
    
  while( iter != disks_t_1.end()){
    Disk disk = *iter;
    double dist = (disk_t.get_center1() - disk.get_center1())*(disk_t.get_center1()-disk.get_center1());
    dist = dist + (disk_t.get_center2() - disk.get_center2())*(disk_t.get_center2()-disk.get_center2());
    
    if (sqrt(dist) >= (disk.get_radius() + disk_t.get_radius())){ iter = disks_t_1.erase(iter);--iter;}
    
    ++iter; 
  }
}