#include "Intervals.h"
#include "math.h"
#include<iostream>
#include <iterator>
#include <list>

using namespace std;


void Intervals::print()
{
  std::list<Interval>::iterator it = interv.begin();
  std::cout <<  " -INTERVALS- ";
  while(it != interv.end())
  {
    std::cout << (*it).get_left() << " " <<  (*it).get_right() << " --- ";
    ++it;
  }
  std::cout << std::endl;
}

void Intervals::intersection(Interval const& inter)
{
  nbIntersections = nbIntersections + 1;
  double angle1 = inter.get_left();
  double angle2 = inter.get_right();

  std::list<Interval>::iterator it = interv.begin();
  
  /// case 1 : oriented interval
  if(angle1 <= angle2)
  {
    while(it != interv.end())
    {
      (*it).intersection(angle1, angle2);
      if((*it).isempty()){it = interv.erase(it);}else{++it;}
    }
  }
  else  /// case 2 : non-oriented interval
  {
    Interval currentInterval; 
    while(it != interv.end())
    {
      //copy
      currentInterval = *it;
      //first interval
      (*it).intersection(-M_PI, angle2);
      if((*it).isempty()){it = interv.erase(it);}else{++it;}
      //second interval
      currentInterval.intersection(angle1, M_PI);   
      if(!currentInterval.isempty()){interv.insert(it, currentInterval);}
    }
  }
}


std::list<Point> Intervals::buildPoints(Disk const& disk_t)
{
  std::list<Point> myList;
  std::list<Interval>::iterator it = interv.begin();

  double R = disk_t.get_radius();
  double theta;
  while(it != interv.end())
  {
    theta = (*it).get_left();
    if((theta != -M_PI) && (theta != M_PI))
    {myList.push_back(Point(disk_t.get_center1() + R*cos(theta), disk_t.get_center1() + R*sin(theta)));}
    theta = (*it).get_right();
    if((theta != -M_PI) && (theta != M_PI))
    {myList.push_back(Point(disk_t.get_center1() + R*cos(theta), disk_t.get_center1() + R*sin(theta)));}
    ++it;
  }
  return(myList);
}
