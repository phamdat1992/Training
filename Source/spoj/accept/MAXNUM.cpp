#include <iostream>
#include <cstdio>
#include <cmath>

using namespace std;

const int oo = 0x7fffffff;

void input( int &n, int &p ) {

	scanf( "%d%d", &n, &p );
}

void output( int kq ) {

	printf( "%d", kq );
}

void prim( int n, int* a ) {

	int f = int( floor( sqrt( n ) ) );

	for( int i = 2; i <= f; ++i ) {

		if( n % i == 0 ) {

			while( n % i == 0 ) {

				n /= i;
				++a[i];
			}

			f = int( floor( sqrt( n ) ) );
		}
	}

	if( n != 1 ) {

		++a[n];
	}
}

int solved( int n, int p ) {

	int r1 [50000] = {0};
	int r2 [50000] = {0};

	prim( p, r1 );

	for( int i = 2; i <= n; ++i ) {

		prim( i, r2 );
	}

	int min = 0x7fffffff;

	for( int i = 2; i <= n; ++i ) {

		if( r1[i] != 0 ) {

			int k = r2[i] / r1[i];
			min = ( min > k )? k : min;
		}
	}

	return ( min == oo )? 0 : min;
}

int main(  ) {

	int n, p;

	input( n, p );
	output( solved( n, p ) );
}