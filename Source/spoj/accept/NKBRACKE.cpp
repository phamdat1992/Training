#include <iostream>
#include <cstdio>

using namespace std;

int f [(100001<<2)][2] = {0};
char s [200000] = {0};

int n, m;

void input(  ) {

	scanf( "%d%d", &n, &m );
	scanf( "\n%s", s+1 );
}

void init( int i, int l, int r ) {

	if( l > r ) { return; }
	else if( l == r ) {

		if( s[l] == ')' ) {

			f[i][0] = 0;
			f[i][1] = 1;
		}
		else {

			f[i][0] = 1;
			f[i][1] = 0;
		}

		return;
	}

	int m = ( l+r )>>1;

	init( i<<1, l, m );
	init( (i<<1)+1, m+1, r );

	f[i][0] = f[(i<<1)+1][0] + ( ( f[i<<1][0] > f[(i<<1)+1][1] )? ( f[i<<1][0] - f[(i<<1)+1][1] ) : 0 );
	f[i][1] = f[i<<1][1] + ( ( f[i<<1][0] < f[(i<<1)+1][1] )? ( f[(i<<1)+1][1] - f[i<<1][0] ) : 0 );
}

void update( int i, int l, int r, int x, char g ) {

	if( x < l || x > r ) { return; }
	else if( l == r && l == x  ) {

		if( g == '(' ) {

			f[i][0] = 1;
			f[i][1] = 0;
		}
		else {

			f[i][0] = 0;
			f[i][1] = 1;
		}

		return;
	}

	int m = ( l+r )>>1;

	update( i<<1, l, m, x, g );
	update( (i<<1)+1, m+1, r, x, g );

	f[i][0] = f[(i<<1)+1][0] + ( ( f[i<<1][0] > f[(i<<1)+1][1] )? ( f[i<<1][0] - f[(i<<1)+1][1] ) : 0 );
	f[i][1] = f[i<<1][1] + ( ( f[i<<1][0] < f[(i<<1)+1][1] )? ( f[(i<<1)+1][1] - f[i<<1][0] ) : 0 );
}

void get( int i, int l, int r, int u, int v, int &m, int &d ) {

	if( u > r || v < l ) {

		m = 0;
		d = 0;

		return;
	}
	if( u <= l && r <= v ) {

		m = f[i][0];
		d = f[i][1];

		return;
	}

	int g1, d1, g2, d2;
	int t = ( l+r )>>1;

	get( i<<1, l, t, u, v, g1, d1 );
	get( (i<<1)+1, t+1, r, u, v, g2, d2 );

	m = g2 + ( ( g1 > d2 )? ( g1 - d2 ) : 0 );
	d = d1 + ( ( g1 < d2 )? ( d2 - g1 ) : 0 );
}

int main(  ) {

	input(  );
	init( 1, 1, n );

	for( int i = 0; i < m; ++i ) {

		int k;

		scanf( "%d", &k );
		if( k == 1 ) {

			int u, v;
			int m, d;

			scanf( "%d%d", &u, &v );
			get( 1, 1, n, u, v, m, d );

			printf( "%d", m == 0 && d == 0 );
		}
		else {

			int r;
			char q;

			scanf( "%d %c", &r, &q );
			update( 1, 1, n, r, q );
			
		}
	}
}