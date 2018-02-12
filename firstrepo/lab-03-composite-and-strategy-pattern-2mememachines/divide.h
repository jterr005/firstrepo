#ifndef __DIVIDE_H__
#define __DIVIDE_H__

#include "operator.h"

class Divide :public composite {
	  public:
	double evaluate();
	Divide(Base* left, Base* right);  

};
#endif
