#include <iostream>
#include <cstdio>

using namespace std;

void upheap( int* h, int** a, int x ) {

	h[++h[0]] = x;

	int l = h[0];
	int i = l >> 1;

	while( i && a[h[l]][2] < a[h[i]][2] ) {

		swap( h[i], h[l] );

		l = i;
		i >>= 1;
	}
}

int popheap( int* h, int** a ) {

	int v = h[h[0]--];
	int r = 1;
	int c = 1;
	int kq = h[1];

	while( (r << 1) <= h[0] ) {

		c = r << 1;
		if( c < h[0] && a[h[c]][2] > a[h[c+1]][2] ) { ++c; }
		if( a[h[c]][2] >= a[v][2] ) { break; }

		h[r] = h[c];
		r = c;
	}

	h[r] = v;

	return kq;
}

void input( int &n, int &m, int** &a, int* &h ) {

	scanf( "%d%d", &n, &m );

	a = new int* [m];
	h = new int  [m+1];

	h[0] = 0;

	for( int i = 0; i < m; ++i ) {

		a[i] = new int [3];
		scanf( "%d%d%d", &a[i][0], &a[i][1], &a[i][2] );
		upheap( h, a, i );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

void update( int* a, int i, int x ) {

	if( a[i] == i ) { a[i] = x; }
	else {

		update( a, a[i], x );
		a[i] = x;
	}
}

int get( int* a, int i ) {

	if( a[i] != i ) {

		a[i] = get( a, a[i] );
	}

	return a[i];
}

int solved( int n, int* h, int** a ) {

	int w [2000] = {0};
	int kq = 0;

	for( int i = 0; i <= n; w[i] = i++ );

	while( h[0] != 0 ) {

		int t = popheap( h, a );

		int t0 = get( w, a[t][0] );
		int t1 = get( w, a[t][1] );

		int m = MIN( t0, t1 );

		if( t0 != 1 || t1 != 1 ) {

			kq = a[t][2];
		}

		update( w, a[t][0], m );
		update( w, a[t][1], m );
	}

	return kq;
}

int main(  ) {

	int** a;
	int* h;

	int n, m;

	input( n, m, a, h );
	output( solved( n, h, a ) );

	for( int i = 0; i < m; ++i ) {

		delete []a[i];
	}

	delete []a;
	delete []h;
}