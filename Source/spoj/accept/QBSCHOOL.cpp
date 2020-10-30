#include <iostream>
#include <cstdio>
#include <vector>
#include <queue>

using namespace std;

typedef long long int64;
const int64 oo = 1000000000000000000ll;

void input( int64 &n, int64 &m, vector< queue< int64 > > &a ) {

	scanf( "%lld%lld", &n, &m );

	a.resize( n + 1 );
	for( int64 i = 0; i < m; ++i ) {

		int64 k, u, v, l;

		scanf( "%lld%lld%lld%lld", &k, &u, &v, &l );

		a[u].push( v );
		a[u].push( l );

		if( k == 2 ) {

			a[v].push( u );
			a[v].push( l );
		}
	}
}

void upheap( int64* a, int64* d, int64* c, int64 id ) {

	int64 l = d[id];
	int64 i = l >> 1;

	while( i && c[a[l]] < c[a[i]] ) {

		swap( d[a[l]], d[a[i]] );
		swap( a[l], a[i] );

		l = i;
		i >>= 1;
	}
}

int64 popheap( int64* a, int64* d, int64* f ) {

	int64 v = a[a[0]--];
	int64 r = 1;
	int64 c;
	int64 kq = a[1];

	while( (r << 1) <= a[0] ) {

		c = r << 1;
		if( c < a[0] && f[a[c]] > f[a[c+1]] ) { ++c; }
		if( f[a[c]] >= f[v] ) { break; }

		a[r] = a[c];
		d[a[c]] = r;
		r = c;
	}

	a[r] = v;
	d[v] = r;
	
	return kq;
}

void solved( int64 &n, vector< queue< int64 > > &a ) {

	int64 c [10000] = {0};
	int64 d [10000] = {0};
	int64 h [10000] = {0};
	int64 k [10000] = {0};

	for( int64 i = 1; i <= n; ++i ) {

		c[i] = oo;
		d[i] = i;
		h[i] = i;
	}

	h[0] = n;
	c[1] = 0;
	k[1] = 1;

	for( int64 i = popheap( h, d, c ); i != n; i = popheap( h, d, c ) ) {

		while( a[i].size() ) {

			int64 w, r;

			w = a[i].front();
			a[i].pop();

			r = a[i].front();
			a[i].pop();

			int64 t = c[i] + r;

			if( t < c[w] ) {

				c[w] = t;
				k[w] = k[i];
				upheap( h, d, c, w );
			}
			else if( t == c[w] ) {

				k[w] += k[i];
			}
		}
	}

	printf( "%lld %lld", c[n], k[n] );
}

int main(  ) {

	vector< queue< int64 > > a;
	int64 n, m;

	input( n, m, a );
	solved( n, a );
}
