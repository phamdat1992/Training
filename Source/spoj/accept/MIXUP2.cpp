#include <cstdio>
#include <cmath>

using namespace std;

long long f[(1<<17)-1][17] = {0};

void input( int &n, int &m, int* a ) {

	scanf( "%d%d", &n, &m );

	for( int i = 1; i <= n; ++i ) {

		scanf( "%d", &a[i] );
	}
}

void output( long long kq ) {

	printf( "%lld", kq );
}

bool check( int a, int b, int s ) {

	return abs( float( a - b ) ) > s;
}

long long solved( int n, int m, int* a ) {

	int g = (1<<n)-1;

	for( int i = 1; i <= n; ++i ) {

		f[1<<(i-1)][i] = 1;
	}

	for( int i = 1; i <= g; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			if( ((i>>(j-1))&1) == 1 ) {

				for( int k = 1; k <= n; ++k ) {

					if( ((i>>(k-1))&1) == 0 && check( a[k], a[j], m ) ) {

						int tem = i|(1<<(k-1));
						f[tem][k] += f[i][j];
					}
				}
			}
		}
	}

	long long kq = 0;
	for( int i = 1; i <= n; ++i ) {

		kq += f[g][i];
	}

	return kq;
}

int main(  ) {

	int a[17];
	int n, m;

	input( n, m, a );
	output( solved( n, m, a ) );
}