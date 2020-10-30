#include <iostream>
#include <cstdio>

using namespace std;

const int oo = 2000000000;

bool a [20000][20] = {0};
int f [(1<<17)-1][20] = {0};
int c [20][20] = {0};

int m, n;

void input(  ) {

	scanf( "%d %d\n", &m, &n );

	for( int i = 1; i <= m; ++i, scanf( "\n" ) ) {

		char r;
		for( int j = 1; j <= n; ++j ) {

			scanf( "%c", &r );

			a[i][j] = ( r == '1' );
		}
	}
}

void graph(  ) {

	for( int i = 1; i <= n; ++i ) {

		for( int j = i+1; j <= n; ++j ) {

			for( int k = 1; k <= m; ++k ) {

				c[i][j] += a[k][i]^a[k][j];
			}

			c[j][i] = c[i][j];
		}
	}

	for( int i = 1; i <= n; ++i ) {

		for( int j = 1; j <= m; ++j ) {

			c[i][i] += a[j][i];
		}
	}
}

void solve(  ) {

	int g = ( 1<<n ) - 1;

	for( int i = 1; i <= g; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			f[i][j] = oo;
		}
	}

	for( int i = 1; i <= n; ++i ) {

		f[1<<(i-1)][i] = c[i][i];
	}

	for( int i = 1; i <= g; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			if( ((i>>(j-1))&1) == 1 ) {

				int f1 = j-1;
				int f2 = j+1;

				if( f1 >= 1 && ((i>>(f1-1))&1) == 0 ) {

					int w = i|(1<<(f1-1));
					f[w][f1] = min( f[w][f1], f[i][j] + c[f1][f1] );
				}

				if( f2 <= n && ((i>>(f2-1))&1) == 0 ) {

					int w = i|(1<<(f2-1));
					f[w][f2] = min( f[w][f2], f[i][j] + c[f2][f2] );
				}

				for( int k = 1; k <= n; ++k ) {

					if( ((i>>(k-1))&1) == 0 ) {

						int w = i|(1<<(k-1));
						f[w][k] = min( f[w][k], f[i][j] + c[k][j] );
					}
				}
			}
		}
	}

	int kq = oo;
	for( int i = 1; i <= n; ++i ) {

		kq = min( kq, f[g][i] );
	}

	printf( "%d", kq );
}

int main(  ) {

	input(  );

	graph(  );
	solve(  );
}
