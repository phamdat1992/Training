#include <iostream>
#include <cstdio>

using namespace std;

const int oo = 1000000000;

void input( int &n, int &m, int &k, int c[][200] ) {

	scanf( "%d%d%d", &n, &m, &k );

	for( int i = 1; i <= n; ++i ) {

		for( int j = 0; j <= n; ++j ) {

			if( i == j ) { c[i][j] = 0; }
			else { c[i][j] = oo; }
		}
	}

	for( int i = 0; i < m; ++i ) {

		int w, e, r;

		scanf( "%d%d%d", &w, &e, &r );
		c[w][e] = r;
		c[e][w] = r;
	}
}

void output1( int kq ) {

	printf( "%d", kq );
}

void output2( int a[][200], int t, int e, int k ) {

	if( e == t ) {

		printf( "%d %d", k, t );
	}
	else {

		output2( a, t, a[e][t], k + 1 );
		printf( " %d", e );
	}
}

void floyd( int n, int c[][200], int d[][200] ) {

	for( int i = 1; i <= n; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			d[i][j] = j;
		}
	}

	for( int i = 1; i <= n; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			for( int g = 1; g <= n; ++g ) {

				if( c[i][g] + c[j][i] < c[j][g] ) {

					c[j][g] = c[i][g] + c[j][i];
					d[j][g] = d[j][i];
				}
			}
		}
	}
}

void solved( int n, int k, int c[][200], int d[][200] ) {

	floyd( n, c, d );

	for( int i = 0; i < k; ++i ) {

		int w, e, r;

		scanf( "%d%d%d", &w, &e, &r );

		if( w == 0 ) {

			output1( c[e][r] );
		}
		else {

			output2( d, e, r, 1 );
		}

		printf( "\n" );		
	}
}

int main(  ) {

	int c[200][200];
	int d[200][200];

	int n, m, k;

	input( n, m, k, c );
	solved( n, k, c, d );
}