#include "root.h"

using namespace std;

Sqr::Sqr(Base* left) {
        this->left = left;
        this->right = 0;
}

double Sqr::evaluate() {
        double LS = left->evaluate();

        return (LS * LS);
}

