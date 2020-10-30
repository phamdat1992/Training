#include <iostream>
#include <cstdio>
#include <vector>
#include <list>

using namespace std;

const int oo = 0x7fffffff;

int g[15000][4] = {0};
int f[15000] = {0};

void input( int &n, vector< list< int > > &a ) {

	scanf( "%d", &n );

	a.resize( n + 1 );
	for( int i = 1, w, e; i < n; ++i ) {

		scanf( "%d%d", &w, &e );

		a[w].push_back( e );
		a[e].push_back( w );
	}
}

void output( int n, int s ) {

	printf( "%d\n", s );

	for( int i = 1; i <= n; ++i ) {

		printf( "%d\n", f[i] );
	}
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

void visit( int u, vector< list< int > > &a ) {

	f[u] = oo;

	g[u][1] = 1;
	g[u][2] = 2;
	g[u][3] = 3;

	for( list< int >::const_iterator pos = a[u].begin(); pos != a[u].end(); ++pos ) {

		if( f[*pos] == 0 ) {

			visit( *pos, a );

			g[u][1] += MIN( g[*pos][2], g[*pos][3] );
			g[u][2] += MIN( g[*pos][1], g[*pos][3] );
			g[u][3] += MIN( g[*pos][1], g[*pos][2] );
		}
	}
}

int tract( int u, int l, vector< list< int > > &a ) {

	int t = 0;
	f[u] = 0;
	for( int i = 1, q = oo; i <= 3; ++i ) {

		if( i != l && g[u][i] < q ) {

			q = g[u][i];
			f[u] = i;
		}
	}

	for( list< int >::const_iterator pos = a[u].begin(); pos != a[u].end(); ++pos ) {

		if( f[*pos] == oo ) {

			t += tract( *pos, f[u], a );
		}
	}

	t += f[u];

	return t;
}

void output( int n ) {

	for( int i = 1; i <= n; ++i ) {

		printf( "%d\n", f[i] );
	}
}

int main(  ) {

	vector< list< int > > a;
	int n;

	input( n, a );
	visit( 1, a );

	printf( "%d\n", tract( 1, 0, a ) );
	output( n );
}