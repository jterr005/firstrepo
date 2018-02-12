#ifndef __ADD_H__
#define __ADD_H__

#include "operator.h"

class Add : public composite  {
  public:
   double evaluate();
   Add(Base* left, Base* right);
};

#endif

