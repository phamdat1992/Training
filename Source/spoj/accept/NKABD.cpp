#include <iostream>
#include <cstdio>

using namespace std;

void input( int &a, int &b ) {

	scanf( "%d%d", &a, &b );
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved( int a, int b ) {

	int w [100001] = {1};

	int f1 = b >> 1;
	for( int i = 2; i <= f1; ++i ) {

		int f2 = b/i;
		for( int j = 2; j <= f2; ++j ) {

			w[i*j] += i;
		}
	}

	int kq = 0;
	for( int i = a; i <= b; ++i ) {

		if( w[i] > i ) {

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