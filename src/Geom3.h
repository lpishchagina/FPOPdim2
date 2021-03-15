#ifndef GEOM3_H
#define GEOM3_H

#include <iostream>
#include <vector>
#include <list>
#include <iterator>

#include "Disk.h"
#include "Rect.h"
#include "Cost.h"

//Class Geom3
//------------------------------------------------------------------------------
//Description of geometry "Geom3": 
//Geometry for FPOP-Algorithm in 2-dimension. 
//Parameters of geometry:"label_t" - moment of time, "disks_t_1" - list of disks(t-1)
//The updated geometry is a disk that approximates (disk at the moment t) minus (list of disks(t-1)) .
//Check for emptiness - the distance between the centers of the disks. 
//------------------------------------------------------------------------------
class Geom3{
private:
  int label_t;       //time moment 
  std::list<Disk> disks_t_1;  //list of disks(t-1)
  
public:
  Geom3();
  Geom3(unsigned int t);
  
  int get_label_t();
  std::list<Disk> get_disks_t_1();
  
  double Dist(double a1, double a2, double b1, double b2);
  
  void InitialGeometry(std::list<Disk> disks);
  void UpdateGeometry(Disk disk_t);
  bool EmptyGeometry();
};
#endif //GEOM3_H