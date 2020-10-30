#include <iostream>
#include <cstdio>
#include <string>

using namespace std;

void input( string &a, string &b ) {

	cin>>a;
	cin>>b;
}

void output( int kq ) {

	cout<<kq;
}

int MAX( int* m, int i, int j ) {

	if( i >=0 && m[i] > m[j] ) {

		return m[i];
	}
	else {

		return m[j];
	}
}

int solved( string &a, string &b ) {

	int lena = a.length();
	int lenb = b.length();

	int* m = new int [lena + lenb];

	for( int i = 0; i < lena; ++i ) {

		int t1 = 0;

		for( int j = 0; j < lenb; ++j ) {

			int t2 = m[j];

			if( a[i] == b[j] ) {

				m[j] = t1 + 1;
			}
			else {

				m[j] = MAX( m, j-1, j );
			}

			t1 = t2;
		}
	}

	int kq = m[lenb-1];
	delete []m;

	return kq;
}

int main(  ) {

	string a;
	string b;

	input( a, b );
	output( solved( a, b ) );
}