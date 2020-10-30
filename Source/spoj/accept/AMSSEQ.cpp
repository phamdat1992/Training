#include <iostream>
#include <cstdio>

using namespace std;

const int noo = 0x80000000;

void input( int &n, int &k, int* &a ) {

	scanf( "%d%d", &n, &k );

	a = new int [n+1];
	for( int i = 1; i <= n; ++i ) {

		scanf( "%d", &a[i] );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved( int n, int k, int* a ) {

	int* f = new int [n+1];

	f[0] = 0;
	for( int i = 1; i <= n; ++i ) {

		f[i] = noo;
	}

	int kq = 0;
	for( int i = 0; i <= n; ++i ) {

		if( f[i] > kq ) { kq = f[i]; }

		for( int j = 1; j <= k; ++j ) {

			if( i + j <= n && f[i] + a[i+j] > f[i+j] ) {

				f[i+j] = f[i] + a[i+j];
			}
		}
	}

	delete []f;

	return kq;
}

int main(  ) {

	int* a;
	int n, k;

	input( n, k, a );
	output( solved( n, k, a ) );

	delete []a;
}