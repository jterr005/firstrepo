#include "multi.h"

using namespace std;

Mult::Mult(Base* left, Base* right) {
        this->left = left;
        this->right = right;
}
double Mult::evaluate() {
        double LS = left->evaluate();
        double RS = right->evaluate();

        return (LS * RS);
}

