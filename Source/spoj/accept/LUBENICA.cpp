#include <iostream>
#include <cstdio>
#include <vector>
#include <cmath>
#include <list>

using namespace std;

int f [100001][18];

int c [100001];
int d [100001];

int _min [100001][18];
int _max [100001][18];

vector< list< int > > save;

int n, k, l;

inline void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void input(  ) {

	GET_INT( n );

	save.resize( n+1 );
	for( int i = 1, u, v, g; i < n; ++i ) {

		GET_INT( u );
		GET_INT( v );
		GET_INT( g );

		save[u].push_back( v );
		save[u].push_back( g );

		save[v].push_back( u );
		save[v].push_back( g );
	}

	l = int( log( n )/log( 2.0 ) + 1e-8 ) + 1;
}

void dfs( int u ) {

	for( list< int >::const_iterator pos = save[u].begin(); pos != save[u].end();  ) {

		int v = *(pos++);
		int g = *(pos++);

		if( v != c[u] ) {

			d[v] = d[u] + 1;
			c[v] = u;

			_max[v][0] = g;
			_min[v][0] = g;

			dfs( v );
		}
	}
}

void visit(  ) {

	c[1] = 0;
	d[1] = 1;
	_max[1][0] = 0;
	_min[1][0] = 1000000000;

	c[0] = 0;
	d[0] = 0;
	_max[0][0] = 0;
	_min[0][0] = 1000000000;

	dfs( 1 );
}

inline int MAX( int a, int b ) {

	return ( a > b )? a : b;
}

inline int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

void create(  ) {

	for( int i = 0; i <= n; ++i ) {

		f[i][0] = c[i];
	}

	for( int j = 1; j <= l; ++j ) {

		for( int i = 0; i <= n; ++i ) {

			f[i][j] = f[f[i][j-1]][j-1];

			_max[i][j] = MAX( _max[f[i][j-1]][j-1], _max[i][j-1] );
			_min[i][j] = MIN( _min[f[i][j-1]][j-1], _min[i][j-1] );
		}
	}
}

void lca( int u, int v, int &fmax, int &fmin ) {

	if( d[u] >= d[v] ) {

		fmax = 0;
		fmin = 1000000000;

		if( d[u] > d[v] ) {

			for( int i = 0, t = d[u] - d[v]; t > 0; t >>=1, ++i ) {

				if( t&1 ) {

					fmax = MAX( fmax, _max[u][i] );
					fmin = MIN( fmin, _min[u][i] );

					u = f[u][i];
				}
			}
		}

		if( u != v ) {

			int f1, f2;

			for( int i = l; i >= 0; --i ) {

				if( f[u][i] != f[v][i] ) {

					fmax = MAX( fmax, _max[u][i] );
					fmin = MIN( fmin, _min[u][i] );

					fmax = MAX( fmax, _max[v][i] );
					fmin = MIN( fmin, _min[v][i] );


					u = f[u][i];
					v = f[v][i];
				}
				else {

					f1 = MAX( fmax, _max[u][i] );
					f2 = MIN( fmin, _min[u][i] );

					f1 = MAX( f1, _max[v][i] );
					f2 = MIN( f2, _min[v][i] );
				}
			}

			fmax = f1;
			fmin = f2;
		}
	}
	else { lca( v, u, fmax, fmin ); }
}

int main(  ) {

	input(  );

	visit(  );
	create(  );

	GET_INT( k );
	for( int i = 0, u, v, t, fmin, fmax; i < k; ++i ) {

		GET_INT( u );
		GET_INT( v );

		if( u == v ) { printf( "0 0\n" ); }
		else {

			lca( u, v, fmax, fmin );

			printf( "%d %d\n", fmin, fmax );
		}
	}
}