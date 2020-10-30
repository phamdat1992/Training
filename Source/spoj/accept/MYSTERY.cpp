#include <iostream>
#include <cstdio>
#include <cmath>

using namespace std;

const long long cs = 20122007ll;

void input( long long &n ) {

	scanf( "%lld", &n );
}

void output( long long kq ) {

	printf( "%lld", kq );
}

long long mu( long long x ) {

	if( x == 1 ) { return 3ll; }
	else {

		long long k = mu( x>>1 );

		k *= k;
		k %= cs;

		if( (x|1) == x ) {

			k *= 3;
			k%= cs;
		}

		return k;
	}

}

long long solved( long long n ) {

	long long t = 1;
	long long k = 1;

	if( n == 1 ) { return 2ll; }

	long long f = ( long long )( sqrt( floor( n ) ) );

	for( int i = 1; i < f; ++i ) {

		if( n % i == 0 ) {

			t = mu( i ) - 1;

			k *= ( t >= 0 )? ( t ) : ( t + cs );
			k %= cs;
		}

		if( n % (n/i) == 0 ) {

			t = mu( n/i ) - 1;

			k *= ( t >= 0 )? ( t ) : ( t + cs );
			k %= cs;
		}
	}

	if( f*f == n ) {

		t = mu( f ) - 1;

		k *= ( t >= 0 )? ( t ) : ( t + cs );
		k %= cs;
	}

	return k;
}

int main(  ) {

	long long n;

	input( n );
	output( solved( n ) );
}