#include <iostream>
#include <cstdio>

using namespace std;

int a [1000][1000] = {0};

int x1, y1;
int x2, y2;

int n, p;

void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void input(  ) {

	GET_INT( n );

	for( int i = 0; i < n; ++i ) {

		int f = 0;
		for( int j = 0, u; j < n; ++j ) {

			GET_INT( u );

			f += ( ( (i&1)^(j&1) ) == 0 )? u : -u;

			if( i == 0 ) { a[i][j] = f; }
			else { a[i][j] = a[i-1][j] + f; }
		}
	}
}

int _abs( int x ) {

	return ( x < 0 )? -x : x;
}

void solved(  ) {

	int f1 = 0;
	int f2 = 0;
	int f3 = 0;

	if( x1 != 0 ) { f1 = a[x1-1][y2]; }
	if( y1 != 0 ) { f2 = a[x2][y1-1]; }
	if( x1 != 0 && y1 != 0 ) { f3 = a[x1-1][y1-1]; }

	printf( "%d\n", _abs( a[x2][y2] - f1 - f2 + f3 ) );
}

int main(  ) {

	input(  );

	GET_INT( p );
	for( int i = 0; i < p; ++i ) {

		GET_INT( x1 );
		GET_INT( y1 );

		GET_INT( x2 );
		GET_INT( y2 );

		--x1;
		--y1;

		--x2;
		--y2;

		solved(  );
	}
}