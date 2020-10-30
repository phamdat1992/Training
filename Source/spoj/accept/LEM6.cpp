#include <iostream>
#include <cstdio>

using namespace std;

const long long cs = 1000000000000000ll;

void input( int &n, int &m, int* &a ) {

	cin>>n;
	cin>>m;

	a = new int [m];
	for( int i = 0; i < m; ++i ) {

		cin>>a[i];
	}
}
 
void print( long long* a, int n ) {

	printf( "%lld", a[n] );

	for( int i = n - 1; i >= 0; --i ) {

		for( long long d = cs/10; d > 1 && a[i] < d; d /= 10 ) {

			printf( "0" );
		}

		printf( "%lld", a[i] );
	}
}

void mul( long long* a, int b, int &n ) {

	long long t = 0;
	for( int i = 0; i <= n; ++i ) {

		t += a[i]*b;

		a[i] = t%cs;
		t /= cs;
	}

	for( ; t > 0; a[++n] = t%cs, t /= cs );
}

void div( long long*a, int b, int &n ) {

	long long t = 0;
	for( int i = n; i >= 0; --i ) {

		t *= cs;
		t += a[i];

		a[i] = t/b;
		t %= b;
	}

	for( ; a[n] == 0; --n );
}

void solved( int n, int m, int* a ) {

	n -= m - 1;
	for( int i = 0; i < m; ++i ) { n -= a[i]; }

	if( n <= 0 ) { printf( "0" ); }
	else {

		int t = m + n;
		int h = ( m < n )? m : n;

		long long kq [2000] = {0};
		int len = 0;

		kq[0] = 1;
		for( int i = 1; i <= h; ++i ) {

			mul( kq, ( t - i + 1 ), len );
			div( kq, i, len );
		}

		print( kq, len );
	}
}

int main(  ) {

	int n, m;
	int* a;

	input( n, m, a );
	solved( n, m, a );

	delete []a;
}
