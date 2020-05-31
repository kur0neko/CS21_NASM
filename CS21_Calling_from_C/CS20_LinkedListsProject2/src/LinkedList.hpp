/*
 * LinkedList.hpp
 *
 *  Created on: Oct 7, 2019
 *      Author: tienle
 */

#ifndef LINKEDLIST_HPP_
#define LINKEDLIST_HPP_

#include <iostream>
#include "Customer.hpp"

using namespace std;


class LinkedList {
public:
	struct Node
	{
		Customer* data;
		Node* next;
	};

	void push_back(Customer* );
	void push_front(Customer* );
	int size(void);
	void delete_list (void);
	void print_list (void);
	Customer* pop_front (void);
	Customer* pop_back (void);
	Customer* find (int ID);
	bool exists (int ID);
	bool deleteIt (int ID);

	LinkedList();
	virtual ~LinkedList();

private:
	Node* head;
	void push_backRecursive(Customer* ,Node*&);
	int sizeRecursive(Node*);
	void print_listRecursive(Node*);
	Customer* pop_backRecursive (Node*);
	bool existsRecursive(Node*&,int);



};

#endif /* LINKEDLIST_HPP_ */
