#include <iostream>
#include <cstdio>
#include <queue>

using namespace std;

void input( int &n, int a[100][100] ) {

	scanf( "%d", &n );

	for( int i = 0; i < n; ++i ) {

		for( int j = 0; j < n; ++j ) {

			scanf( "%d", &a[i][j] );
		}
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved( int n, int k, int h, int a[100][100] ) {

	bool f [100][100] = {0};

	queue< int > q;

	q.push( 0 );
	q.push( 0 );

	f[0][0] = 1;

	int m = 200;
	int s = 0;
	bool check = false;

	for( int u, v; !q.empty(); ) {

		u = q.front();
		q.pop();

		v = q.front();
		q.pop();

		m = ( m < a[u][v] )? m : a[u][v];
		s = ( s > a[u][v] )? s : a[u][v];

		if( u == n-1 && v == n-1 ) { check = true; }
		else {

			if( u > 0 && f[u-1][v] == 0 && a[u-1][v] <= k && a[u-1][v] >= h ) {

				q.push( u-1 );
				q.push( v );

				f[u-1][v] = 1;
			}
			if( v > 0 && f[u][v-1] == 0 && a[u][v-1] <= k && a[u][v-1] >= h ) {

				q.push( u );
				q.push( v-1 );

				f[u][v-1] = 1;
			}
			if( u < n-1 && f[u+1][v] == 0 && a[u+1][v] <= k && a[u+1][v] >= h ) {

				q.push( u+1 );
				q.push( v );

				f[u+1][v] = 1;
			}
			if( v < n-1 && f[u][v+1] == 0 && a[u][v+1] <= k && a[u][v+1] >= h ) {

				q.push( u );
				q.push( v+1 );

				f[u][v+1] = 1;
			}
		}
	}

	if( check == false ) { return -1; }
	else { return s-m; }
}

int find( int n, int a[100][100] ) {

	int min = 110;
	for( int f = 0; f <= 110; ++f ) {

		int f1 = 110;
		int f2 = a[0][0];

		for( int mid, g; f1 >= f2; ) {

			mid = ( f1 + f2 )>>1;

			g = solved( n, mid, f, a );

			if( g < 0 ) { f2 = mid + 1; }
			else {

				f1 = mid-1;
				min = ( min < g )? min : g;
			}
		}
	}

	return min;
}

int main(  ) {

	int a [100][100];
	int n;

	input( n, a );
	output( find( n, a ) );
}