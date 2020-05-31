/*
 * Customer.cpp
 *
 *  Created on: Oct 2, 2019
 *      Author: tienl
 */

#include "Customer.hpp"


Customer::Customer() {
	// TODO Auto-generated constructor stub
	Name = "";
	Address = "";
	City = "";
	State = "";
	AccountBalance = 0;

}

//Mutators (setters)

bool Customer::setID(int id)
{
	if (id < 0)
	{
		return false;

	}
	else
	{
		this->ID = id;
		return true;
	}
}

bool Customer::setName(string n)
{
	if (n.length() < 0)
	{
		return false;
	}
	else
	{
		this->Name = n;
		return true;
	}

}

bool Customer::setAddress(string addy)
{
	if (addy.length() < 0)
	{
		return false;
	}
	else
	{
		this->Address = addy;
		return true;
	}

}

bool Customer::setCity(string c)
{
	if (c.length() < 0)
	{
		return false;
	}
	else
	{
		this->City = c;
		return true;
	}
}

bool Customer::setState(string s)
{
	if (s.length() < 0)
	{
		return false;
	}
	else
	{
		this->State = s;
		return true;
	}
}

bool Customer::setZipCode(int z)
{
	if (z < 0)
	{
		return false;
	}
	else
	{
		this->ZipCode = z;
		return true;
	}
}

bool Customer::setAccountBalance(float a)
{
	if (a < 0)
	{
		return false;
	}
	else
	{
		this->AccountBalance = a;
		return true;
	}
}

//Accessor (getter)

int Customer::getID()
{
	return this->ID;
}

string Customer::getName()
{
	return this->Name;
}

string Customer::getAddress()
{
	return this->Address;
}

string Customer::getCity()
{
	return this->City;
}

string Customer::getState()
{
	return this->State;
}

int Customer::getZipCode()
{
	return this->ZipCode;
}

float Customer::getAccountBalance()
{
	return this->AccountBalance;
}

Customer::~Customer() {
	// TODO Auto-generated destructor stub
}

