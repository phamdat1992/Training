#include <iostream>
#include <cstdio>

using namespace std;

const int oo = 1000000000;

int b[(1<<17)-1][17];

void input( int &n, int a[][17] ) {

	scanf( "%d", &n );

	for( int i = 1; i <= n; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			scanf( "%d", &a[i][j] );
		}
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

int solved( int n, int a[][17] ) {

	int f = (1<<n)-1;

	for( int i = 1; i <= f; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			b[i][j] = oo;
		}
	}

	for( int i = 1; i <= n; ++i ) {

		b[1<<(i-1)][i] = 0;
	}

	for( int i = 1; i <= f; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			if( ((i>>(j-1))&1) == 1 ) {

				for( int k = 1; k <= n; ++k ) {

					if( ((i>>(k-1))&1) == 0 ) {

						int tem = i|(1<<(k-1));
						b[tem][k] = MIN( b[tem][k], b[i][j] + a[j][k] );
					}
				}
			}
		}
	}

	int kq = oo;
	for( int i = 1; i <= n; ++i ) {

		kq = MIN( kq, b[f][i] );
	}

	return kq;
}

int main(  ) {

	int a[17][17];
	int n;

	input( n, a );
	output( solved( n, a ) );
}
