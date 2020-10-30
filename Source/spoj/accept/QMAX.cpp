#include <iostream>
#include <cstdio>

int t [50000<<2] = {0};
int a [50000<<2] = {0};

int res;

void input( int &n, int &m ) {

	scanf( "%d%d", &n, &m );

	for( int i = 0, u, v, k; i < m; ++i ) {

		scanf( "%d%d%d", &u, &v, &k );

		a[u] += k;
		a[v+1] -= k;
	}

	for( int i = 1; i <= n; ++i ) {

		a[i] += a[i-1];
	}
}

int MAX( int a, int b ) {

	return ( a > b )? a : b;
}

void init( int i, int l, int r ) {

	if( l > r ) { return; }
	else if( l == r ) { t[i] = a[l]; }
	else {

		int m = ( l + r ) >> 1;

		init( i<<1, l, m );
		init( (i<<1)+1, m+1, r );

		t[i] = MAX( t[i<<1], t[(i<<1)+1] );
	}
}

void query( int i, int l, int r, int u, int v ) {

	if( l > v || r < u ) { return; }
	else if( u <= l && v >= r ) {

		res =  MAX( res, t[i] );
		return;
	}

	int m = ( l + r ) >> 1;
	query( i<<1, l, m, u, v );
	query( (i<<1)+1, m + 1, r, u, v );
}

int main(  ) {

	int n, m, k;

	input( n, m );
	init( 1, 1, n );

	scanf( "%d", &k );
	for( int i = 0, u, v; i < k; ++i ) {

		scanf( "%d%d", &u, &v );

		res = 0;
		query( 1, 1, n, u, v );

		printf( "%d\n", res );
	}
}