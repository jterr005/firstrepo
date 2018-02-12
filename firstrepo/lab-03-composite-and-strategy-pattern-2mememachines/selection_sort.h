#ifndef _SELECTIONSORT_H__
#define _SELECTIONSORT_H__

#include <vector>
#include "strategy.h"
using namespace std;

class SelectionSort : public Sort {
	public:
		SelectionSort();
		void  sort(Container* container);
};

#endif
