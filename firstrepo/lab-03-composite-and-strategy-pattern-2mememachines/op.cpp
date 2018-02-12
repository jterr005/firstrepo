#include <iostream>
#include "op.h"

using namespace std;

Op::Op(int i){
this->op = i;
return;
}
double Op::evaluate(){
return this->op;
}
