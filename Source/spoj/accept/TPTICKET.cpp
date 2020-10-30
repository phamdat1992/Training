#include <iostream>
#include <cstdio>

using namespace std;

int t [100000<<2] = {0};
int f [100000<<2] = {0};

int MAX( int a, int b ) {

	return ( a > b )? a : b;
}

void update( int i, int l, int r, int u, int v ) {

	if( v < l || u > r ) { return; }
	else if( u <= l && r <= v ) {

		++t[i];
		++f[i];

		return;
	}

	f[i<<1] += f[i];
	t[i<<1] += f[i];

	f[(i<<1)+1] += f[i];
	t[(i<<1)+1] += f[i];

	f[i] = 0;

	int m = ( l + r )>>1;
	update( i<<1, l, m, u, v );
	update( (i<<1)+1, m+1, r, u, v );

	t[i] = MAX( t[i<<1], t[(i<<1)+1] );
}

int query( int i, int l, int r, int u, int v ) {

	if( v < l || u > r ) { return 0; }
	else if( u <= l && r <= v ) {

		return t[i];
	}

	f[i<<1] += f[i];
	t[i<<1] += f[i];

	f[(i<<1)+1] += f[i];
	t[(i<<1)+1] += f[i];

	f[i] = 0;

	int m = ( l + r )>>1;

	int f1 = query( i<<1, l, m, u, v );
	int f2 = query( (i<<1)+1, m+1, r, u, v );

	return MAX( f1, f2 );
}

int main(  ) {

	int n, k, m;

	scanf( "%d%d%d", &n, &k, &m );
	for( int i = 0, u, v; i < m; ++i ) {

		scanf( "%d%d", &u, &v );

		if( query( 1, 1, n, u+1, v ) < k ) {

			update( 1, 1, n, u+1, v );
			printf( "1\n" );
		}
		else { printf( "0\n" ); }
	}
}