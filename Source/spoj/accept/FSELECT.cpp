#include <iostream>
#include <cstdio>
#include <cmath>

using namespace std;

int f [200001][20];	//mang luu lca
int a [200001];		//mang luu cuoc hop cua i
int c [200001];		//mang luu cha cua i
int b [200001];

int q [100001] = {0};	//mang cho biet cuoc hop co bao nhieu nguoi tham gia
int d [200001] = {0};	//khoang cach i den goc

bool v [200001] = {0};

int n, k;
int l;

void input(  ) {

	scanf( "%d%d", &n, &k );

	for( int i = 1, u, v; i <= n; ++i ) {

		scanf( "%d%d", &u, &v );

		++q[u];
		c[i] = v;
		a[i] = u;
	}

	l = int( log( n )/log( 2.0 ) + 1e-8 ) + 1;
}

void create(  ) {

	f[0][0] = 0;
	for( int i = 1; i <= n; ++i ) {

		f[i][0] = c[i];
	}

	for( int j = 1; j <= l; ++j ) {

		for( int i = 0; i <= n; ++i ) {

			f[i][j] = f[ f[i][j-1]][j-1];
		}
	}
}

int dfs( int u ) {

	v[u] = 1;

	if( u == 0 ) { return 0; }
	else {

		if( v[c[u]] ) {

			d[u] = d[c[u]] + 1;
		}
		else {

			d[u] = dfs( c[u] ) + 1;
		}

		return d[u];
	}
}

void visit(  ) {

	v[0] = 1;
	d[0] = 0;
	
	for( int i = 1; i <= n; ++i ) {

		if( !v[i] ) { dfs( i ); }
	}
}

int lca( int u, int v ) {

	int kq;

	if( d[u] >= d[v] ) {

		if( d[u] > d[v] ) {

			int t = d[u] - d[v];
			for( int i = 0; t > 0; t >>= 1, ++i ) {

				if( t & 1 ) { u = f[u][i]; }
			}
		}

		for( int i = l; i >= 0; --i ) {

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

void radixsort( unsigned* a, unsigned* b, int len ) {
	
	unsigned b0 [100001] = {0};

	for( int i = 0; i <= len; ++i ) {

		++b0[a[i]];
	}

	unsigned tsum = 0, sum0 = 0;

	for( int i = 0; i < 100001; ++i ) {

		tsum = sum0 + b0[i];
		b0[i] = sum0 - 1;
		sum0 = tsum;
	}

	for( int i = 0; i <= len; ++i ) {

		b[++b0[a[i]]] = i;
	}
}

int kc( int u, int v ) {

	int t = lca( u, v );

	return ( d[u] + d[v] - ( d[t] << 1 ) );
}

void solved(  ) {

	for( int i = 1; i <= k; ++i ) { q[i] += q[i-1]; }

	create(  );
	visit(  );

	radixsort( ( unsigned* )( a ), ( unsigned* )( b ), n );

	for( int i = 1; i <= k; ++i ) {

		int h = 0;
		for( int j = q[i-1]+1; j <= q[i]; ++j ) {

			if( d[b[j]] > d[h] ) {

				h = b[j];
			}	
		}

		int m = 0;
		for( int j = q[i-1]+1; j <= q[i]; ++j ) {

			int t = kc( h, b[j] );
			if( t > m ) {

				m = t;
			}
		}

		printf( "%d\n", m );
	}
}

int main(  ) {

	input(  );
	solved(  );
}