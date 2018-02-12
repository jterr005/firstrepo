#include <iostream>
#include <vector>
#include "selection_sort.h"
#include "container.h"
#include "strategy.h"

using namespace std;

SelectionSort::SelectionSort() {}

void SelectionSort::sort(Container* container) {

//YOU NEED TO ADJUST VARIABLES FROM ARRAY TO VECTOR	
	int i, j, min_idx;
        for (i = 0; i < container->size()- 1; i++) {
        	min_idx = i;
                for (j = i+1; j < container->size(); j++) {
                	if (container->at(j)->evaluate() < container->at(min_idx)->evaluate()) {
                        	min_idx = j;
	 		}
                        }  
			container->swap(i, min_idx);                                  
              		//new Base* temp = 0;
              		//temp = container->at(j);
              		//container->at(j) = container->at(min_idx);
               		//container->at(min_idx) = temp;

		
	}
}
                                                                                 
