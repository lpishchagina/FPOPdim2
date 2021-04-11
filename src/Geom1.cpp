#include "Cost.h"
#include "Disk.h"
#include "Rect.h"
#include "Geom1.h"

#include <math.h>
#include <iostream>
#include <list>
#include <Rcpp.h>

using namespace Rcpp;
using namespace std;

//accessory*********************************************************************
unsigned int Geom1::get_label_t() const {return label_t;}

Rect Geom1::get_rect_t() const {return rect_t;}

std::list<Disk> Geom1::get_disks_t_1() const
{
  std::list<Disk> list_NULL;
  list_NULL.clear();
  return list_NULL;
}

//InitialGeometry***************************************************************
void Geom1::InitialGeometry(unsigned int i, const std::list<Disk> &disks)
{ 
  label_t = i;
  rect_t = Rect();
}

//UpdateGeometry****************************************************************
void Geom1::UpdateGeometry(const Disk &disk_t){rect_t.Intersection_disk(disk_t);}

//EmptyGeometry*****************************************************************
bool Geom1::EmptyGeometry(){return rect_t.IsEmpty_rect();}

//******************************************************************************
