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


std::list<Disk> get_disks_t_1();


unsigned int Geom5::get_label_t() const {return label_t;}
std::list<Disk> Geom5::get_disks_t_1() const {return disks_t_1;}

double Geom5::distance(double a1, double a2, double b1, double b2)
{
  return(sqrt((a1 - b1)*(a1 - b1) +(a2 - b2)*(a2 - b2)));
}


void Geom5::InitialGeometry(unsigned int i, std::list<Disk> const& disks)
{
  label_t = i;
  disks_t_1 = disks;
}


bool Geom5::EmptyGeometry(){return fl_empty;}

void Geom5::UpdateGeometry(Disk const& disk_t)
{
  //
  // STEP 1 : disks inclusion & intersection
  //
  double dist;
  std::list<Disk>::iterator it = disks_t_1.begin();
  
  // (i) prove emptiness or remove disk in disks_t_1
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
  
  // (ii) Stop pruning or remove disk in disks_inter or prove emptiness
  it = disks_inter.begin();
  while(it != disks_inter.end())
  {
    dist = distance(disk_t.get_center1(), disk_t.get_center2(), (*it).get_center1(), (*it).get_center2());
    if (dist <= (disk_t.get_radius() - (*it).get_radius()))
    {
       return; // case disk_t contains one disks_inter ! 
    }
    if(dist < ((*it).get_radius() + disk_t.get_radius()))
    {
      if (dist <= ((*it).get_radius() - disk_t.get_radius()))
      {
        it = disks_inter.erase(it);
      }else{++it;}
    }
    else
    {
      std::cout << "2";
      fl_empty = true;
      return;
    }
  }
  
  if(disks_inter.empty() && disks_t_1.empty())
  {
    //FrontierPoints.push_back(Point(disk_t.get_center1(), disk_t.get_center2()));  ///ADD Frontier points
    disks_inter.push_back(disk_t);
    return;
  }

  // STEP 2 : if necessary, find frontier points (xy coordinates)
  // 
  //
  
  Intervals intervals; // contains one Interval [-PI,PI]
  Interval currentInter;

    // (i) exclusion disks disks_t_1
  it = disks_t_1.begin();
  while((it != disks_t_1.end()) && (intervals.isempty() == false))
  {
    if(distance(disk_t.get_center1(), disk_t.get_center2(), (*it).get_center1(), (*it).get_center2()) > (disk_t.get_radius() - (*it).get_radius()))
    { // = if there exists an intersection between the 2 disks
      std:cout << "INTERSECTION" << std::endl;
      currentInter.Interval_intersection(disk_t, (*it));
      intervals.intersection(currentInter);
    }
    ++it;
  }

  // (ii) no disks_inter test only intervals 
  if(disks_inter.empty())
  {
    if(intervals.isempty() == true) // disk_t in exclusion disks
    {
      std::cout << "3";
      fl_empty = true; 
      return;
    } 
    FrontierPoints.splice(FrontierPoints.begin(), (intervals.buildPoints(disk_t)));  ///ADD Frontier points
    disks_inter.push_back(disk_t); ///ADD THE NEW DISK 
    std::cout << " nb points " << FrontierPoints.size() << std::endl;
  }
  else  ///// (iii) intersection disks disks_inter /////// START PB !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  {   std::cout << " nb points " << FrontierPoints.size() << std::endl;
    /////// TESTTESTTESTTESTTESTTESTTESTTEST

    it = disks_inter.begin();
    while(it != disks_inter.end() && (intervals.isempty() == false))
    {
      std::cout << " LABEL " << label_t << std::endl;
      intervals.print();
      std::cout << "EXCLUSION " << std::endl;
      currentInter.Interval_intersection(disk_t, (*it));
      std::cout << " INTERVAL2 " << currentInter.get_left() <<  " " << currentInter.get_right() << std::endl;
      currentInter.symmetry();
      std::cout << " INTERVAL3 " << currentInter.get_left() <<  " " << currentInter.get_right() << std::endl;
      
      intervals.intersection(currentInter);
      intervals.print();
      std::cout << std::endl;
      ++it;
    }
    if(intervals.buildPoints(disk_t).empty() && intervals.get_nbIntersections() > 0) // disk_t in exclusion disks
    {
      //std::cout << "8";
      //return;
    } 
    /////// TESTTESTTESTTESTTESTTESTTESTTEST
    
    // (iv) add disk_t and update FrontierPoints if intervals non empty
    
    //remove some FrontierPoints
    std::list<Point>::iterator itP;
    if(intervals.isempty() == false)
    {
      disks_inter.push_back(disk_t); ///ADD THE NEW DISK 
      int NB = 0;
      itP = FrontierPoints.begin();
      while(itP != FrontierPoints.end())
      {
        NB = NB + 1;
        //std::cout << " p " << (*itP).get_x() << " " << (*itP).get_y() << " p ";
        ++itP;
      }
      //std::cout << " NB1 " << NB << " ";
      
      itP = FrontierPoints.begin();
      while(itP != FrontierPoints.end())
      {
        if(distance((*itP).get_x(),(*itP).get_y(),disk_t.get_center1(), disk_t.get_center2()) > disk_t.get_radius())
        {
          itP = FrontierPoints.erase(itP);
        }
        else{++itP;}
      }
      //add the new points
      NB = 0;
      itP = FrontierPoints.begin();
      while(itP != FrontierPoints.end())
      {
        NB = NB + 1;
        //std::cout << " p " << (*itP).get_x() << " " << (*itP).get_y() << " p ";
        ++itP;
      }
      //std::cout << " NB2 " << NB << " ";
    
      FrontierPoints.splice(FrontierPoints.begin(), (intervals.buildPoints(disk_t))); 
      itP = FrontierPoints.begin();
      NB = 0;
      while(itP != FrontierPoints.end())
      {
        NB = NB + 1;
        //std::cout << " p " << (*itP).get_x() << " " << (*itP).get_y() << " p ";
        ++itP;
      }
      //std::cout << " NB3 " << NB << " L " << intervals.get_length() << " ";
      //if(intervals.get_length() > 2){intervals.print();}
    }
    else // intervals = NULL => test all the points
    { 
      //std::cout << "X";
      bool onePointInside = false;
      std::list<Point>::iterator itP = FrontierPoints.begin();
     // std::cout << "LENGTH " << FrontierPoints.size() << std::endl;
      while(itP != FrontierPoints.end())
      {
        //if(distance((*itP).get_x(), (*itP).get_y(), disk_t.get_center1(), disk_t.get_center2()) > disk_t.get_radius())
        //{std::cout << "ZZZZ " << (*itP).get_x() << " " << (*itP).get_y() << " " << disk_t.get_center1() << " "<< disk_t.get_center2() << " R " << disk_t.get_radius() << " d " << distance((*itP).get_x(), (*itP).get_y(), disk_t.get_center1(), disk_t.get_center2())  << std::endl;}
        if(distance((*itP).get_x(), (*itP).get_y(), disk_t.get_center1(), disk_t.get_center2()) <= disk_t.get_radius())
        {
         // std::cout << "YYYY " << (*itP).get_x() << " " << (*itP).get_y() << " " << disk_t.get_center1() << " "<< disk_t.get_center2() << " R " << disk_t.get_radius() << " d " << distance((*itP).get_x(), (*itP).get_y(), disk_t.get_center1(), disk_t.get_center2())  << std::endl;
          onePointInside = true;
          ++itP;
        }
        else
        {
          //itP = FrontierPoints.erase(itP);
          ++itP;
        }
      }
     if(onePointInside == false){std::cout << "4"; fl_empty = true;}
    }
  }
} 
