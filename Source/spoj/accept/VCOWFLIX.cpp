#include <iostream>
#include <cstdio>

using namespace std;

void input( int &c, int &n, int* a ) {

	scanf( "%d%d", &c, &n );

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &a[i] );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved( int c, int n, int* a ) {

	int f = ( 1 << n ) - 1;

	int kq = 0;
	for( int i = 0; i <= f; ++i ) {

		int w = 0;
		for( int j = 0, g = i; w < c && g > 0; ++j, g >>= 1 ) {

			if( g&1 ) { w += a[j]; }
		}

		if( w <= c && w > kq ) { kq = w; }
	}

	return kq;
}

int main(  ) {

	int a [20] = {0};
	int n, c;

	input( c, n, a );
	output( solved( c, n, a ) );
}