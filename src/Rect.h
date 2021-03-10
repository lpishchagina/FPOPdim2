#ifndef RECT_H
#define RECT_H

#include "math.h"
#include "Disk.h"

#include <vector>


// Class Rect
//------------------------------------------------------------------------------
class Rect{
private:
  double rectx0;                        // coordinates of the bottom left vertex 
  double recty0;
  double rectx1;                        // coordinates of the top right vertex
  double recty1;
public:
  
  Rect();
  Rect(double x0, double y0, double x1, double y1);

  double get_rectx0();
  double get_recty0();
  double get_rectx1();
  double get_recty1();

  double min_ab(double a, double b);
  double max_ab(double a, double b);

  bool IsEmpty_rect();
  void Exclusion_disk(Disk disk);
  void Intersection_disk(Disk disk);
  

};

#endif //RECT_H