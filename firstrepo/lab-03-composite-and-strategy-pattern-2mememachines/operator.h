#ifndef __OPERATOR_H__
#define __OPERATOR_H__

#include "component.h"
#include <cstddef>

using namespace std;

class composite: public Base {
  protected: 
    Base* left=NULL;
    Base* right=NULL;
  public: 
    virtual double evaluate() = 0;

};
#endif
