#include <iostream>
#include <cstdio>
#include <vector>
#include <cmath>
#include <list>

using namespace std;

#define _0( x ) ( x & 0x3ff )
#define _1( x ) ( x >> 0x00A )

const int oo = 1000000000;

vector< list< int > > save;

int r [100000][3];

int f [3001][13];
int  _max [3001][13];

int v [100001];
int a [100001];

int d [3001];
int c [3001];

int n, m, k, ln2;

void Get_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void input(  ) {

	Get_INT( n );
	Get_INT( m );

	for( int i = 0; i < m; ++i ) {

		Get_INT( r[i][0] );
		Get_INT( r[i][1] );
		Get_INT( r[i][2] );
	}
}

void radixsort( unsigned* a ) {

	unsigned b [100001];

	unsigned b0 [1024] = {0};
	unsigned b1 [1024] = {0};

	for( int i = 0; i < m; ++i ) {

		++b0[ _0( r[i][2] ) ];
		++b1[ _1( r[i][2] ) ];
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

		b[++b0[ _0( r[i][2] ) ]] = i;
	}

	for( int i = 0; i < m; ++i ) {

		a[++b1[ _1( r[b[i]][2] ) ]] = b[i];
	}
}

int get( int x ) {

	if( x != v[x] ) { v[x] = get( v[x] ); }
	return v[x];
}

void update( int x, int q ) {

	if( x != v[x] ) { update( v[x], q ); }
	v[x] = q;
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

int MAX( int a, int b ) {

	return ( a > b )? a : b;
}

void create_tree(  ) {

	for( int i = 0; i <= n; v[i] = i, i++ );

	radixsort( ( unsigned* )( a ) );

	save.resize( n+1 );
	for( int i = 0, j = 1; i < m && j < n; ++i ) {

		int f1 = get( r[a[i]][0] );
		int f2 = get( r[a[i]][1] );

		if( f1 != f2 ) {

			++j;

			int m = MIN( f1, f2 );

			update( r[a[i]][0], m );
			update( r[a[i]][1], m );

			save[r[a[i]][0]].push_back( r[a[i]][1] );
			save[r[a[i]][0]].push_back( r[a[i]][2] );

			save[r[a[i]][1]].push_back( r[a[i]][0] );
			save[r[a[i]][1]].push_back( r[a[i]][2] );
		}
	}
}

void dfs( int u ) {

	for( list< int >::iterator pos = save[u].begin(); pos != save[u].end(); ) {

		int g = *(pos++);
		int l = *(pos++);

		if( g != c[u] ) {

			c[g] = u;
			d[g] = d[u] + 1;
			_max[g][0] = l;

			dfs( g );
		}
	}
}

void visit(  ) {

	d[0] = 0;
	c[0] = 0;
	_max[0][0] = 0;

	d[1] = 1;
	c[1] = 0;
	_max[1][0] = 0;

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
			_max[i][j] = MAX( _max[f[i][j-1]][j-1], _max[i][j-1] );
		}
	}
}

int lca( int u, int v ) {

	if( d[u] >= d[v] ) {

		int fmax = 0;
		if( d[u] > d[v] ) {

			for( int i = 0, t = d[u] - d[v]; t > 0; t >>= 1, ++i ) {

				if( t & 1 ) {

					fmax = MAX( fmax, _max[u][i] );
					u = f[u][i];
				}
			}
		}

		if( u == v ) { return fmax; }
		else {

			int s;
			for( int i = ln2; i >=0; --i ) {

				if( f[u][i] != f[v][i] ) {

					fmax = MAX( fmax, _max[u][i] );
					fmax = MAX( fmax, _max[v][i] );

					u = f[u][i];
					v = f[v][i];
				}
				else {

					s = MAX( fmax, _max[u][i] );
					s = MAX(    s, _max[v][i] );
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

	Get_INT( k );
	for( int i = 0, u, v; i < k; ++i ) {

		Get_INT( u );
		Get_INT( v );

		printf( "%d\n", lca( u, v ) );
	}
}
