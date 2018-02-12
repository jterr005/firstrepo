#ifndef __VECTORCONTAINER_H__
#define __VECTORCONTAINER_H__

//#include <vector>
#include "container.h"
#include "component.h"
#include <vector>

class VectorContainer : public Container {
	public:
		std::vector<Base*> vectorList;
		VectorContainer();
		VectorContainer(Sort* function);
		void add_element(Base* element);
		void print();
		void sort();
		void swap(int i, int j);
		Base* at(int i);
		int size();
};
#endif
