#include <iostream>
#include <vector>
#include <stdexcept>
#include "VectorContainer.h"
#include "strategy.h"

using namespace std;

VectorContainer::VectorContainer() : Container() {}

VectorContainer::VectorContainer(Sort* function) : Container(function){}

void VectorContainer::add_element(Base* element) {
	vectorList.push_back(element);
return;
}


void VectorContainer::print() {
	unsigned i = 0;
	while(vectorList.size() > i) {
		cout << vectorList.at(i)->evaluate() << " ";
		++i;
	}
return;
}

void VectorContainer::sort() {
try {
	if(sort_function == NULL) {
		throw invalid_argument("Sort function is not set");
	}
}
catch (string e) {
	cout << "FAIL" << e << endl;
}
this->sort_function->sort(this);  
}
	
	
void VectorContainer::swap(int i, int j){
	Base*  temp;
	// potentioal 
	temp = vectorList.at(i);
	vectorList.at(i) = vectorList.at(j);
	vectorList.at(j) = temp;
	return;
}

Base* VectorContainer::at(int i){
	return vectorList.at(i);
}

int VectorContainer::size(){
	return vectorList.size();
}
