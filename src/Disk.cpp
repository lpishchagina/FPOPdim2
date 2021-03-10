#include "Disk.h"
#include "math.h"
#include<iostream>
#include <vector>

using namespace std;


Disk::Disk(){
  center1 = 0;    // coordinates of center
  center2 = 0;
  radius = 0;        // radius
}
Disk::Disk(double c1,double c2, double r){
  center1 = c1; 
  center2 = c2; 
  radius = r;  
}

double Disk::get_radius() {return radius;}

double Disk::get_center1(){return center1;}
double Disk::get_center2(){return center2;}
