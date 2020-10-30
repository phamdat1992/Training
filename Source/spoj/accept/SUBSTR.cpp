#include <iostream>
#include <string>

using namespace std;

void input( string &a, string &b ) {

	getline( cin, a );
	getline( cin, b );
}

void init( string &b, int len, int* t ) {

	int i = 0;
	int j = -1;

	t[0] = -1;

	while ( i < len ) {

		for( ; j > -1 && b[i] != b[j] ; j = t[j] );

		++i;
		++j;

		if( b[i] == b[j] ) { t[i] = t[j]; }
		else { t[i] = j; }
    }
}

void solved( string &a, string &b, int lena, int lenb, int* t) {

	int i = 0;
	int j = 0;

	init( b, lenb, t );

	while ( j < lena ) {

		for( ; i > -1 && b[i] != a[j]; i = t[i] );

		++i;
		++j;

		if( i >= lenb ) {

			cout<<j-i+1<<" ";
			i = t[i];
		}
	}
}

int main() {

	int t [1500000] = {0};

	string a;
	string b;

	input( a, b );

	int lena = a.length();
	int lenb = b.length();

	solved( a, b, lena, lenb, t );
}