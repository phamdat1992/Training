#include <iostream>
#include <cstdio>
#include <cmath>

using namespace std;

void input( int &n, int* &a ) {

	scanf( "%d", &n );

	a = new int [n];
	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &a[i] );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

bool isUk( int x ) {

	int t = int( floor( sqrt( double( x << 1 ) ) ) );

	if( ( ( t*( t + 1 ) ) >> 1 ) == x ) {

		return true;
	}
	else {

		return false;
	}
}

int solved( int n, int* a ) {

	int kq = 0;
	int t1 = 0;
	int t2 = 1;

	for( int i = 0; i < n; ++i ) {

		if( isUk( a[i] ) && a[i] >= t2 ) {

			t2 = a[i];
			++t1;

			if( t1 > kq ) {

				kq = t1;
			}
		}
		else {

			t1 = 0;
			t2 = 1;
		}
	}

	return kq;
}

int main(  ) {

	int* a;
	int n;

	input( n, a );
	output( solved( n, a ) );

	delete []a;
}