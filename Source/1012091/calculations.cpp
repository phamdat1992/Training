#include "calculations.h"

float get_number(int &i,char string[])
{
	float temp=0;
	
	while( string[i] >= '0' && string[i] <='9' )
		temp=temp*10+string[i++]-48;
	return temp;
}

void get_operators(int &i,char string[],char &operators)
{
	operators='+';

	while( string[i] == '+' || string[i] == '-' )
	{
		if(operators == '-' && string[i] == '-' )
			operators='+';
		else
			operators=string[i];
		i++;
	}
}

bool check_operators(int &i,char string[],char &operators)
{	
	while( string[i]==' ' ) i++;
	
	
	switch(string[i])
	{
		case '(':
		case ')':
		case '*':
		case '/':operators=string[i++];
				return true;
		case '+':
		case '-':if(i-1>=0)
				 {
					if(string[i-1]=='(')
						return true;
					operators=string[i++];
				 }
				return true;
		default:if(string[i]>='0' && string[i]<='9') return NULL;//incorrect_data!
	}
	return true;
}

void input(char string[])
{
	cout<<"Nhap Vao Bieu Thuc : ";
	cin>>string;
}

void add_sub(node *&point, node *&tail, char ope)
{
	point->info = point->info + (ope=='+' ? 1:-1)*point->np->info;
	delete tail;
	tail=point;	
}

void mult_div(node *&point, node *&tail, char ope)
{
	point->info = point->info * pow(point->np->info,(ope=='*' ? 1:-1));
	delete tail;
	tail=point;
}

void insert_number(float number,node *point,char operators)
{
	if(operators=='-')
		number=-number;
	point->info=number;
}

void calculate(char ope,node *&flag1,node *&tail)
{
	switch (ope)
	{
		case '+':
		case '-':add_sub(flag1,tail,ope);
				break;
		case '*':
		case '/':mult_div(flag1->np,tail,ope);
	}
}

void solution(int &i,char string[],int length, node *&tail)
{
	node *flag1=tail=new node;
	tail->info=0;
	char ope='+',temp_ope=NULL,operators='+',h=NULL;
	bool check_ope;

	do
	{
		if(check_ope=check_operators(i,string,h))
		{
			if(h!='(')
			{
				if(h!=')')
				{
					temp_ope=h;
					get_operators(i,string,operators);
				}
			}
			else
			{
				solution(i,string,length,tail->np);
				tail=tail->np;
				insert_number( tail->info , tail , operators );
				check_ope=0;
			}
		}
		else
			insert_number( get_number(i,string),tail=tail->np=new node,operators );

		if(check_ope || ope=='*' || ope=='/')
		{
			switch (temp_ope)
			{
				case '*':
				case '/':ope=ope^=temp_ope^=ope^=temp_ope;
					h=temp_ope;
					break;
				case '+':
				case '-':calculate(ope,flag1,tail);
						ope=temp_ope;
						break;
			}
		}
	}
	while(length != i &&  string[i]!= ')');
	i++;
	calculate(ope,flag1,tail);
}