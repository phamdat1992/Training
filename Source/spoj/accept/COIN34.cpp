#include <iostream>
#include <cstdio>

using namespace std;

int a [1000000] = {0};
int s [50] = {0};

int n, x;

void init(  ) {

	s[1] = 2;
	s[2] = 3;
	s[3] = 5;

	for( int i = 4; i < 35; ++i ) {

		s[i] = s[i-1] + s[i-2] + s[i-3];
	}

	int f = ( 1<<20 ) - 1;

	for( int i = 0; i <= f; ++i ) {

		int u = 0;
		int d = 0;

		for( int j = 1, k = i; k > 0; k >>= 1, ++j ) {

			if( k&1 ) {

				u += s[j];
				++d;
			}
		}

		if( a[u] < d ) { a[u] = d; }
	}
}

int solved(  ) {

	int g = ( 1<<14 ) - 1;
	int kq = 0;

	for( int i = 0; i <= g; ++i ) {

		int u = 0;
		int d = 0;

		for( int j = 21, k = i; k > 0; k >>= 1, ++j ) {

			if( k&1 ) {

				u += s[j];
				++d;
			}
		}

		if( ( x - u > 0 && x - u < 1000000 ) && ( a[x-u] > 0 ) ) { kq = max( kq, a[x-u] + d ); }
		else if( x - u == 0 ) { kq = max( kq, d ); }
	}

	return kq;
}

int main(  ) {

	scanf( "%d", &n );

	init(  );

	for( int i = 1, k; i <= n; ++i ) {

		scanf( "%d", &x );

		k = solved(  );

		if( k == 0 ) { printf( "Case #%d: -1\n", i ); }
		else { printf( "Case #%d: %d\n", i, k ); }
	}
}