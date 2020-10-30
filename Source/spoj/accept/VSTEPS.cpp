#include <cstdio>
#define cs 14062008

using namespace std;

int main(  ) {

	unsigned long long a [200000];
	bool c [200000];

	int n, k, w;

	scanf( "%d%d", &n, &k );

	for( int i = 0; i < k; ++i ) {

		scanf( "%d", &w );
		c[w] = true;
	}

	a[1] = 1;
	a[2] = ( c[2] == 1 )? 0 : 1;

	for( int i = 3; i <= n; ++i ) {

		if( c[i] == 0 ) {

			if( c[i-1] == 0 ) { a[i] += a[i-1]; }
			if( c[i-2] == 0 ) { a[i] += a[i-2]; }
		}

		a[i] %= cs;
	}

	printf( "%lld", a[n]%cs );
}