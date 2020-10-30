#include <iostream>
#include <conio.h>
#include <math.h>

using namespace std;

struct node
{
	float info;
	node *np;
};
float get_number(int &i,char string[]);
void get_operators(int &i,char string[],char &operators);
bool check_operators(int &i,char string[],int &length,char &operators);
void input(char string[]);
void add_sub(node *&point, node *&tail, char ope);
void mult_div(node *&point, node *&tail, char ope);
void insert_number(float number,node *point,char operators);
void calculate(char ope,node *&flagl,node *&tail);
void solution(int &i,char string[],int length, node *&tail);