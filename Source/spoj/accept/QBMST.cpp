#include <iostream>
#include <cstdio>

using namespace std;

void upheap( int** a, int* h, int i ) {

	int l = ++h[0];
	int t = l >> 1;

	h[l] = i;

	while( t && a[h[l]][2] < a[h[t]][2] ) {

		swap( h[t], h[l] );

		l = t;
		t = l >> 1;
	}
}

int popheap( int* h, int** a ) {

	int kq = h[1];
	int r = 1;
	int v = h[h[0]--];

	while( r << 1 <= h[0] ) {

		int c = r << 1;
		if( c < h[0] && a[h[c+1]][2] < a[h[c]][2] ) { ++c; }
		if( a[h[c]][2] >= a[v][2] ) { break; }

		h[r] = h[c];
		r = c;
	}

	h[r] = v;
	return kq;
}

void input( int &v, int &e, int** &a, int* &h ) {

	scanf( "%d%d", &v, &e );

	a = new int* [e];
	h = new int  [e];
	h[0] = 0;

	for( int i = 0; i < e; ++i ) {

		a[i] = new int [3];
		scanf( "%d%d%d", &a[i][0], &a[i][1], &a[i][2] );
		upheap( a, h, i );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int get( int i, int* w ) {

	if( w[i] == i ) return i;
	else {

		w[i] = get( w[i], w );
		return w[i];
	}
}

void update( int i, int x, int* w ) {

	if( w[i] == i ) { w[i] = x; }
	else {

		update( w[i], x, w );
		w[i] = x;
	}
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

int solved( int v, int e, int** a, int* h ) {

	int* w = new int [v+1];

	for( int i = 0; i <= v; ++i ) {

		w[i] = i;
	}	

	int kq = 0;
	int d = 0;

	for( ; d < v-1 && h[0] > 0; ) {

		int f = popheap( h, a );
		
		int g0 = get( a[f][0], w );
		int g1 = get( a[f][1], w );

		if( g0 != g1 ) {

			++d;
			kq += a[f][2];

			int m = MIN( g0, g1 );

			update( a[f][0], m, w );
			update( a[f][1], m, w );
		}
	}

	delete []w;

	if( d == v-1 ) { return kq; }
	else { return 0; }
}

int main(  ) {

	int** a;
	int* h;

	int v, e;

	input( v, e, a, h );
	output( solved( v, e, a, h ) );
}
