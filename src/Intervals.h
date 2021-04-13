#ifndef INTERVALS_H
#define INTERVALS_H

#include <vector>
#include "Interval.h"
#include "Point.h"
#include "Disk.h"
#include <list>
#include <iterator>

class Intervals
{
  private:
    std::list<Interval> interv;
    unsigned int nbIntersections;
    
  public:
    Intervals(){interv.push_back(Interval(-M_PI, M_PI)); nbIntersections = 0;};
    bool isempty(){return(interv.empty());};
    void intersection(Interval const& inter);
    unsigned int get_nbIntersections(){return nbIntersections;};
    unsigned int get_length(){return interv.size();};
    std::list<Point> buildPoints(Disk const& disk_t);
    void print();
}; 

#endif //INTERVALS_H
