#include <iostream>
#include <cstdio>

using namespace std;

const int oo = 0x80000000;

int a [100000];
int f [100000<<2][4] = {0};

int n;

void input(  ) {

	scanf( "%d", &n );

	for( int i = 1; i <= n; ++i ) {

		scanf( "%d", &a[i] );
	}
}

int MAX( int a, int b ) {

	return ( a > b )? a : b;
}

void init( int i, int l, int r ) {

	if( l > r ) { return; }
	else if( l == r ) {

		f[i][0] = a[l];
		f[i][1] = a[l];
		f[i][2] = a[l];
		f[i][3] = a[l];

		return;
	}

	int m = ( l+r )>>1;

	init( i<<1, l, m );
	init( (i<<1)+1, m+1, r );

	f[i][1] = f[i<<1][1] + f[(i<<1)+1][1];

	f[i][0] = MAX( f[i<<1][0], f[i<<1][1] + f[(i<<1)+1][0] );
	f[i][0] = MAX( f[i][0], f[i][1]);

	f[i][2] = MAX( f[(i<<1)+1][2], f[i<<1][2] + f[(i<<1)+1][1] );
	f[i][2] = MAX( f[i][2], f[i][1] );

	f[i][3] = MAX( f[i<<1][3], f[(i<<1)+1][3] );
	f[i][3] = MAX( f[i][3], f[i<<1][2] + f[(i<<1)+1][0] );
	f[i][3] = MAX( f[i][3], f[i][1] );
}

void get( int i, int l, int r, int u, int v, int &f1, int &f2, int &f3, int &f4 ) {

	if( u > r || v < l ) {

		f1 = oo;
		f2 = oo;
		f3 = oo;
		f4 = oo;

		return;
	}
	else if( u <= l && r <= v ) {

		f1 = f[i][0];
		f2 = f[i][1];
		f3 = f[i][2];
		f4 = f[i][3];

		return;
	}

	int m = ( l+r )>>1;

	int g1, g2, g3, g4;
	int h1, h2, h3, h4;

	get( i<<1, l, m, u, v, g1, g2, g3, g4 );
	get( (i<<1)+1, m+1, r, u, v, h1, h2, h3, h4 );

	if( g1 == oo && g2 == oo && g3 == oo ) {

		f2 = h2;
		f1 = h1;
		f3 = h3;
		f4 = h4;
	}
	else if( h1 == oo && h2 == oo && h3 == oo ) {

		f2 = g2;
		f1 = g1;
		f3 = g3;
		f4 = g4;
	}
	else {

		f2 = h2 + g2;

		f1 = MAX( g1, g2 + h1 );
		f1 = MAX( f1, f2 );

		f3 = MAX( h3, g3 + h2 );
		f3 = MAX( f3, f2 );

		f4 = MAX( g4, h4 );
		f4 = MAX( f4, g3 + h1 );
		f4 = MAX( f4, f2 );
	}
}

int main(  ) {

	input(  );
	init( 1, 1, n );

	int m;

	scanf( "%d", &m );
	for( int i = 0, u, v, f1, f2, f3, f4; i < m; ++i ) {

		scanf( "%d%d", &u, &v );

		get( 1, 1, n, u, v, f1, f2, f3, f4 );
		printf( "%d\n", MAX( MAX( f2, f3 ), MAX( f1, f4 ) ) );
	}
}