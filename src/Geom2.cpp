#include "Disk.h"
#include "Rect.h"
#include "Geom2.h"

#include <iostream>
#include <math.h>
//#include <list>
#include <Rcpp.h>


using namespace Rcpp;
using namespace std;
//------------------------------------------------------------------------------
Geom2::Geom2(){
  label_t = 0;
  rect_t = Rect();
  disks_t_1.clear();
}
Geom2::Geom2(unsigned int t){
  label_t = t;
  rect_t = Rect();
  disks_t_1.clear();
}
//------------------------------------------------------------------------------
unsigned int Geom2::get_label_t(){return label_t;}
Rect Geom2::get_rect_t(){return rect_t;}
std::list<Disk> Geom2::get_disks_t_1(){return disks_t_1;}
//------------------------------------------------------------------------------
void Geom2::InitialGeometry(std::list<Disk> disks){disks_t_1 = disks;}
//------------------------------------------------------------------------------
void Geom2::UpdateGeometry(Disk disk_t){
  //Intersection
  rect_t.Intersection_disk(disk_t);
  //Remove disks
  if(rect_t.IsEmpty_rect() == false){
    std::list<Disk>::iterator iter;
    iter = disks_t_1.begin();
    while( iter != disks_t_1.end()){
      Disk disk = *iter;
      Rect rect = rect_t;
      rect.Intersection_disk(disk);
      if(rect.IsEmpty_rect()){iter = disks_t_1.erase(iter); --iter;
      }
      ++iter;
    }
    //Exclusion
    iter = disks_t_1.begin();
    while( iter != disks_t_1.end()){
      Disk disk = *iter;
      rect_t.Exclusion_disk(disk);
      if(rect_t.IsEmpty_rect()){iter = disks_t_1.end();}
      else{ ++iter;}
    }
  }
}
//------------------------------------------------------------------------------
bool Geom2::EmptyGeometry(){return rect_t.IsEmpty_rect();}
//------------------------------------------------------------------------------

