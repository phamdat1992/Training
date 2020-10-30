#include <iostream>
#include <cstdio>

long long a [1000][1000] = {0};
long long b [1000][1000] = {0};
long long c [1000][1000] = {0};

bool f [1000][1000] = {0};

int n, k;

void solve(  ) {

	scanf( "%d", &n );

	for( int i = 1; i <= n; ++i ) {

		for( int j = 1; j <= n; ++j ) {

			scanf( "%lld", &a[i][j] );

			b[i][j] = a[i][j] + b[i-1][j];
			c[i][j] = a[i][j] + c[i][j-1];

			if( f[i][j-1] == 0 && (b[i][j]&1) == 0 ) { f[i][j] = 1; }
			else if( f[i-1][j] == 0 && (c[i][j]&1) == 0 ) { f[i][j] = 1; }
			else { f[i][j] = 0; }
		}
	}

	if( f[n][n] == 1 ) { printf( "YES\n" ); }
	else { printf( "NO\n" ); }
}

int main(  ) {

	scanf( "%d", &k );

	for( int i = 0; i < k; ++i ) {

		solve(  );
	}
}