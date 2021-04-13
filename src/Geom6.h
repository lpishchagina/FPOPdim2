#ifndef GEOM6_H
#define GEOM6_H

#include <iostream>
#include <vector>
#include <list>
#include <iterator>

#include "Disk.h"
#include "Point.h"
#include "Intervals.h"

//Class Geom6
//------------------------------------------------------------------------------
//Description of geometry "Geom6": 
//------------------------------------------------------------------------------
class Geom6
{
  private:
    unsigned int label_t;       //time moment 
    std::list<Disk> disks_t_1;  //list of disks(t-1)
    bool fl_empty;
    
  public:
    Geom6();
    Geom6(unsigned int t);
    
    unsigned int get_label_t() const;
    std::list<Disk> get_disks_t_1() const;
    
    double distance(double a1, double a2, double b1, double b2);
    
    void InitialGeometry(unsigned int i, std::list<Disk> const& disks);
    void UpdateGeometry(Disk const& disk_t);
    bool EmptyGeometry();
};
#endif //GEOM6_H