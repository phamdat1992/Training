#include <iostream>
#include <cstdio>

using namespace std;

int f [20000] = {0};

void init(  ) {

	for( int i = 0; i < 20000; ++i ) {

		f[i] = i;
	}
}

int get( int x ) {

	if( f[x] != x ) { f[x] = get( f[x] ); }
	return f[x];
}

void update( int x, int i ) {

	if( f[x] != x ) { update( f[x], i ); }
	f[x] = i;
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

int main(  ) {

	int n;

	scanf( "%d", &n );
	init(  );

	for( int i = 0, u, v, q; i < n; ++i ) {

		scanf( "%d%d%d", &u, &v, &q );

		int f1 = get( u );
		int f2 = get( v );

		if( q == 1 ) {

			int g = MIN( f1, f2 );

			update( u, g );
			update( v, g );
		}
		else if( q == 2 ) {

			printf( "%d\n", f1 == f2 );
		}
	}
}