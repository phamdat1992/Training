#include "calculations.h"

void main()
{
	node *tail;
	char string[2001];
	input(string);
	int i=0;
	solution(i,string,strlen(string),tail);
	cout<<tail->info;
	delete(tail);
	getch();
}