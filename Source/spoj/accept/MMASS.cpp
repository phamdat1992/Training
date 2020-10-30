#include <iostream>
#include <stack>

using namespace std;

void tinh( stack< int > &a ) {

	int t = 0;
	int s = 0;

	do {

		t = a.top();
		s +=t;

		a.pop();

	} while( t != 0 );

	a.push(s);
}

int main(  ) {

	stack< int > a;
	char c;

	a.push(0);

	while( cin>>c ) {

		switch( c ) {

			case '(':	a.push(0);
					break;

			case ')':	tinh( a );
					break;

			case 'C':	a.push(12);
					break;

			case 'H':	a.push(1);
					break;

			case 'O':	a.push(16);
					break;

			default:	if( c >= '0' && c <= '9' ) {

						int t = a.top();
						a.pop();
						a.push( t*( c - '0' ) );
					}
		};
	}

	tinh( a );
	cout<<a.top();
}