#ifndef INTERVAL_H
#define INTERVAL_H

#include "Disk.h"
#include "math.h"
#include <iostream>

using namespace std;

class Interval
{
  private:
    double left;                     
    double right;
    
  public:
    Interval(){};
    Interval(double newL, double newR): left(newL), right(newR){}
    double get_left() const {return left;};
    double get_right() const {return right;};
    bool isempty() const {return(left >= right);};
    void intersection(double a, double b)
    {
      if(left < a){left = a;}
      if(b < right){right = b;}
    };
    
    void Interval_intersection(Disk const& disk, Disk  const& diskEx)
    {
      double a = diskEx.get_center1() - disk.get_center1();
      double b = diskEx.get_center2() - disk.get_center2();
      double U2 = a*a + b*b;
      double RP = diskEx.get_radius() + disk.get_radius();
      double RM = diskEx.get_radius() - disk.get_radius();
      double c = RP*RM - U2;
      double d = sqrt((RP*RP - U2)*(U2 - RM*RM));
      double theta = atan2(b,a);
      double thetaPM = abs(atan2(d,c)); //always > 0
      left = theta - thetaPM;
      right = theta + thetaPM;
      if(left < -M_PI){left = left + 2*M_PI;}
      if(right > M_PI){right = right - 2*M_PI;}
    };
    
    void symmetry()
    {
      double temp = left;
      left = right;
      right = temp;
    };
};

#endif //INTERVAL_H