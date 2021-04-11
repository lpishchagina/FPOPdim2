#ifndef GEOM0_H
#define GEOM0_H

#include <iostream>
#include <vector>
#include <list>
#include <iterator>

#include "Disk.h"
#include "Rect.h"
#include "Cost.h"

//Class Geom0
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
class Geom0
{
  private:
    unsigned int label_t;       //time moment 
    
  public:
    Geom0();
    Geom0(unsigned int t);
    
    unsigned int get_label_t() const;
    
    void InitialGeometry(unsigned int i, const std::list<Disk> &disks);
    void UpdateGeometry(const Disk &disk_t);
    bool EmptyGeometry();
};
#endif //GEOM0_H