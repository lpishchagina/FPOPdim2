#include "Intervals.h"
#include "math.h"
#include<iostream>
#include <iterator>
#include <list>

using namespace std;



void Intervals::intersection(Interval const& inter)
{
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
  
  while(it != interv.end())
  {
    myList.push_back(Point(disk_t.get_center1() + R*cos((*it).get_left()), disk_t.get_center1() + R*sin((*it).get_left())));
    myList.push_back(Point(disk_t.get_center1() + R*cos((*it).get_right()), disk_t.get_center1() + R*sin((*it).get_right())));
    ++it;
  }
  return(myList);
}
