#include <iostream>
#include <cstdio>

using namespace std;

#define _0( x ) ( x & 0x7fff )
#define _1( x ) ( ( x >> 15 ) & 0x7fff )
#define _2( x ) ( ( x >> 30 ) & 0x7fff )
#define _3( x ) ( x >> 45 )

typedef long long int64;
typedef unsigned long long uint64;

const int khis = 32768;

void input( int64 &n, int64 &p, int64* &a, int64* &b ) {

	scanf( "%lld %lld", &n, &p );

	a = new int64 [n];
	b = new int64 [n];

	for( int64 i = 0; i < n; ++i ) {

		scanf( "%lld %lld\n", &a[i], &b[i] );
	}
}

void output( int64 kq ) {

	printf( "%lld", kq );
}

void radixsort( uint64* a, uint64* b, uint64* c, uint64* d, int64 n ) {

	uint64 b0 [khis] = {0};
	uint64 b1 [khis] = {0};
	uint64 b2 [khis] = {0};
	uint64 b3 [khis] = {0};

	for( int64 i = 0; i < n; ++i ) {

		++b0[_0( a[i] )];
		++b1[_1( a[i] )];
		++b2[_2( a[i] )];
		++b3[_3( a[i] )];
	}

	uint64 tsum = 0;
	uint64 sum0 = 0, sum1 = 0, sum2 = 0, sum3 = 0;

	for( int64 i = 0; i < khis; ++i ) {

		tsum = sum0 + b0[i];
		b0[i] = sum0 - 1;
		sum0 = tsum;

		tsum = sum1 + b1[i];
		b1[i] = sum1 - 1;
		sum1 = tsum;

		tsum = sum2 + b2[i];
		b2[i] = sum2 - 1;
		sum2 = tsum;

		tsum = sum3 + b3[i];
		b3[i] = sum3 - 1;
		sum3 = tsum;
	}

	for( int64 i = 0; i < n; ++i ) {

		d[++b0[_0( a[i] )]] = a[i];
		c[b0[_0( a[i] )]] = b[i];
	}

	for( int64 i = 0; i < n; ++i ) {

		a[++b1[_1( d[i] )]] = d[i];
		b[b1[_1( d[i] )]] = c[i];
	}

	for( int64 i = 0; i < n; ++i ) {

		d[++b2[_2( a[i] )]] = a[i];
		c[b2[_2( a[i] )]] = b[i];
	}

	for( int64 i = 0; i < n; ++i ) {

		a[++b3[_3( d[i] )]] = d[i];
		b[b3[_3( d[i] )]] = c[i];
	}
}

int64 solved( int64 n, int64 p, int64* a, int64*b ) {

	int64* c = new int64 [n];
	int64* d = new int64 [n];

	radixsort( ( uint64* )( a ), ( uint64* )( b ), ( uint64* )( c ), ( uint64* )( d ), n );

	int64 kq = 0;

	for( int i = 0; i < n; ++i ) {

		if( b[i] > 0 ) {

			int64 t = p/a[i];

			if( t > b[i] ) { t = b[i]; }

			kq += t;
			p -= a[i]*t;
		}
	}

	delete []c;
	delete []d;
	
	return kq;
}

int main(  ) {

	int64* a;
	int64* b;

	int64 n, p;

	input( n, p, a, b );
	output( solved( n, p, a, b ) );

	delete []a;
	delete []b;
}