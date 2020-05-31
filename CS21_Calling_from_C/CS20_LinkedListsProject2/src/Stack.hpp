/*
 * Stack.hpp
 *
 *  Created on: Oct 21, 2019
 *      Author: tienle
 */

#ifndef STACK_HPP_
#define STACK_HPP_

#include <iostream>
#include "LinkedList.hpp"

using namespace std;

class Stack: public LinkedList {
public:

	Stack(int);
	void push(Customer*);
	void pop(void);
	Customer* top(void);
	bool isEmpty(void);
	bool isFull(void);


	Stack();
	virtual ~Stack();

private:

	int maxStackSize;
	int stack;
	int stackTop;



};

#endif /* STACK_HPP_ */
