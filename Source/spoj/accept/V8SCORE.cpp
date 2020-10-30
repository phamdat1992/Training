#include <iostream>
#include <cstdio>
#include <list>

using namespace std;

int k [30] = {0};
bool f = false;

int a[30][30] = {0};
int n, m, s;
int lenk = 0;

void input(  ) {

	scanf( "%d%d%d", &s, &n, &m );

	for( int i = 0; i < m; ++i ) {

		for( int j = 0; j < n; ++j ) {

			scanf( "%d", &a[i][j] );
		}
	}
}

void solved( int u, int w, int z ) {

	k[lenk++] = u;
	
	if( w == n && z == s ) { f = true; }

	for( int i = 0; w < n && i < m && f == false; ++i ) {

		if( a[i][w] >= u && z + a[i][w]*( n-w ) <= s ) {

			solved( a[i][w], w+1, z + a[i][w] );
		}
	}

	if( f == false ) { --lenk; }
}

int main(  ) {

	input(  );

	for( int i = 0; i < m && f == false; ++i ) {

		if( a[i][0]*( n ) <= s ) {

			solved( a[i][0], 1, a[i][0] );
		}
	}

	if( lenk == 0 ) { printf( "NO" ); }
	else {

		printf( "YES\n" );
		for( int i = 0; i < lenk; ++i ) {

			printf( "%d ", k[i] );
		}
	}
}