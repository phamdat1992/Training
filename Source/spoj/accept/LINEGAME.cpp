#include <iostream>
#include <cstdio>

using namespace std;

void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void solved(  ) {

	long long* f1;
	long long* f2;

	int n, x, i;

	GET_INT( n );

	f1 = new long long [n];
	f2 = new long long [n];

	GET_INT( x );

	f1[0] = x;
	f2[0] = 0;

	for( i = 1; i < n; ++i ) {

		GET_INT( x );

		f1[i] = max( f1[i-1], ( long long )( x ) );
		f1[i] = max( f1[i], f2[i-1]+x );

		f2[i] = max( f1[i-1] - x, f2[i-1] );
		f2[i] = max( f2[i], 0ll );
	}

	printf( "%lld", max( f1[n-1], f2[n-1] ) );

	delete []f1;
	delete []f2;
}

int main(  ) {

	solved(  );
}