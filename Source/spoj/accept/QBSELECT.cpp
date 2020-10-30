#include <iostream>
#include <cstdio>

using namespace std;

typedef long long int64;

int64 MAX( int64 a, int64 b ) {

	return ( a > b )? a : b;
}

int64 input( int64 &n, int64** &a ) {

	int64 c = 0x8000000000000000ll;

	scanf( "%lld", &n );

	a = new int64* [n];
	for( int64 i = 0; i < n; ++i ) {

		a[i] = new int64 [4];
	}

	for( int64 i = 0; i < 4; ++i ) {

		for( int64 j = 0; j < n; ++j ) {

			scanf( "%lld", &a[j][i] );
			c = MAX( c, a[j][i] );
		}
	}

	return c;
}

void output( int64 kq ) {

	printf( "%lld", kq );
}

void init( int64* f1, int64* f2, int64* g, int64 h[][16] ) {

	for( int64 i = 0; i < 16; ++i ) {

		f1[i] = f2[i] = 0;
		
		for( int64 j = 0; j < 16; ++j ) {

			h[i][j] = 0;
		}
	}

	g[0] = 0x0;
	g[1] = 0x1;
	g[2] = 0x2;
	g[3] = 0x4;
	g[4] = 0x5;
	g[5] = 0x8;
	g[6] = 0x9;
	g[7] = 0xA;

	h[0x0][0x0] = 1;
	h[0x0][0x1] = 1;
	h[0x0][0x2] = 1;
	h[0x0][0x4] = 1;
	h[0x0][0x5] = 1;
	h[0x0][0x8] = 1;
	h[0x0][0x9] = 1;
	h[0x0][0xA] = 1;

	h[0x1][0x0] = 1;
	h[0x1][0x2] = 1;
	h[0x1][0x4] = 1;
	h[0x1][0x8] = 1;
	h[0x1][0xA] = 1;

	h[0x2][0x0] = 1;
	h[0x2][0x1] = 1;
	h[0x2][0x4] = 1;
	h[0x2][0x5] = 1;
	h[0x2][0x8] = 1;
	h[0x2][0x9] = 1;

	h[0x4][0x0] = 1;
	h[0x4][0x1] = 1;
	h[0x4][0x2] = 1;
	h[0x4][0x8] = 1;
	h[0x4][0x9] = 1;
	h[0x4][0xA] = 1;

	h[0x5][0x0] = 1;
	h[0x5][0x2] = 1;
	h[0x5][0x8] = 1;
	h[0x5][0xA] = 1;

	h[0x8][0x0] = 1;
	h[0x8][0x1] = 1;
	h[0x8][0x2] = 1;
	h[0x8][0x4] = 1;
	h[0x8][0x5] = 1;

	h[0x9][0x0] = 1;
	h[0x9][0x2] = 1;
	h[0x9][0x4] = 1;

	h[0xA][0x0] = 1;
	h[0xA][0x1] = 1;
	h[0xA][0x4] = 1;
	h[0xA][0x5] = 1;
}

int64 solved( int64 n, int64** a ) {

	int64* f1 = new int64 [16];
	int64* f2 = new int64 [16];

	int64 g [8];
	int64 h [16][16];

	init( f1, f2, g, h );

	for( int64 i = 0; i < n; ++i ) {

		for( int64 j = 0; j < 8; ++j ) {

			f2[g[j]] = 0;
			for( int64 s = 0; s < 8; ++s ) {

				if( h[g[j]][g[s]] == 1 ) {

					f2[g[j]] = MAX( f2[g[j]], f1[g[s]] );
				}
			}

			for( int64 s = 0, k = g[j]; s < 4; ++s, k >>= 1 ) {

				if( ( k|1 ) == k ) { f2[g[j]] += a[i][s]; }
			}
		}

		swap( f1, f2 );
	}

	int64 kq = 0;
	for( int64 i = 0; i < 8; ++i ) {

		kq = MAX( kq, f1[g[i]] );
	}

	delete []f1;
	delete []f2;

	return kq;
}

int main(  ) {

	int64** a;
	int64 n;

	int64 c = input( n, a );

	if( c > 0 ) { output( solved( n, a ) ); }
	else { printf( "%lld", c ); }

	for( int i = 0; i < n; ++i ) {

		delete []a[i];
	}

	delete []a;
}

