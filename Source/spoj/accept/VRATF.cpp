#include <iostream>
#include <cstdio>

using namespace std;

void input( int &n, int &k ) {

	scanf( "%d%d", &n, &k );
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved( int n, int k ) {

	int t = n + k;
	if( !( t&1 ) && n > ( t >> 1 ) ) {

		t >>= 1;
		return solved( t, k ) + solved( n - t, k );
	}
	else { return 1; }
}

int main(  ) {

	int n, k;

	input( n, k );
	output( solved( n, k ) );
}