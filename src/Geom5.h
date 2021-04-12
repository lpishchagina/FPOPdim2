#ifndef GEOM5_H
#define GEOM5_H

#include <iostream>
#include <vector>
#include <list>
#include <iterator>

#include "Cost.h"
#include "Disk.h"
#include "Point.h"
#include "Intervals.h"

//Class Geom5
//------------------------------------------------------------------------------
//Description of geometry "Geom5": 
//------------------------------------------------------------------------------
class Geom5
{
  private:
    unsigned int label_t;       //time moment 
    std::list<Disk> disks_t_1;  //list of disks(t-1)
    std::list<Disk> disks_inter;  //list of intersection disks
    std::list<Point> FrontierPoints;  //list of intersection disks
    bool fl_empty;
    
  public:
    Geom5();
    Geom5(unsigned int t);
    
    unsigned int get_label_t() const;
    std::list<Disk> get_disks_t_1() const;
    
    double distance(double a1, double a2, double b1, double b2);
    
    void InitialGeometry(unsigned int i, std::list<Disk> const& disks);
    void UpdateGeometry(Disk const& disk_t);
    bool EmptyGeometry();
};
#endif //GEOM5_H