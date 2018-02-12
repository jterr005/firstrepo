#include <iostream>
#include "operator.h"
#include "VectorContainer.h"
//#include "list_container.h"
#include "strategy.h"
#include "op.h"
#include "multi.h"
#include "sub.h"
#include "add.h"
#include "root.h"
#include "component.h"
#include "container.h"
#include "selection_sort.h"

using namespace std;

int main() {
    Op* op1 = new Op(5);
    //cout << op1->evaluate() << endl;
    Op* op2 = new Op(2);
    Op* op3 = new Op(4);
    Op* op4 = new Op(6);
    Mult* A = new Mult(op1, op2);
    Sub* B = new Sub(op3, op4);
    Add* C = new Add(A, B);
    Sqr* D = new Sqr(C);
    //cout << D->evaluate() << endl;

   VectorContainer* container = new VectorContainer();
   //ListContainer* container = new ListContainer();
    container->add_element(A);
    container->add_element(B);
    container->add_element(C);
    container->add_element(D);
    cout << "Container Before Sort: " << endl;
    container->print();
    container->set_sort_function(new SelectionSort());
    container->sort();	
    cout << "Container After Sort: " << endl;
    container->print();
};
