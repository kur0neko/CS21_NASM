/*
 * Customer.hpp
 *
 *  Created on: Oct 2, 2019
 *      Author: tienl
 */

#ifndef CUSTOMER_HPP_
#define CUSTOMER_HPP_

#include <iostream>

using namespace std;

class Customer {
public:

	//setter
	bool setID(int);
	bool setName(string);
	bool setAddress(string);
	bool setCity(string);
	bool setState(string);
	bool setZipCode(int);
	bool setAccountBalance(float);

	//getter
	int getID();
	string getName();
	string getAddress();
	string getCity();
	string getState();
	int getZipCode();
	float getAccountBalance();



	Customer();
	virtual ~Customer();

private:
	int ID;
	string Name;
	string Address;
	string City;
	string State;
	int ZipCode;
	float AccountBalance;
};

#endif /* CUSTOMER_HPP_ */
