#include "sub.h"

using namespace std;

Sub::Sub(Base* left, Base* right) {
	this->left = left;
	this->right = right;
}
double Sub::evaluate() {
	double LS = left->evaluate();
	double RS = right->evaluate();

	return (LS - RS);
}
