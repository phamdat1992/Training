#include <iostream>
#include <cstdio>
#include <cmath>

using namespace std;

void tinh( int m, int* a, int &len ) {

	len = 0;

	for( int i = 2, t = int( sqrt( m ) ); i <= t; ++i ) {

		if( m%i == 0 ) {

			for( ; m%i == 0; m /= i );

			t = ( m == 0 )? 0 : int( sqrt( m ) );
			a[len++] = i;
		}
	}

	if( m > 1 ) {

		a[len++] = m;
	}
}

int main(  ) {

	int a[200000] = {0};
	
	int n, m, k;
	int len = 0;

	scanf( "%d", &n );

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &m );

		tinh( m, a, len );

		k = 1;
		for( int j = 0; j < len; ++j ) {

			k *= ( a[j] -1 );
			m /= a[j];
		}

		printf( "%d\n", k*m );
	}
}