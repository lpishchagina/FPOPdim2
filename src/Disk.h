#ifndef DISK_H
#define DISK_H

#include <vector>


//Class Disk
//-----------------------------------------------------------------------------
class Disk{
private:
  double center1;                           // coordinates of center
  double center2;  
  double radius;                                        // radius

public:
  Disk();
  Disk(double c1, double c2, double r);

  double get_radius();
  double get_center1();
  double get_center2();
}; 

#endif //DISK_H