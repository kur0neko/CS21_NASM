/*
 * Stack.cpp
 *
 *  Created on: Oct 21, 2019
 *      Author: tienle
 */

#include "Stack.hpp"

Stack::Stack() {
	// TODO Auto-generated constructor stub
	this->maxStackSize = 100;
	this->stackTop = 0;

}

Stack::Stack(int x)
{

}

void Stack::push(Customer* customerData)
{
	if (isFull() == true || customerData == nullptr)
	{
		throw "Error. Can't add another data";
	}
	else
	{
		this->stackTop++;
		LinkedList::push_back(customerData);
	}
}

void Stack::pop(void)
{
	if (isEmpty() == true)
	{
		throw "Error. The list is empty";
	}
	else
	{
		this->stackTop++;
		LinkedList::pop_back();
	}


}

Customer* Stack::top(void)
{
	if (isEmpty() == true)
	{
		throw "Error. The list is empty";
	}
	else
	{

	}
}

bool Stack::isEmpty(void)
{
	if (this->stackTop == 0)
	{
		return true;
	}
	else
	{
		return false;
	}
}

bool Stack::isFull(void)
{
	if (this->stackTop == this->maxStackSize)
	{
		return true;
	}
	else
	{
		return false;
	}
}

Stack::~Stack() {
	// TODO Auto-generated destructor stub
}

