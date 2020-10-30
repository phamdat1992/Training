#include <iostream>
#include <cstdio>

using namespace std;

void input( int &n, int &m, int a[200][200], int* f ) {

	scanf( "%d%d", &n, &m );

	for( int i = 1; i <= m; ++i ) {

		scanf( "%d", &f[i] );
	}

	for( int i = 1; i <= n; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			scanf( "%d", &a[i][j] );
		}
	}
}

void floyd( int n, int a[200][200] ) {

	for( int k = 1; k <= n; ++k ) {

		for( int u = 1; u <= n; ++u ) {

			for(  int v = 1; v <= n; ++v ) {

				if( a[u][v] > a[u][k] + a[k][v] ) {

					a[u][v] = a[u][k] + a[k][v];
				}
			}
		}
	}
}

void solved( int n, int m, int a [200][200], int* f ) {

	long long kq = 0;

	for( int i = 1; i < m; ++i ) {

		kq += a[f[i]][f[i+1]];
	}

	if( f[1] != 1 ) { kq += a[1][f[1]]; }
	if( f[m] != n ) { kq += a[f[n]][n]; }

	printf( "%lld", kq );
}

int main(  ) {

	int a [200][200] = {0};
	int f [20000] = {0};

	int n, m;

	input( n, m, a, f );
	floyd( n, a );
	solved( n, m, a, f );
}