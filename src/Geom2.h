#ifndef GEOM2_H
#define GEOM2_H

#include <iostream>
#include <vector>
#include <list>

#include "Disk.h"
#include "Rect.h"
#include "Cost.h"

//Class Geom2
//------------------------------------------------------------------------------------------------------------------------
//Description of geometry "Geom2": 
//Geometry for FPOP-Algorithm in 2-dimension. 
//Parameters of geometry: rectangle "rect t" - approximated set, "label_t" - moment of time, "disks_t_1" - list of disks(t-1)
//The updated geometry is a rectangle that approximates (the intersection of the rectangle and disk at the moment t) minus (list of disks(t-1)) .
//Check for emptiness - correct rectangle coordinates. 
//------------------------------------------------------------------------------------------------------------------------

class Geom2{
private:
  int label_t;                                 //time moment 
  Rect rect_t;                                          //approx rectangle
  std::list<Disk> disks_t_1;                            //list of disks(t-1)
  
public:
  Geom2();
  Geom2(unsigned int t);
  
  int get_label_t();
  Rect get_rect_t();
  std::list<Disk> get_disks_t_1();

  void InitialGeometry(std::list<Disk> disks);
  void UpdateGeometry(Disk disk_t);
  bool EmptyGeometry();
};
#endif //GEOM2_H
