#include <iostream>
#include <cstdio>

void init( int* f, int* m ) {

	f[0] = 0;
	f[1] = 1;

	m[0] = 0;
	m[1] = 1;

	for( int i = 2; i <= 100000; ++i ) {

		f[i] = f[i>>1];

		if( i&1 ) { f[i] += f[(i>>1)+1]; }

		m[i] = ( m[i-1] > f[i] )? m[i-1] : f[i];
	}
}

int main(  ) {

	int f [150000] = {0};
	int m [150000] = {0};
	int t;

	scanf( "%d", &t );

	init( f, m );
	for( int i = 0, n; i < t; ++i ) {

		scanf( "%d", &n );
		printf( "%d\n", m[n] );
	}
}