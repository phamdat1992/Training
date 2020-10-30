#include <iostream>
#include <cstdio>
#include <vector>
#include <cmath>
#include <list>

using namespace std;

#define _0( x ) ( x & 0x3ff )
#define _1( x ) ( x >> 0x00A )

const int oo = 0x7fffffff;

int f [100001][18];
int _min [100001][18];

int a [100000][3];

int q [100001];
int d [100001];
int c [100001];
int v [100001];

vector< list< int > > save;

int n, m, ln2;

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
	GET_INT( m );

	for( int i = 0; i < m; ++i ) {

		GET_INT( a[i][0] );
		GET_INT( a[i][1] );
		GET_INT( a[i][2] );
	}
}

void radixsort( unsigned* q ) {

	unsigned b [100001];

	unsigned b0 [1024] = {0};
	unsigned b1 [1024] = {0};

	for( int i = 0; i < m; ++i ) {

		++b0[ _0( a[i][2] ) ];
		++b1[ _1( a[i][2] ) ];
	}

	unsigned tsum = 0, sum0 = 0, sum1 = 0;
	for( int i = 0; i < 1024; ++i ) {

		tsum = sum0 + b0[i];
		b0[i] = sum0 - 1;
		sum0 = tsum;

		tsum = sum1 + b1[i];
		b1[i] = sum1 - 1;
		sum1 = tsum;
	}

	for( int i = 0; i < m; ++i ) {

		b[ ++b0[ _0( a[i][2] ) ]] = i;
	}

	for( int i = 0; i < m; ++i ) {

		q[ ++b1[ _1( a[b[i]][2] ) ]] = b[i];
	}
}

int get( int x ) {

	if( x != v[x] ) { v[x] = get( v[x] ); }
	return v[x];
}

void update( int x, int g ) {

	if( x != v[x] ) { update( v[x], g ); }
	v[x] = g;
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

void create_tree(  ) {

	for( int i = 0; i <= n; v[i] = i, i++ );

	radixsort( ( unsigned* )( q ) );

	save.resize( n+1 );
	for( int i = m-1, j = 1; i >= 0 && j < n; --i ) {

		int f1 = get( a[q[i]][0] );
		int f2 = get( a[q[i]][1] );

		if( f1 != f2 ) {

			++j;

			int m = MIN( f1, f2 );

			update( a[q[i]][0], m );
			update( a[q[i]][1], m );

			save[a[q[i]][0]].push_back( a[q[i]][1] );
			save[a[q[i]][0]].push_back( a[q[i]][2] );

			save[a[q[i]][1]].push_back( a[q[i]][0] );
			save[a[q[i]][1]].push_back( a[q[i]][2] );

			a[q[i]][2] = -1;
		}
	}
}

void dfs( int u ) {

	for( list< int >::const_iterator pos = save[u].begin(); pos != save[u].end();  ) {

		int v = *(pos++);
		int l = *(pos++);

		if( v != c[u] ) {

			c[v] = u;
			d[v] = d[u] + 1;
			_min[v][0] = l;

			dfs( v );
		}
	}
}

void visit(  ) {

	c[0] = 0;
	d[0] = 0;
	_min[0][0] = oo;

	c[1] = 0;
	d[1] = 1;
	_min[1][0] = oo;

	dfs( 1 );
}

void create(  ) {

	ln2 = int( log( n )/log( 2 ) + 1e-8 ) + 1;

	for( int i = 0; i <= n; ++i ) {

		f[i][0] = c[i];
	}

	for( int j = 1; j <= ln2; ++j ) {

		for( int i = 0; i <= n; ++i ) {

			f[i][j] = f[f[i][j-1]][j-1];
			_min[i][j] = MIN( _min[f[i][j-1]][j-1], _min[i][j-1] );
		}
	}
}

int lca( int u, int v ) {

	if( d[u] >= d[v] ) {

		int fmin = oo;
		if( d[u] > d[v] ) {

			for( int i = 0, t = d[u] - d[v]; t > 0; t >>= 1, ++i ) {

				if( t & 1 ) {

					fmin = MIN( fmin, _min[u][i] );
					u = f[u][i];
				}
			}
		}
		if( u == v ) { return fmin; }
		else {

			int s;
			for( int i = ln2; i >= 0; --i ) {

				if( f[u][i] != f[v][i] ) {

					fmin = MIN( fmin, _min[u][i] );
					fmin = MIN( fmin, _min[v][i] );

					u = f[u][i];
					v = f[v][i];
				}
				else {

					s = MIN( fmin, _min[u][i] );
					s = MIN(    s, _min[v][i] );
				}
			}

			return s;
		}
	}
	else { return lca( v, u ); }
}

int main(  ) {

	input(  );

	create_tree(  );
	visit(  );
	create(  );

	long long s = 0;
	for( int i = 0; i < m; ++i ) {

		if( a[i][2] != -1 ) {

			s += lca( a[i][0], a[i][1] ) - a[i][2];
		}
	}

	printf( "%lld", s );
}