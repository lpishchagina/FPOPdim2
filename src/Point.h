#ifndef POINT_H
#define POINT_H

class Point
{
  private:
    double x;                     
    double y;
    
  public:
    Point(){};
    Point(double newX, double newY): x(newX), y(newY){}
    double get_x(){return x;};
    double get_y(){return y;};
};

#endif //POINT_H