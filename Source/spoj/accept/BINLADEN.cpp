#include <iostream>
#include <cstdio>
#include <vector>
#include <list>

using namespace std;

const int oo = 2000000000;

int v [1000000];
int d [1000000];
int h [1000000];

vector< list< int > > a;

int n, m, rt;

void input(  ) {

	scanf( "%d %d", &n, &m );

	rt = m*( n+1 );
	a.resize( rt+1 );

	for( int i = 0, r, f1 = 0, f2 = m; i < n; ++i, f1 = f2, f2 += m ) {

		for( int j = 1; j <= m; ++j ) {

			scanf( "%d", &r );

			a[f1+j].push_back( f2+j );
			a[f1+j].push_back( r );

			a[f2+j].push_back( f1+j );
			a[f2+j].push_back( r );
		}

		for( int j = 1; j < m; ++j ) {

			scanf( "%d", &r );

			a[f2+j].push_back( f2+j+1 );
			a[f2+j].push_back( r );

			a[f2+j+1].push_back( f2+j );
			a[f2+j+1].push_back( r );
		}
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

void upheap( int u ) {

	int l = d[u];
	int i = l >> 1;

	while( i &&  v[h[l]] < v[h[i]] ) {

		swap( h[i], h[l] );

		d[h[i]] = i;
		d[h[l]] = l;

		l = i;
		i >>= 1;
	}
}

int popheap(  ) {

	int kq = h[1];

	int s = h[h[0]--];

	int r = 1;
	int c = 1;

	while( ( r<<1 ) <= h[0] ) {

		c = r << 1;

		if( c < h[0] && v[h[c+1]] < v[h[c]] ) { ++c; }
		if( v[h[c]] >= v[s] ) { break; }

		h[r] = h[c];
		d[h[r]] = r;

		r = c;
	}

	h[r] = s;
	d[s] = r;

	return kq;
}

void init(  ) {

	for( int i = 1; i < m; ++i ) {

		a[i].push_back( i+1 );
		a[i].push_back( 0 );

		a[i+1].push_back( i );
		a[i+1].push_back( 0 );
	}

	for( int i = 0; i <= rt; ++i ) {

		d[i] = h[i] = i;
		v[i] = oo;
	}

	h[0] = rt;
	v[0] = 0;
	v[1] = 0;
}

int solved(  ) {

	for( int u = 1; h[0] > 0 && u != rt; ) {

		u = popheap(  );

		for( list< int >::const_iterator pos = a[u].begin(); pos != a[u].end(); ) {

			int f = *(pos++);
			int l = *(pos++);

			if( v[f] > v[u] + l ) {

				v[f] = v[u]+l;
				upheap( f );
			}
		}
	}

	return v[rt];
}

int main(  ) {

	input(  );

	init(  );
	output( solved(  ) );
}