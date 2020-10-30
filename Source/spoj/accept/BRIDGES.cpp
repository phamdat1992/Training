#include <iostream>
#include <cstdio>
#include <vector>
#include <list>

using namespace std;

typedef long long int64;

int64 v [20000] = {0};
int64 f [20000] = {0};
int64 h [20000] = {0};
int64 d [20000] = {0};

void upheap( int64 x ) {

	int64 l = d[x];
	int64 i = l >> 1;

	while( i && f[h[i]] < f[h[l]] ) {

		swap( h[i], h[l] );
		swap( d[h[i]], d[h[l]] );

		l = i;
		i >>= 1;
	}
}

int64 popheap(  ) {

	int64 k = h[1];
	int64 v = h[h[0]--];

	int64 r = 1;
	int64 c = 1;

	while( (r << 1) <= h[0]  ) {

		c = r << 1;
		if( c+1 <= h[0] && f[h[c+1]] > f[h[c]] ) { ++c; }
		if( f[v] >= f[h[c]] ) { break; }

		h[r] = h[c];
		d[h[r]] = r;

		r = c;
		
	}

	h[r] = v;
	d[v] = r;

	return k;
}

void input( int64 &n, int64 &k, int64 &vp, int64 &vc, vector< list< int64 > > &a ) {

	scanf( "%lld%lld%lld%lld", &n, &k, &vp, &vc );

	a.resize( n + 1 );
	for( int64 i = 1, w, e, r; i < n; ++i ) {

		scanf( "%lld%lld%lld", &w, &e, &r );

		a[w].push_back( i );
		a[w].push_back( e );
		a[w].push_back( r );

		a[e].push_back( i );
		a[e].push_back( w );
		a[e].push_back( r );
	}
}

int64 visit( int64 u, int64 n, vector< list< int64 > > &a ) {

	v[u] = 1;

	int64 q = 1;
	for( list< int64 >::const_iterator pos = a[u].begin(); pos != a[u].end(); ) {

		int64 w = *(pos++);
		int64 e = *(pos++);
		int64 r = *(pos++);

		if( v[e] == 0 ) {

			int64 g = visit( e, n, a );

			q += g;
			f[w] = g*( n-g )*r;
			upheap( w );
		}
	}

	return q;
}

void init( int n ) {

	for( int64 i = 1; i < n; ++i ) {

		h[i] = i;
		d[i] = i;
	}

	h[0] = n-1;
}

void solved( int64 n, int vp, int vc, int64 k, vector< list< int64 > > &a ) {

	int64 z [20000] = {0};

	init( n );
	visit( 1, n, a );

	for( int64 i = 1; i < n; ++i ) {

		z[i] = popheap(  );
	}

	if( vp <= vc ) {

		for( int64 i = 1; i <= k; ++i ) {

			printf( "%lld ", z[i] );
		}
	}
	else if( vp > vc ) {

		for( int64 i = 1; i <= k; ++i ) {

			printf( "%lld ", z[n-i] );
		}
	}
}

int main(  ) {

	vector< list< int64 > > a;
	int64 n, k, vp, vc;

	input( n, k, vp, vc, a );

	solved( n, vp, vc, k, a );
}