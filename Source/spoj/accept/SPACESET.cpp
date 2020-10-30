#include <iostream>
#include <cstdio>

using namespace std;

const long long cs = 12345678ll;

long long pow( long long n, long long m ) {

	if( m == 0 ) { return 1; }
	if( m == 1 ) { return n%cs; }

	long long t = pow( n, m >> 1 );
	
	t *= t;
	t %= cs;

	if( (m&1) == 1 ) { t *= (n%cs); }

	return t%cs;
}

long long solved( long long m, long long n, long long k ) {

	if( m <= 0 || n <= 0 || k <= 0 ) { return 0ll; }

	if( m == 1 && n == 1 ) { return 1ll; }
	if( m == 1 && n == 2 ) { return 2ll; }
	if( m == 1 ) { return ( (n%cs)*pow( 2, k - 1 ) )%cs; }
	if( m == 2 && n == 1 ) { return ( pow( 2, k - 1 ) << 1 )%cs; }
	if( m > 2 && n == 1 ) { return ( ( m%cs )*pow( 3, k - 1 ) )%cs; }
	if( m == 2 && n == 2 ) { return ( pow( 3, k - 1 ) << 2 )%cs; }
	if( m == 2 && n > 2 ) { return ( ((n << 1)%cs)*pow( n + 2, k - 1 ) )%cs; }
	if( m > 2 && n == 2 ) { return ( ((m << 1)%cs)*pow( n+n + 1, k - 1 ) )%cs; }


	return ( ( (m*n)%cs )*pow( (n+n+2)%cs, k - 1 ) )%cs;
}

int main(  ) {

	int t;
	long long m, n, k;

	scanf( "%d", &t );

	for( int i = 0; i < t; ++i ) {

		scanf( "%lld%lld%lld", &m, &n, &k );
		printf( "%lld\n", solved( m, n, k ) );
	}
}