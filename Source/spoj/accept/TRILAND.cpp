#include <algorithm>
#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

int a [1000][2] = {0};
long long f [1000][1000];

int n;

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

		GET_INT( a[i][0] );
		GET_INT( a[i][1] );
	}
}

long long dis( int x, int y ) {

	long long x1 = ( long long )( a[x][0] );
	long long y1 = ( long long )( a[x][1] );

	long long x2 = ( long long )( a[y][0] );
	long long y2 = ( long long )( a[y][1] );

	return ( x1 - x2 )*( x1 - x2 ) + ( y1 - y2 )*( y1 - y2 );
}

void solved(  ) {

	long long kq = 0;

	for( int i = 0; i < n; ++i ) {

		for( int j = i + 1; j < n; ++j ) {

			long long g = dis( i, j );

			f[i][j] = g;
			f[j][i] = g;
		}

		sort( f[i], f[i] + n );

		long long w = 0;
		long long d = 0;

		for( int j = 0; j < n; ++j ) {

			if( f[i][j] == w ) { ++d; }
			else {

				if( w != 0 ) {

					kq += ( d*( d-1 ) )>>1;
				}

				d = 1;
				w = f[i][j];
			}
		}

		if( w != 0 ) {

			kq += ( d*( d-1 ) )>>1;
		}
	}

	printf( "%lld", kq );
}

int main(  ) {

	input(  );
	solved(  );
}