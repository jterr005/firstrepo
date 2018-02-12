#ifndef __ROOT_H__
#define __ROOT_H__

#include "operator.h"

class Sqr : public composite  {
  public:
   double evaluate();
   Sqr(Base* left);
};

#endif


