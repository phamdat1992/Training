#include <iostream>
#include <cstdio>

using namespace std;

long long input( int &n, int &m, int** &f ) {

	scanf( "%d%d", &n, &m );

	f = new int* [m];

	long long q = 0;
	for( int i = 0; i < m; q += f[i][2], ++i ) {

		f[i] = new int [3];
		scanf( "%d%d%d", &f[i][0], &f[i][1], &f[i][2] );		
	}

	return q;
}

void radixsort( int** f, int* h, int m ) {

	unsigned b[1001] = {0};

	for( int i = 0; i < m; ++i ) {

		++b[f[i][2]];
	}

	unsigned tsum = 0, sum = 0;
	for( int i = 0; i <= 1000; ++i ) {

		tsum = sum + b[i];
		b[i] = sum - 1;
		sum = tsum;
	}

	for( int i = 0; i < m; ++i ) {

		h[++b[f[i][2]]] = i;
	}
}

void output( long long kq ) {

	printf( "%lld", kq );
}

int get( int x, int* g ) {

	if( g[x] != x ) { g[x] = get( g[x], g ); }
	return g[x];
}

void update( int x, int i, int* g ) {

	if( g[x] != x ) { update( g[x], i, g ); }
	g[x] = i;
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

long long solved( long long q, int n, int m, int** f ) {

	long long r = 0;

	int* g = new int [n+1];
	int* h = new int [m];

	radixsort( f, h, m );
	for( int i = 0; i <= n; g[i] = i, ++i );

	for( int t = m - 1; t >= 0; --t ) {

		int f1 = get( f[h[t]][0], g );
		int f2 = get( f[h[t]][1], g );

		if( f1 != f2 ) {

			int m = MIN( f1, f2 );

			update( f[h[t]][1], m, g );
			update( f[h[t]][0], m, g );

			r += f[h[t]][2];
		}
	}

	delete []g;
	delete []h;

	return q - r;
}

int main(  ) {

	int** f;
	int* h;

	int n, m;

	long long q = input( n, m, f );
	output( solved( q, n, m, f ) );

	for( int i = 0; i < m; delete []f[i], ++i );
	delete []f;
}