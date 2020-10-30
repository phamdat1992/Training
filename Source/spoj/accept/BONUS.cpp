#include <iostream>
#include <cstdio>

using namespace std;

int a [2000][2000];
int n, k;

void input() {

	scanf( "%d%d", &n, &k );

	for( int i = 0; i < n; ++i ) {

		int t = 0;
		for( int j = 0; j < n; ++j ) {

			int u;

			scanf( "%d", &u );

			t += u;
			if( i > 0 ) { a[i][j] = a[i-1][j] + t; }
			else { a[i][j] = t; }
		}
	}
}

int comput( int x1, int y1, int x2, int y2 ) {

	int f1 = 0;
	int f2 = 0;
	int f3 = 0;

	if( x1 > 0 ) { f1 = a[x1-1][y2]; }
	if( y1 > 0 ) { f2 = a[x2][y1-1]; }
	if( x1 > 0 && y1 > 0 ) { f3 = a[x1-1][y1-1]; }

	return a[x2][y2] - f1 - f2 + f3;
}

void solve(  ) {

	int kq = 0;
	for( int i = k - 1; i < n; ++i ) {

		for( int j = k - 1; j < n; ++j ) {

			kq = max( comput( i-k+1, j-k+1, i, j ), kq );
		}
	}

	printf( "%d", kq );
}

int main(  ) {

	input(  );
	solve(  );
}