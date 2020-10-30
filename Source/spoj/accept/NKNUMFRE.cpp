#include <iostream>
#include <cstdio>

using namespace std;

void input( int &a, int &b ) {

	scanf( "%d%d", &a, &b );
}

void output( int kq ) {

	printf( "%d", kq );
}

int reverse( int x ) {

	int t = 0;

	while( x != 0 ) {

		t *= 10;
		t += ( x % 10 );
		x /= 10;
	}

	return t;
}

int UCLN( int a, int b ) {

	do {

		int r = a % b;
		a = b;
		b = r;
	}
	while( b != 0 );

	return a;
}

int solved( int a, int b ) {

	int kq = 0;
	for( int i = a; i <= b; ++i ) {

		if( UCLN( i, reverse( i ) ) == 1 ) {

			++kq;
		}
	}

	return kq;
}

int main(  ) {

	int a, b;

	input( a, b );
	output( solved( a, b ) );
}