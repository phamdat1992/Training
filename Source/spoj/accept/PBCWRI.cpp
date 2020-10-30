#include <iostream>
#include <cstdio>

using namespace std;

char s [3000000] = {0};

void thongke( int n, int* c ) {

	for( int i = 0; i < n; ++i ) {

		scanf( "%c", &s[i] );

		++c[s[i]];
	}

	scanf( "\n" );
}

int tinh( int &i, int n, int m, int* c ) {

	int d [255] = {0};

	int kq = 0;
	int f = 0;

	for( int j = 0; i < m; ++i, ++j ) {

		scanf( "%c", &s[j] );

		if( j >= n ) {

			if( --d[s[j-n]] < c[s[j-n]] ) {

				--f;
			}
		}

		if( ++d[s[j]] <= c[s[j]] ) { ++f; }
		else if( c[s[j]] == 0 ) { return kq; }

		if( f == n ) { ++kq; }
	}

	return kq;
}

int solved(  ) {

	int c [255] = {0};
	
	int n, m;

	scanf( "%d%d\n", &n, &m );

	thongke( n, c );

	int kq = 0;
	for( int i = 0; i < m; ++i ) {

		kq += tinh( i, n, m, c );
	}

	return kq;
}

int main(  ) {

	printf( "%d", solved(  ) );
}