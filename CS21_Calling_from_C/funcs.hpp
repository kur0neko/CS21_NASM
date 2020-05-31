#ifndef FUNCS_HPP_
#define FUNCS_HPP_

#include <iostream>

using namespace std;


extern "C"{
	
	int addTwo(int a, int b);
	
	int addArray(int a[], int size);
	
	int pow2(int a);
	
	int multiplyTwo(int a, int b);
	
	void revArray(int a[], int b[],int size);
	
	void addTwoArray(int a[],int b[],int c[], int size);

}

//extern "C" {int addArray(int a[], int size);}

//extern "C" {int pow2(int a);}

//extern "C" {int multiplyTwo(int a, int b);}

//extern "C" {int revArray(int a[], int b[],int size);}




#endif /* FUNCS_HPP_*/
