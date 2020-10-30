#include <iostream>
#include <cstdio>
#include <vector>
#include <list>

using namespace std;

int e [100000][2] = {0};
int f [100000] = {0};

int q [100000] = {0};
int w [100000] = {0};

int p [100000] = {0};

int c = 0;

vector< list< int > > a;

void input( int &n, int &m ) {

	scanf( "%d%d", &n, &m );

	a.resize( n + 1 );
	for( int i = 0; i < m; ++i ) {

		scanf( "%d%d", &e[i][0], &e[i][1] );

		a[e[i][0]].push_back( i );
		a[e[i][1]].push_back( i );
	}
}

void visit( int u ) {

	q[u] = ++c;
	w[u] = 100000;

	for( list< int >::const_iterator pos = a[u].begin(); pos != a[u].end(); ++pos ) {

		if( f[*pos] == 0 ) {

			f[*pos] = 1;

			int g = ( e[*pos][0] == u )? e[*pos][1] : e[*pos][0];
			if( p[g] == 0 ) {

				p[g] = u;
				visit( g );

				w[u] = ( w[u] > w[g] )? w[g] : w[u];
			}
			else { w[u] = ( w[u] > q[g] )? q[g] : w[u]; }
		}
	}
}

void solved( int n ) {

	int s [100000] = {0};
	int x [100000] = {0};

	for( int i = 1; i <= n; ++i ) {

		if( p[i] == 0 ) {

			p[i] = -1;
			visit( i );
		}
	}

	for( int i = 1; i <= n; ++i ) {

		if( p[i] != -1 ) { ++s[p[i]]; }
	}

	int kq1 = 0;
	for( int i = 1; i <= n; ++i ) {

		if( p[i] != -1 && q[i] <= w[i] ) { ++kq1; }
	}

	for( int i = 1; i <= n; ++i ) {

		if( p[i] != -1 ) {

			int u = p[i];
			if( w[i] >= q[u] ) {

				x[u] |= ( p[u] != -1 ) | ( s[u] >= 2 );
			}
		}
	}

	int kq2 = 0;
	for( int i = 1; i <= n; ++i ) {

		if( x[i] == 1 ) { ++kq2; }
	}

	printf( "%d %d", kq2, kq1 );
}

int main(  ) {

	int n, m;

	input( n, m );
	solved( n );
}