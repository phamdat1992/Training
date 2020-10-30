#include <iostream>
#include <cstdio>

using namespace std;

#define _0( x ) ( x & 0x7FF )
#define _1( x ) ( x >> 11 & 0x7FF )
#define _2( x ) ( x >> 22 )

typedef unsigned uint32;

const uint32 kHist = 2048;

void input( int &n, int* &a, int* &b ) {

	scanf( "%d", &n );

	a = new int [n];
	b = new int [n];

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &a[i] );
	}

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &b[i] );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

inline uint32 FlipSign( uint32 x ) {

	return x ^ 0x80000000;
}

// ===================================================
// Radix Sort Use Counting Sort

void RadixSort( uint32 *source, uint32 *dest, uint32 elements ) {

	uint32 b0[ kHist*3 ] = { 0 };
	uint32 *b1 = b0 + kHist;
	uint32 *b2 = b1 + kHist;
	uint32 fi;

	// making histograms
	for( uint32 i = 0; i < elements; ++i ) {
	
		fi = FlipSign( source[ i ] );

		++b0[ _0( fi ) ];
		++b1[ _1( fi ) ];
		++b2[ _2( fi ) ];
	}

	{
		uint32 sum0 = 0, sum1 = 0, sum2 = 0;
		uint32 tsum;

		for( uint32 i = 0; i < kHist; ++i ) {

			tsum = b0[ i ] + sum0;
			b0[ i ] = sum0 - 1;
			sum0 = tsum;

			tsum = b1[ i ] + sum1;
			b1[ i ] = sum1 - 1;
			sum1 = tsum;

			tsum = b2[ i ] + sum2;
			b2[ i ] = sum2 - 1;
			sum2 = tsum;
		}
	}
	
	// sort for bit 0 - 10
	for( uint32 i = 0; i < elements; ++i ) {

		fi = FlipSign( source[ i ] );
		dest[ ++b0[ _0( fi ) ] ] = fi;
	}

	// sort for bit 11 - 21
	for( uint32 i = 0; i < elements; ++i ) {

		source[ ++b1[ _1( dest[ i ] ) ] ] = dest[ i ];
	}

	// sort for bit 22 - 31
	for( uint32 i = 0; i < elements; ++i ) {

		dest[ ++b2[ _2( source[ i ] ) ] ] = FlipSign( source[ i ] );
	}
}

int MAX( int a, int b ) {

	return ( a > b )? a : b;
}

int solved( int n, int* a, int* b ) {

	int* d1 = new int [n];
	int* d2 = new int [n];

	RadixSort( ( uint32* )( a ), ( uint32* )( d1 ), n );
	RadixSort( ( uint32* )( b ), ( uint32* )( d2 ), n );

	int kq = 0;

	for( int t1 = 0, t2 = 0, m; t1 < n && t2 < n; ) {

		++kq;
		m = MAX( d1[t1], d2[t2] );

		for( ; t1 < n && d1[t1] <= m; ++t1 );
		for( ; t2 < n && d2[t2] <= m; ++t2 );
	}

	delete []d1;
	delete []d2;

	return kq;
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