#include <iostream>
#include <cstdio>
#include <cmath>

using namespace std;

#define _0(x) ( x & 0x07ff )
#define _1(x) ( x >> 11 & 0x07ff )
#define _2(x) ( x >> 22 )

const unsigned Khist = 2048;
const signed oo = 2000000001;

void input( int &n, int* &a, int* &b ) {

	scanf( "%d", &n );

	a = new int [n];
	b = new int [n];

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &a[i] );
	}

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &b[i] );
		b[i] = -b[i];
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

unsigned flip( unsigned x ) {

	return x ^ 0x80000000;
}

void RadixSort( unsigned* a, unsigned* d, int n ) {

	unsigned  b0[ Khist*3 ] = {0};
	unsigned* b1 = b0 + Khist;
	unsigned* b2 = b1 + Khist;

	unsigned fi;

	for( int i = 0; i < n; ++i ) {

		fi = flip( a[i] );

		++b0[_0(fi)];
		++b1[_1(fi)];
		++b2[_2(fi)];
	}

	{
		unsigned tsum;
		unsigned sum0 = 0, sum1 = 0, sum2 = 0;

		for( unsigned i = 0; i < Khist; ++i ) {

			tsum = b0[i] + sum0;
			b0[i] = sum0 - 1;
			sum0 = tsum;
			
			tsum = b1[i] + sum1;
			b1[i] = sum1 - 1;
			sum1 = tsum;
			
			tsum = b2[i] + sum2;
			b2[i] = sum2 - 1;
			sum2 = tsum;
		}
	}

	for( int i = 0; i < n; ++i ) {

		fi = flip( a[i] );
		d[++b0[_0( fi )]] = fi;
	}

	for( int i = 0; i < n; ++i ) {

		a[++b1[_1( d[i] )]] = d[i];
	}

	for( int i = 0; i < n; ++i ) {

		d[++b2[_2( a[i] )]] = flip(a[i]);
	}
}

int solved( int n, int* a, int* b ) {

	int* d1 = new int [n];
	int* d2 = new int [n];

	RadixSort( ( unsigned* )( a ), ( unsigned* )( d1 ), n );
	RadixSort( ( unsigned* )( b ), ( unsigned* )( d2 ), n );

	int t1 = 0;
	int t2 = 0;

	bool f = true;

	int w = d2[t2];
	int kq = oo;

	if( d1[t1] < d2[t2] ) {

		f = false;
		w = d1[t1];
	}

	for( ; t1 < n && t2 < n; ) {

		if( d1[t1] < d2[t2] ) {

			if( f == true ) {

				int h = abs( d1[t1] - w );
				if( h < kq ) {

					kq = h;
				}

				f = false;
			}

			w = d1[t1++];
		}
		else {

			if( f == false ) {

				int h = abs( d2[t2] - w );
				if( h < kq ) {

					kq = h;
				}

				f = true;
			}

			w = d2[t2++];
		}
	}

	int h;

	if( t1 == n ) {

		h = abs( d1[t1-1] - d2[t2] );
	}
	else if( t2 == n ) { 

		h = abs( d2[t2-1] - d1[t1] );
	}

	delete []d1;
	delete []d2;

	return ( kq < h )? kq : h;
}

int main(  ) {

	int* a;
	int* b;

	int n;

	input( n, a, b );
	output( solved( n, a, b ) );

	delete []a;
	delete []b;
}
