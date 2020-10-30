#include <iostream>
#include <cstdio>
#include <vector>
#include <list>

using namespace std;

const int oo = 1000000000;

void input( int &n, int &m, vector< list< int > > &a ) {

	scanf( "%d%d", &n, &m );

	a.resize( n + 1 );

	for( int i = 0; i < m; ++i ) {

		int x, y, d;

		scanf( "%d%d%d", &x, &y, &d );

		a[x].push_back( y );
		a[x].push_back( d );

		a[y].push_back( x );
		a[y].push_back( d );
	}
}

void upheap( int* h, int* c, int* g, int d ) {

	int l = c[d];
	int i = l >> 1;

	while( i && g[h[l]] < g[h[i]] ) {

		swap( h[l], h[i] );
		swap( c[h[l]], c[h[i]] );

		l = i;
		i >>= 1;		
	}
}

int popheap( int* h, int* d, int* g ) {

	int kq = h[1];
	int v = h[h[0]--];

	int r = 1;
	int c = 1;

	while( ( r << 1 ) <= h[0] ) {

		c = r << 1;
		if( c + 1 <= h[0] && g[h[c+1]] < g[h[c]] ) { ++c; }
		if( g[h[c]] >= g[v] ) { break; }

		h[r] = h[c];
		d[h[r]] = r;

		r = c;
	}

	h[r] = v;
	d[v] = r;

	return kq;
}

void solved( int n, vector< list< int > > &a, int t, int e, int* d, int* f ) {

	int h [100000] = {0};
	int c [100000] = {0};

	for( int i = 0; i <= n; ++i ) {

		d[i] = oo;
		h[i] = i;
		c[i] = i;
		f[i] = 0;
	}

	d[t] = 0;
	h[0] = n;
	f[t] = 1;

	upheap( h, c, d, t );

	while( h[0] != 0 ) {

		t = popheap( h, c, d );

		for( list< int >::const_iterator pos = a[t].begin(); pos != a[t].end(); ) {

			int w = *(pos++);
			int k = *(pos++);

			if( d[w] > k + d[t] ) {

				d[w] = k + d[t];
				f[w] = f[t];
				upheap( h, c, d, w );
			}
			else if( d[w] == k + d[t] ){

				f[w] += f[t];
			}
		}
	}
}

void output( int n, vector< list< int > > &a ) {

	list< int > kq;

	int d1 [100000] = {0};
	int d2 [100000] = {0};

	int f1 [100000] = {0};
	int f2 [100000] = {0};

	solved( n, a, 1, n, d1, f1 );
	solved( n, a, n, 1, d2, f2 );

	for( int i = 2; i < n; ++i ) {

		if( d1[i] + d2[i] != d1[n] ) {

			kq.push_back( i );
		}
		else if( f1[i] * f2[i] != f2[1] ) {

			kq.push_back( i );
		}
	}

	printf( "%d\n", kq.size() );
	for( list< int >::const_iterator pos = kq.begin(); pos != kq.end(); ++pos ) {

		printf( "%d\n", *pos );
	}
}

int main(  ) {

	vector< list< int > > a;
	int n, m;

	input( n, m, a );
	output( n, a );
}

