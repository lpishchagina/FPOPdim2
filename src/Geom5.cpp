#include "Geom5.h"

#include <iostream>
#include <iterator>
#include <list>
#include <math.h>

using namespace std;


Geom5::Geom5()
{
  label_t = 0;
  fl_empty = false;
}

Geom5::Geom5(unsigned int t)
{
  label_t = t;
  fl_empty = false;
}

unsigned int Geom5::get_label_t(){return label_t;}
std::list<Disk> Geom5::get_disks_t_1(){return disks_t_1;}

double Geom5::distance(double a1, double a2, double b1, double b2)
{
  return(sqrt((a1 - b1)*(a1 - b1) +(a2 - b2)*(a2 - b2)));
}


void Geom5::InitialGeometry(unsigned int i, std::list<Disk> const& disks)// CHANGE ( std::list<Disk> const& disks) => (unsigned int i, std::list<Disk> const& disks)
{
  label_t = i;// CHANGE add label_t = i;
  disks_t_1 = disks;
}


bool Geom5::EmptyGeometry(){return fl_empty;}


void Geom5::UpdateGeometry(const Disk &disk_t) // CHANGE (Disk disk_t) => (const Disk &disk_t)
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
    if(dist >= ((*it).get_radius() + disk_t.get_radius()))
    {
      it = disks_t_1.erase(it);
    }
    else{++it;}
    if(dist <= ((*it).get_radius() - disk_t.get_radius()))
    {
      fl_empty = true;
      it = disks_t_1.end();
    }
  }
  
  // (ii) Remove disk in disks_inter or prove emptiness
  if(fl_empty == false)
  {
    it = disks_inter.begin();
    while(it != disks_inter.end())
    {
      dist = distance(disk_t.get_center1(), disk_t.get_center2(), (*it).get_center1(), (*it).get_center2());
      if (dist <= ((*it).get_radius() - disk_t.get_radius()))
      {
        it = disks_inter.erase(it);
      }
      else{++it;}
      if(dist >= ((*it).get_radius() + disk_t.get_radius()))
      {
        fl_empty = true;
        it = disks_inter.end();
      }
    }
  }
  
  //
  // STEP 2 : if necessary, find frontier points (xy coordinates)
  // /if no intersection disk => build new frontier Points
  //
  if(fl_empty == false)
  {
    Intervals intervals; // contains one Interval [-PI,PI]
    Interval currentInter;
    
    // (i) exclusion disks disks_t_1
    it = disks_t_1.begin();
    while(it != disks_t_1.end())
    {
      currentInter.Interval_intersection(disk_t, (*it));
      currentInter.symmetry();
      intervals.intersection(currentInter);
      ++it;
    }
    // (ii) new FrontierPoints if no disks_inter
    if(disks_inter.empty())
    {
      FrontierPoints.clear();
      FrontierPoints = intervals.buildPoints(disk_t);
      if(FrontierPoints.empty()){fl_empty = true;}  // disk_t in exclusion disks
    }
    else  // (iii) intersection disks disks_inter
    {  
      it = disks_inter.begin();
      while(it != disks_inter.end())
      {
        currentInter.Interval_intersection(disk_t, (*it));
        intervals.intersection(currentInter);
        ++it;
      }
    
      // (iv) add disk_t and update FrontierPoints if intervals non empty
      if(!intervals.isempty())
      {
        disks_inter.push_back(disk_t); ///ADD THE NEW DISK 
        
        //remove some FrontierPoints
        std::list<Point>::iterator itP = FrontierPoints.begin();
        while(itP != FrontierPoints.end())
        {
          if(distance((*itP).get_x(),(*itP).get_y(),disk_t.get_center1(), disk_t.get_center2()) > disk_t.get_radius())
          {
            itP = FrontierPoints.erase(itP);
          }
          else{++itP;}
        }
        FrontierPoints.splice(FrontierPoints.end(), intervals.buildPoints(disk_t));   
      }
      else // intervals = NULL => test all the points
      {
        bool oneInside = false;
        std::list<Point>::iterator itP = FrontierPoints.begin();
        while(itP != FrontierPoints.end())
        {
          if(distance((*itP).get_x(),(*itP).get_y(),disk_t.get_center1(), disk_t.get_center2()) < disk_t.get_radius())
          {
            oneInside = true;
            ++itP;
          }
          else
          {
            itP = FrontierPoints.erase(itP);
          }
        }
        if(oneInside == false){fl_empty = true;}
      }
    }
    
  }
  
} 