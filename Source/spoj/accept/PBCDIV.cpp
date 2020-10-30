#include <iostream>
#include <cstdio>

using namespace std;

void GET_LL( long long &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void output( long long kq ) {

	printf( "%lld\n", kq );
}

long long solved( long long a, long long b ) {

	long long t60 = ( b )/60 - ( a-1 )/60;
	long long t30 = ( b )/30 - ( a-1 )/30;
	long long t12 = ( b )/12 - ( a-1 )/12;

	return t30 + t12 - ( t60 << 1 );
}

int main(  ) {

	long long t;

	GET_LL( t );
	for( long long i = 0, a, b; i < t; ++i ) {

		GET_LL( a );
		GET_LL( b );

		output( solved( a, b ) );
	}
}