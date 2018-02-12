#ifndef __OP_H__
#define __OP_H__

#include "component.h"

using namespace std;

class Op : public Base {
  public:
   	int op;
	Op(int i);
	double evaluate();
};
#endif

