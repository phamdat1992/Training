#include <iostream>
#include <cstdio>

using namespace std;

void input( int &n, int* &a ) {

	scanf( "%d", &n );

	a = new int [n];

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &a[i] );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved( int n, int* a ) {

	unsigned f [100001] = {0};
	unsigned c [100001] = {0};

	for( int i = 0; i < n; ++i ) {

		++f[a[i]];
	}

	unsigned tsum = 0, sum = 0;

	for( int i = 0; i < 100001; ++i ) {

		tsum = sum + f[i];
		f[i] = sum - 1;
		sum = tsum;
	}

	for( int i = 0; i < n; ++i ) {

		c[++f[a[i]]] = i;
	}

	int kq = 0;
	for( int i = 0; i < n; ++i ) {

		if( a[c[i]] != -1 ) {

			a[c[i]] = -1;

			if( c[i]   > 0 ) { a[c[i]-1] = -1; }
			if( c[i]+1 < n ) { a[c[i]+1] = -1; }

			++kq;
		}
	}

	return kq;
}

int main(  ) {

	int* a;
	int n;

	input( n, a );
	output( solved( n, a ) );

	delete []a;
}