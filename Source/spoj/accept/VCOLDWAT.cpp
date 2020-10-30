#include <iostream>
#include <cstdio>

using namespace std;

int get( int* b, int* a, int x ) {

	if( x != b[x] ) {

		a[x] += get( b, a, b[x] );
		b[x] = x;

	}

	return a[x];
}

int main(  ) {

	int a [200000] = {0};
	int b [200000] = {0};

	int n, m;

	scanf( "%d%d", &n, &m );

	b[1] = 1;
	a[1] = 1;

	for( int i = 0; i < m; ++i ) {

		int r, v1, v2;

		scanf( "%d%d%d", &r, &v1, &v2 );
		
		b[v1] = r;
		b[v2] = r;

		a[v1] = 1;
		a[v2] = 1;
	}

	for( int i = 1; i <= n; ++i ) {

		printf( "%d\n", get( b, a, i ) );
	}
}