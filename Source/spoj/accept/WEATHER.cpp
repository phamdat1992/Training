#include <iostream>
#include <cstdio>

using namespace std;

int q [200] = {0};
int w [200] = {0};

int a [200][200] = {0};

int t = 0;
int c = 0;

void input( int &n, int &m ) {

	scanf( "%d%d", &n, &m );

	for( int i = 0, u, v; i < m; ++i ) {

		scanf( "%d%d", &u, &v );

		++a[u][v];
		++a[v][u];
	}
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

int visit( int u, int n ) {

	q[u] = ++c;
	w[u] = 100000;

	int s = 1;
	for( int v = 1; v <= n; ++v ) {

		if( a[u][v] != 0 ) {

			a[v][u] = 0;

			if( q[v] != 0 ) { w[u] = MIN( w[u], q[v] ); }
			else {

				int r = visit( v, n );

				s += r;
				w[u] = MIN( w[u], w[v] );

				if( a[u][v] == 1 && w[v] > q[u] ) {

					t += ( r )*( n - r );
				}
			}
		}
	}

	return s;
}

int main(  ) {

	int n, m;

	input( n, m );
	visit( 1, n );

	printf( "%d", t );
}