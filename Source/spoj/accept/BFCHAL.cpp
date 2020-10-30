#include <iostream>
#include <string>

using namespace std;

void input( string &s ) {

	getline( cin, s );
}

void output( string kq ) {

	cout<<kq;
}

string solved( string &a ) {

	int len = a.length();

	for( int i = 0; i < len; ++i ) {

		if( a[i] >= 'a' && a[i] <= 'z' ) {

			a[i] -= 32;
		}
	}

	return a;
}

int main(  ) {

	string s;
	
	input( s );
	output( solved( s ) );
}