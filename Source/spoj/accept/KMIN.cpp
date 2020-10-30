#include <iostream>
#include <cstdio>

#define _0(x) ( x&0x3ff )
#define _1(x) ( ( x>>10 )&0x3ff )
#define _2(x) ( x>>20 )

using namespace std;

const unsigned Khist = 1024;

struct xy {

	int x;
	int y;
};

void input( int &n, int &m, int &k, int* &a, int* &b ) {

	scanf( "%d%d%d", &n, &m, &k );

	a = new int [n];
	b = new int [m];

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &a[i] );
	}

	for( int i = 0; i < m; ++i ) {

		scanf( "%d", &b[i] );
	}
}

void radixsort( unsigned* a, unsigned* d, int len ) {

	unsigned b0 [Khist] = {0};
	unsigned b1 [Khist] = {0};
	unsigned b2 [Khist] = {0};

	for( int i = 0; i < len; ++i ) {

		++b0[_0( a[i] )];
		++b1[_1( a[i] )];
		++b2[_2( a[i] )];
	}

	{
		unsigned tsum = 0;
		unsigned sum0 = 0, sum1 = 0, sum2 = 0;

		for( int i = 0; i < Khist; ++i ) {

			tsum = sum0 + b0[i];
			b0[i] = sum0 - 1;
			sum0 = tsum;

			tsum = sum1 + b1[i];
			b1[i] = sum1 - 1;
			sum1 = tsum;

			tsum = sum2 + b2[i];
			b2[i] = sum2 - 1;
			sum2 = tsum;
		}
	}

	for( int i = 0; i < len; ++i ) {

		d[++b0[ _0( a[i] ) ]] = a[i];
	}

	for( int i = 0; i < len; ++i ) {

		a[++b1[ _1( d[i] ) ]] = d[i];
	}

	for( int i = 0; i < len; ++i ) {

		d[++b2[ _2( a[i] ) ]] = a[i];
	}
}

void upheap( xy* h, int* a, int* b, xy k, int &len ) {

	h[++len] = k;

	int l = len;
	int i = l >> 1;

	while( i && a[h[l].x] + b[h[l].y] < a[h[i].x] + b[h[i].y] ) {

		swap( h[i], h[l] );

		l = i;
		i >>= 1;
	}
}

xy popheap( xy* h, int* a, int* b, int &len ) {

	xy kq = h[1];
	xy v = h[len--];
	int r = 1;
	int c = 1;

	while( ( r << 1 ) <= len ) {

		c = r << 1;
		if( c + 1 <= len && a[h[c+1].x] + b[h[c+1].y] < a[h[c].x] + b[h[c].y] ) { ++c; }
		if( a[h[c].x] + b[h[c].y] >= a[v.x] + b[v.y] ) { break; }

		swap( h[r], h[c] );
		r = c;
	}

	h[r] = v;

	return kq;
}

void solved( int* a, int* b, int n, int m, int k ) {

	int* d1 = new int [n];
	int* d2 = new int [m];
	xy*  h  = new xy  [200000];

	int l = m;

	radixsort( ( unsigned* )( a ), ( unsigned* )( d1 ), n );
	radixsort( ( unsigned* )( b ), ( unsigned* )( d2 ), m );

	delete []a;
	delete []b;

	for( int i = 0; i < m; ++i ) {

		h[i+1].x = 0;
		h[i+1].y = i;
	}

	for( int i = 0; i < k; ++i ) {

		xy g = popheap( h, d1, d2, l );

		printf( "%d\n", d1[g.x] + d2[g.y] );

		++g.x;

		if( g.x < n ) {

			upheap( h, d1, d2, g, l );
		}
	}

	delete []d1;
	delete []d2;
}

int main() {

	int* a;
	int* b;

	int n, m, k;

	input( n, m, k, a, b );
	solved( a, b, n, m, k );
}