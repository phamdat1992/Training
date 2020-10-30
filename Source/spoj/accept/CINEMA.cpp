#include <iostream>
#include <cstdio>

using namespace std;

int s [1000][1000];

void input( int &n, int &m, int &f, int* &a ) {

	scanf( "%d %d %d\n", &n, &m, &f );

	a = new int [f+1];

	int t = 0;
	for( int i = 1; i <= f; ++i ) {

		scanf( "%d", &a[i] );

		t += a[i];
	}

	a[0] = m*n - t;
}

void output( int n, int m ) {

	for( int i = 0; i < n; ++i ) {

		for( int j = 0; j < m; ++j ) {

			printf( "%d ", s[i][j] );
		}

		printf( "\n" );
	}
}

void solved( int n, int m, int f, int* a ) {

	for( int i = 0, d = 0; i < n; ++i ) {

		if( (i&1) == 0 ) {

			for( int j = 0; j < m; ++j, --a[d] ) {

				for( ; a[d] == 0; ++d );

				s[i][j] = d;
			}
		}
		else {

			for( int j = m - 1; j >= 0; --j, --a[d] ) {

				for( ; a[d] <= 0; ++d );

				s[i][j] = d;
			}
		}
	}
}

int main(  ) {

	int* a;
	int n, m, f;

	input( n, m, f, a );
	solved( n, m, f, a );
	output( n, m );

	delete []a;
}