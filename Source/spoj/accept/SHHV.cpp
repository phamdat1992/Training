#include <iostream>
#include <cstdio>

using namespace std;

void input( int &n, int* a ) {


	for( n = 0; cin>>a[++n]; );
	--n;
}

void init( int* f, int n ) {

	f[0] = 1;
	f[1] = 1;

	for( int i = 2; i < n; ++i ) {

		f[i] = f[i-1]*i;
	}
}

int find( int* a, int n, int i ) {

	int kq = 0;

	for( int j = i + 1; j < n; ++j ) {

		if( a[j] < a[i] ) { ++kq; }
	}

	return kq;
}

void problem1( int n, int *a, int* f ) {

	int s = 0;

	for( int i = 1; i < n; ++i ) {

		s += find( a, n, i )*f[n-i-1];
	}

	cout<<s+1<<endl;
}

void problem2( int n, int* a, int* f ) {

	int g [15] = {0};
	int i, j;

	for( i = 1; i < n; ++i ) {

		for( j = 1; j < n; ++j ) {

			if( g[j] == 0 ) {

				if( a[n] > f[n-i-1] ) { a[n] -= f[n-i-1]; }
				else { break; }
			}
		}

		cout<<j<<" ";
		g[j] = 1;
	}
}

int main(  ) {

	int a[15] = {0};
	int f[15] = {0}; 
	int n;

	input( n, a );
	init( f, n );

	problem1( n, a, f );
	problem2( n, a, f );
}