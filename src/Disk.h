#ifndef DISK_H
#define DISK_H

#include <vector>
/*
 Class Disk
 -------------------------------------------------------------------------------
 Description: 
 Disk in 2-dimension. 
 
 Parameters:
 "(center1, center2)"  - the disk  center coordinates;
 "radius" - the value of the disk radius.
 -------------------------------------------------------------------------------
 */
class Disk{
private:
  double center1;                           
  double center2;  
  double radius;                                     

public:
  Disk(){};
  Disk(double c1, double c2, double r):center1(c1), center2(c2), radius(r){}  

  double get_radius();
  double get_center1();
  double get_center2();
}; 

#endif //DISK_H
//------------------------------------------------------------------------------