#include <iostream>
#include <cstdio>

using namespace std;

long long f [50000<<2] = {0};
long long t [50000<<2] = {0};

long long g;

long long MAX( long long a, long long b ) {

	return ( a < b )? b : a;
}

void update( int i, int l, int r, int u, int v ) {

	if( v < l || u > r ) { return; }
	else if( u <= l && r <= v ) {

		f[i] += g;
		t[i] += g;

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

void query( int i, int l, int r, int u, int v ) {

	if( v < l || u > r ) { return; }
	else if( u <= l && r <= v ) {

		g = MAX( g, t[i] );

		return;
	}

	f[i<<1] += f[i];
	t[i<<1] += f[i];

	f[(i<<1)+1] += f[i];
	t[(i<<1)+1] += f[i];

	f[i] = 0;

	int m = ( l + r )>>1;
	query( i<<1, l, m, u, v );
	query( (i<<1)+1, m + 1, r, u, v );
}

int main(  ) {

	int n, m;

	scanf( "%d%d", &n, &m );
	for( int i = 0, q, u, v; i < m; ++i ) {

		scanf( "%d%d%d", &q, &u, &v );

		if( q == 0 ) {

			scanf( "%lld", &g );
			update( 1, 1, n, u, v );
		}
		else {

			g = 0;
			query( 1, 1, n, u, v );
			printf( "%lld\n", g );
		}
	}
}