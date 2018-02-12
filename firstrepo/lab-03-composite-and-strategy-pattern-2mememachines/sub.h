#ifndef __SUB_H__
#define __SUB_H__

#include "operator.h"
 
class Sub : public composite  {
  public:
   double evaluate();
   Sub(Base* left, Base* right);

};

#endif
