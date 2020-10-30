#include <iostream>
#include <cstdio>

using namespace std;

long long f[300][300] = {0};

void init( int n ) {

	f[n][n] = 1;
	for( int i = n; i >= 0; --i ) {

		for( int j = i; j >= 0; --j ) {

			f[i][j] += f[i+1][j] + f[i][j+1];
		}
	}
}

void problem1( int n ) {

	long long kq = 0;

	int g = ( n << 1 ) + 1;
	
	int x = 0;
	int y = 0;

	int c = 0;

	for( int i = 0, vet; i < g; ++i ) {

		scanf( "%d", &vet );

		if( c + 1 == vet ) {

			++c;
			kq += f[x][y+1];
			++x;
		}
		else if( c - 1 == vet ) {

			--c;
			++y;
		}
	}

	printf( "%lld\n", kq+1 );
}

void problem2( int n ) {

	long long chiso;
	int g = ( n << 1 );

	scanf( "%lld", &chiso );

	int x = 0;
	int y = 0;

	printf( "0 " );

	for( int i = 0, j = 0; i < g; ++i ) {

		if( chiso > f[x][y+1] ) {

			printf( "%d ", ++j );
			chiso -= f[x][y+1];

			++x;
		}
		else {

			printf( "%d ", --j );

			++y;
		}
	}
}

int main(  ) {

	int n;

	scanf( "%d", &n );

	init( n );

	problem1( n );
	problem2( n );
}
