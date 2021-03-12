#include "Disk.h"
#include "Rect.h"
#include "Geom2.h"

#include <iostream>
#include <math.h>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;

Geom2::Geom2(){
  label_t = 0;
  rect_t = Rect();
  disks_t_1.clear();
}

Geom2::Geom2(unsigned int t, std::list<Disk> disks){
  label_t = t;
  rect_t = Rect();
  disks_t_1 = disks;
}

unsigned int Geom2::get_label_t(){return label_t;}

Rect Geom2::get_rect_t(){return rect_t;}

std::list<Disk> Geom2::get_disks_t_1(){return disks_t_1;}


bool Geom2::IsEmpty(){return rect_t.IsEmpty_rect();}

void Geom2::IntersectionD2(Disk disk){rect_t.Intersection_disk(disk);}

void Geom2::ExclusionD2(Disk disk){rect_t.Exclusion_disk(disk);}

void Geom2::UpdateDisks(Disk disk_t){
  std::list<Disk>::iterator iter;
  iter = disks_t_1.begin();
 
  while( iter != disks_t_1.end()){
    Disk disk = *iter;
    Rect rect = rect_t;
    rect.Intersection_disk(disk);
   
    if(rect.IsEmpty_rect()){iter = disks_t_1.erase(iter); --iter;}
    ++iter;
  }
}

