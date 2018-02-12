#include "add.h"

using namespace std;

Add::Add(Base* left, Base* right) {
        this->left = left;
        this->right = right;
}
double Add::evaluate() {
        double LS = left->evaluate();
        double RS = right->evaluate();

        return (LS + RS);
}

