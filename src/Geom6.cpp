#include "Geom6.h"

#include <iostream>
#include <iterator>
#include <list>
#include <math.h>

using namespace std;


Geom6::Geom6()
{
  label_t = 0;
  fl_empty = false;
}

Geom6::Geom6(unsigned int t)
{
  label_t = t;
  fl_empty = false;
}


std::list<Disk> get_disks_t_1();


unsigned int Geom6::get_label_t() const {return label_t;}
std::list<Disk> Geom6::get_disks_t_1() const {return disks_t_1;}

double Geom6::distance(double a1, double a2, double b1, double b2)
{
  return(sqrt((a1 - b1)*(a1 - b1) +(a2 - b2)*(a2 - b2)));
}


void Geom6::InitialGeometry(unsigned int i, std::list<Disk> const& disks)
{
  label_t = i;
  disks_t_1 = disks;
}


bool Geom6::EmptyGeometry(){return fl_empty;}


void Geom6::UpdateGeometry(Disk const& disk_t)
{
  //
  // STEP 1 : disks inclusion & intersection
  //
  double dist;
  std::list<Disk>::iterator it = disks_t_1.begin();
  
  // (i) Remove disk in disks_t_1 or prove emptiness
  while(it != disks_t_1.end())
  {
    dist = distance(disk_t.get_center1(), disk_t.get_center2(), (*it).get_center1(), (*it).get_center2());
    if(dist < ((*it).get_radius() + disk_t.get_radius()))
    {
      if(dist <= ((*it).get_radius() - disk_t.get_radius()))
      {
        std::cout << "1";
        fl_empty = true;
        return;
      }
      else {++it;}
    }
    else {it = disks_t_1.erase(it);} 
  }
  
   //
  // STEP 2 
  //
  Intervals intervals; // contains one Interval [-PI,PI]
  Interval currentInter;
  
  // (i) exclusion disks disks_t_1
  it = disks_t_1.begin();
  while((it != disks_t_1.end()) && (intervals.isempty() == false))
  {
    if(distance(disk_t.get_center1(), disk_t.get_center2(), (*it).get_center1(), (*it).get_center2()) > (disk_t.get_radius() - (*it).get_radius()))
    {
      currentInter.Interval_intersection(disk_t, (*it));
      intervals.intersection(currentInter);
    }
    ++it;
  }

  if(intervals.isempty() == true) // disk_t in exclusion disks
  {
    std::cout << "3";
    fl_empty = true; 
    return;
  } 
  
} 
