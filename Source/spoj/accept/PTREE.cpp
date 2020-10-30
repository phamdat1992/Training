#include <iostream>
#include <cstdio>

using namespace std;

int a [300][300] = {0};
int d [300][300] = {0};
int t [300][300] = {0};

int c [300] = {0};

void input( int &n, int &p ) {

	scanf( "%d%d", &n, &p );

	for( int i = 1; i <= n; ++i ) {

		scanf( "%d", &c[i] );
	}

	for( int i = 1, w, e; i < n; ++i ) {

		scanf( "%d%d", &w, &e );

		a[w][e] = 1;
		a[e][w] = 1;
	}
}

void init( int n, int p ) {

	for( int i = 1; i <= n; ++i ) {

		for( int j = 1; j <= p; ++j ) {

			d[i][j] = -1000000000;
		}
	}
}

void visit( int u, int n, int p ) {

	d[u][1] = c[u];

	for( int v = 1; v <= n; ++v ) {

		if( a[u][v] == 1 ) {

			a[v][u] = 0;

			visit( v, n, p );

			for( int i = p; i > 0; --i ) {

				for( int j = 1; j < i; ++j ) {

					if( d[u][i] < d[u][j] + d[v][i-j] ) {

						d[u][i] = d[u][j] + d[v][i-j];
						t[v][i] = i - j;
					}
				}
			}
		}
	}
}

void tract( int u, int n, int p ) {

	for( int v = n; v > 0; --v ) {

		if( a[u][v] == 1 && t[v][p] > 0 ) {

			tract( v, n, t[v][p] );
			p -= t[v][p];
		}
	}

	printf( "%d ", u );
}

void solved( int n, int p ) {

	visit( 1, n, p );

	int vt = 1;
	for( int i = 1; i <= n; ++i ) {

		if( d[vt][p] < d[i][p] ) {

			vt = i;
		}
	}

	tract( vt, n, p );
}

int main(  ) {

	int n, p;

	input( n, p );
	init( n, p );
	solved( n, p );
}