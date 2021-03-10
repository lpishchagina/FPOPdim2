#ifndef GEOM1_H
#define GEOM1_H

#include <iostream>
#include <vector>
#include <list>

#include "Disk.h"
#include "Rect.h"
#include "Cost.h"

//Class Geom1
//-----------------------------------------------------------------------------------------------
//Description of geometry "Geom1": 
//Geometry for FPOP-Algorithm in 2-dimension. 
//Parameters of geometry: rectangle "rect t" - approximated set, "label_t" - moment of time
//The updated geometry is a rectangle that approximates the intersection of the rectangle and disK.
//Check for emptiness - correct rectangle coordinates. 
//-----------------------------------------------------------------------------------------------
class Geom1{
private:
  unsigned int label_t;                                 //time moment 
  Rect rect_t;                                          //approx rectangle
public:
  
  Geom1();
  Geom1(unsigned int t, std::list<Disk> disks);
 
  unsigned int get_label_t();
  Rect get_rect_t();
  std::list<Disk> get_disks_t_1();
  
  bool IsEmpty(); 
  void IntersectionD2(Disk disk); 
  
  void ExclusionD2(Disk disk){};
  void UpdateDisks(Disk disk_t){};
  
};

#endif //GEOM1_H
