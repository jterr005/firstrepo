#ifndef __MULTI_H__
#define __MULTI_H__

#include "operator.h"

class Mult : public composite  {
  public:
   double evaluate();
   Mult(Base* left, Base* right);
};

#endif

