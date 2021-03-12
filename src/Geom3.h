#ifndef GEOM3_H
#define GEOM3_H

#include <iostream>
#include <vector>
#include <list>

#include "Disk.h"
#include "Rect.h"
#include "Cost.h"

//Class Geom3
//---------------------------------------------------------------------------------------------------
//Description of geometry "Geom3": 
//Geometry for FPOP-Algorithm in 2-dimension. 
//Parameters of geometry:"label_t" - moment of time, "disks_t_1" - list of disks(t-1)
//The updated geometry is a disk that approximates (disk at the moment t) minus (list of disks(t-1)) .
//Check for emptiness - the distance between the centers of the disks. 
//---------------------------------------------------------------------------------------------------

class Geom3{
  
private:
  unsigned int label_t;                                 //time moment 
  std::list<Disk> disks_t_1;                            //list of disks(t-1)
  
public:
  Geom3();
  Geom3(unsigned int t, std::list<Disk> disks);

  unsigned int get_label_t();
  std::list<Disk> get_disks_t_1();
  
  bool IsEmpty();
  void IntersectionD2(Disk disk){};             
  void ExclusionD2(Disk disk){};                 
  void UpdateDisks(Disk d);

};

#endif //GEOM3_H
