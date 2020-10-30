#include <iostream>
#include <cstdio>

using namespace std;

void radixsort( unsigned* a, unsigned* d, int n ) {

	unsigned b[10001] = {0};

	for( int i = 0; i < n; ++i ) { ++b[a[i]]; }


	unsigned tsum = 0, sum = 0;
	for( int i = 0; i < 10001; ++i ) {

		tsum = sum + b[i];
		b[i] = sum - 1;
		sum = tsum;
	}

	for( int i = 0; i < n; ++i ) { d[++b[a[i]]] = a[i]; }
}

long long input( int* a, int &n ) {

	long long t = 0;

	scanf( "%d", &n );
	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &a[i] );

		t += ( long long )( a[i] );
	}

	return t;
}

void output( long long kq ) {

	printf( "%lld", kq );
}

long long solved( long long t, int* a, int n ) {

	int d [100000] = {0};

	radixsort( ( unsigned* )( a ), ( unsigned* )( d ), n );

	for( int i = n; i > ( n >> 1 ); --i ) {

		t += ( d[i-1] - d[n-i] > 0 ) ? ( d[i-1] - d[n-i] ) : 0;
	}

	return t;
}

int main(  ) {

	int a [100000] = {0};
	int n;

	long long t = input( a, n );
	output( solved( t, a, n ) );
}