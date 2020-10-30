#include <iostream>
#include <cstdio>

void input( int &n, long long &x, long long &y, int* &a, int* &b ) {

	scanf( "%d%lld%lld", &n, &x, &y );

	a = new int [n];
	b = new int [n];

	for( int i = 0; i < n; ++i ) {

		scanf( "%d%d", &a[i], &b[i] );
	}
}

void output( long long kq ) {

	printf( "%lld", kq );
}

void radixsort( unsigned* a, unsigned* b, int n ) {

	unsigned f[100001] = {0};

	for( int i = 0; i < n; ++i ) {

		++f[a[i]];
	}

	unsigned tsum = 0, sum = 0;
	for( int i = 0; i <= 100001; ++i ) {

		tsum = sum + f[i];
		f[i] = sum - 1;
		sum = tsum;
	}

	for( int i = 0; i < n; ++i ) {

		b[++f[a[i]]] = a[i];
	}
}

long long solved( int n, long long x, long long y, int* a, int* b ) {

	int* d1 = new int [n];
	int* d2 = new int [n];

	radixsort( ( unsigned* )( a ), ( unsigned* )( d1 ), n  );
	radixsort( ( unsigned* )( b ), ( unsigned* )( d2 ), n  );


	long long t = 0;

	for( int i = 0; i < n; ++i ) {

		if( d1[i] < d2[i] ) { t += x*( d2[i] - d1[i] ); }
		else if( d1[i] > d2[i] ) { t += y*( d1[i] - d2[i] ); }
	}

	delete []d1;
	delete []d2;

	return t;
}

int main(  ) {

	int* a;
	int* b;

	int n;

	long long x, y;

	input( n, x, y, a, b );
	output( solved( n, x, y, a, b ) );

	delete []a;
	delete []b;
}