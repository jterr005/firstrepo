#include "divide.h"                                                                                                    
using namespace std;                                                                                                  

Divide::Divide(Base* left, Base* right) {
	 this->left = left;
	 this->right = right;
}
double Divide::evaluate() {
	 double LS = left->evaluate();
	 double RS = right->evaluate();
	 return (LS * RS);
}
