//============================================================================
// Name        : testtt.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <iomanip>
#include <cstdlib>
#include "funcs.hpp"
using namespace std;



int main() {
	//addTwo function
	cout<<"##############################################"<<endl;
	cout<<"Welcome to my addition program!! "<<endl;
	cout<<"##############################################"<<endl;
	int ret= addTwo(10,20); //return value in always in eax
	cout<<"The addtion of the two parameters is: "<<ret<<endl;

	//addArray	
			
	int totalInArray=0;				//The size of the array -to be entered by the user
	int arrayTotal=0;				//The result if the array addtion
	
	cout<<endl;
	cout<<"Add array function!"<<endl;
	cout<<"Please enter the size of the array you would like to create: ";
	cin>> totalInArray;
	
	int*myIntegers = new int[totalInArray]; 	//Allocate our dynamic array
	
	
	for(int i=0; i < totalInArray;i++){       //Fill the array with simple integer data
		
		myIntegers[i]=i;
		
		}//for 
		
		//Call the addArray assembly function sending the pointer to the array and size of the array
		
		arrayTotal= addArray(myIntegers,totalInArray);   //The return value is always in eax
		
		cout<<"The addition of the array contents is: "<<arrayTotal<<endl;
		
		delete myIntegers;
		
		cout<<endl;
		
		cout<<"Welcome to Pow 2 function!"<<endl;
		
		
		int numb=10;
		
		int result= pow2(numb);
		
		cout<<"The number that input in pow2 function is "<<numb<<endl;
		cout<<"The result of "<<numb<<" Pow 2 is "<<result<<endl;
		
		
		int numOne=0;
		int numTwo=0;
		
		
		cout<<"Multiply two numbers!"<<endl;
		
		cout<<"Plese enter your first number: ";
		cin>>numOne;
		
		cout<<"Please enter your second number: ";
		cin>>numTwo;
		
		int resultMulti= multiplyTwo(numOne,numTwo);
		
		cout<<"The result of "<<numOne<<" * "<<numTwo<< " is "<<resultMulti<<endl;
		
		
		const int MAX_SIZE=5;

		
		int*arrayOne= new int[MAX_SIZE];
		int*arrayTwo= new int[MAX_SIZE];
	
		
		for(int i=0; i < MAX_SIZE;i++){      
		
		arrayOne[i]=i;
		
		}//for 
		
		
		 
		revArray(arrayOne,arrayTwo,MAX_SIZE);
		 
		 
		 for(int i=0; i < MAX_SIZE;i++){
			 
			 
			 cout<<arrayTwo[i]<<endl;
			 
			 }
			 
			 delete arrayOne;
			 delete	arrayTwo;
			 
		
		int*arryA= new int[MAX_SIZE];
		int*arryB= new int[MAX_SIZE];
		int*arryC= new int[MAX_SIZE];
		
		for(int i=0; i < MAX_SIZE;i++){      
		
		arryA[i]=i;
		
		}//for 
		
		for(int i=0; i < MAX_SIZE;i++){      
		
		arryB[i]=i;
		
		}//for 
		
		
		
		addTwoArray(arryA,arryB,arryC,MAX_SIZE);
		
		for(int i=0; i < MAX_SIZE;i++){      
		
		cout<<arryC[i]<<endl;
		
		}//for 
		
		
		
		
		
		
		
		
			 
			 
		
		
		
		
		
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	return 0;
} //main

