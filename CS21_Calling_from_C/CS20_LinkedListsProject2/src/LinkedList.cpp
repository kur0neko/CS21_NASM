/*
 * LinkedList.cpp
 *
 *  Created on: Oct 7, 2019
 *      Author: tienle
 */

#include "LinkedList.hpp"


LinkedList::LinkedList() {
	// TODO Auto-generated constructor stub
	head = nullptr;

}

void LinkedList::push_back(Customer* customerData)
{
	if (customerData == nullptr)
	{
		return;
	}
	else
	{
		push_backRecursive(customerData,head);			//wrapper function
	}

}

void LinkedList::push_backRecursive(Customer* customerData, Node* &node)
{
	if (node == nullptr)
	{
		node = new Node;
		node->data = customerData;
		node->next = nullptr;
	}
	else
	{
		push_backRecursive(customerData, node->next);
	}

}




void LinkedList::push_front(Customer* b)
{


	Node* newNode = new Node;
	newNode->data = b;
	newNode->next = head;
	head = newNode;

}

int LinkedList::size(void)
{
	// Base case
	    if (head == nullptr)
	    {
			return 0;
	  	}
	    else{
			return sizeRecursive(head);
	    }

}

int LinkedList::sizeRecursive(Node* node)
{
	if (node->next == nullptr)
	{
		return 1;
	}
	   // count is 1 + count of remaining list
	else
	{
		return 1 + sizeRecursive(node->next);
	}

}

void LinkedList::delete_list(void)
{
	while(head != nullptr)
	{
		delete pop_front();
	}
}


void LinkedList::print_list(void)
{
    if (head == nullptr)
    {
		return;
  	}
    else
    {
    	cout << "Printing customer: " << endl;
		return print_listRecursive(head);
    }

}

void LinkedList::print_listRecursive(Node* currentNode)
{
	if(currentNode == nullptr)
	{
		cout << "End of list" << endl;
		return;
	}
	else
	{
		cout << currentNode->data->getID() << " ";
		cout << currentNode->data->getName() << " ";
		cout << currentNode->data->getAddress() << " ";
		cout << endl;
		print_listRecursive(currentNode->next);
		return;
	}
}

Customer* LinkedList::pop_front(void)
{
	if(head == nullptr)
	{
		return nullptr;
	}
	else
	{
		Node* tempNode;
		Customer* tempCust;
		tempNode = head;
		head = head->next;
		tempCust = tempNode->data;
		tempNode->data = nullptr;
		tempNode->next = nullptr;
		delete tempNode;
		tempNode = nullptr;
		return tempCust;
	}


}

Customer* LinkedList::pop_back (void)
{
	if (head == nullptr)
	{
		return nullptr;
	}
	else if (head->next == nullptr)
	{
		//Node* tempNode;
		//tempNode = head;
		Customer* tempCust;
		tempCust = head->data;

		//head = nullptr;
		head->data = nullptr;
		delete head;
		return tempCust;
	}
	else
	{
		return pop_backRecursive(head);
	}



}

Customer* LinkedList::pop_backRecursive(Node* node)
{
	if (node->next->next == nullptr)
	{
		Node* tempNode;
		Customer* tempCust;
		tempNode = node->next;
		tempCust = tempNode->data;
		node->next = nullptr;
		delete tempNode;
		tempNode = nullptr;
		return tempCust;
	}
	else
	{
		return pop_backRecursive(node->next);
	}
}

Customer* LinkedList::find(int idInfo)
{
	Node* currentNode;

	currentNode = head;
	while(currentNode != nullptr)
	{
		if(currentNode->data->getID() == idInfo)
		{
			return currentNode->data;
		}
		else
		{
			currentNode = currentNode->next;
			return currentNode->data;
		}
	}
	return nullptr;
}




bool LinkedList::exists(int idInfo)
{
	bool check = false;
	check = existsRecursive(head, idInfo);

	return check;

}

bool LinkedList::existsRecursive(Node*& node, int idInfo)
{
	if(node == nullptr)
	{
		return false;
	}
	else if (idInfo == node->data->getID())
	{
		return true;
	}
	else
	{
		existsRecursive(node->next, idInfo);
	}


}

bool LinkedList::deleteIt(int ID)
{
	if(exists(ID) == true)
	{

		if(head->data->getID() == ID)
		{
			delete pop_front();
			return true;
		}//if2
		else
		{
			Node* currentNode = head; //iterator
			Node* tempNode;
			while(currentNode->next !=nullptr)
			{
				if (currentNode->next->data->getID() == ID)
				{
					tempNode = currentNode->next;
					currentNode->next = currentNode->next->next;
					delete tempNode->data;
					tempNode->data = nullptr;
					tempNode->next = nullptr;
					delete tempNode;
					return true;
				}//if3
				else
				{
					currentNode = currentNode->next;
				}//else3
			}//while
		}//else2
	}//if1

	return false;
}



LinkedList::~LinkedList() {
	// TODO Auto-generated destructor stub
	delete_list();
}

