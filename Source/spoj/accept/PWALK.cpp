#include <iostream>
#include <cstdio>
#include <list>
#include <vector>

using namespace std;

int f [2000][20] = {0};

int a [2000];
int c [2000] = {0};
int d [2000];

bool q [2000] = {0};

vector< list< int > > s;

int n, m;

void input(  ) {

	scanf( "%d%d", &n, &m );

	s.resize( n+1 );

	for( int i = 1, u, v, l; i < n; ++i ) {

		scanf( "%d%d%d", &u, &v, &l );

		s[u].push_back( v );
		s[u].push_back( l );

		s[v].push_back( u );
		s[v].push_back( l );
	}
}

void mtree( int u ) {

	q[u] = 1;

	for( list< int >::const_iterator pos = s[u].begin(); pos != s[u].end(); ) {

		int v = *(pos++);
		int l = *(pos++);

		if( !q[v] ) {

			c[v] = u;
			a[v] = l+a[u];
			d[v] = d[u]+1;

			mtree( v );
		}
	}
}

void visit(  ) {

	q[0] = 1;
	a[0] = 0;
	d[0] = 0;
	c[0] = 0;

	a[1] = 0;
	c[1] = 0;
	d[1] = 1;

	mtree( 1 );
}

void create(  ) {

	f[0][0] = 0;
	for( int i = 1; i <= n; ++i ) {

		f[i][0] = c[i];
	}

	for( int j = 1; j <= 10; ++j ) {

		for( int i = 0; i <= n; ++i ) {

			f[i][j] = f[f[i][j-1]][j-1];
		}
	}
}

int lca( int u, int v ) {

	int kq;

	if( d[u] >= d[v] ) {

		if( d[u] > d[v] ) {

			for( int i = 0, t = d[u] - d[v]; t > 0; t >>= 1, ++i ) {

				if( t&1 ) {

					u = f[u][i];
				}
			}
		}

		for( int i = 10; i >= 0; --i ) {

			if( f[u][i] != f[v][i] ) {

				u = f[u][i];
				v = f[v][i];
			}
			else { kq = f[u][i]; }
		}

		if( u == v ) { kq = u; }
	}
	else { kq = lca( v, u ); }

	return kq;
}

int kc( int u, int v ) {

	int t = lca( u, v );
	return a[u] + a[v] - ( a[t] << 1 );
}

int main(  ) {

	input(  );

	visit(  );
	create(  );

	for( int i = 0, u, v; i < m; ++i ) {

		scanf( "%d%d", &u, &v );
		printf( "%d\n", kc( u, v ) );
	}
}