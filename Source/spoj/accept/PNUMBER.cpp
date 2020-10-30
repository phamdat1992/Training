#include <iostream>
#include <cstdio>

using namespace std;

void input( int &a, int &b ) {

	scanf( "%d%d", &a, &b );
}

void solved( int a, int b ) {

	int w [200001] = {1};

	for( int i = a; i <=b; ++i ) {

		w[i] = 1;
	}

	w[1] = 0;

	int f1 = b/2;
	for( int i = 2; i <= f1; ++i ) {

		int f2 = b/i;
		for( int j = 2; j <= f2; ++j ) {

			w[i*j] = 0;
		}
	}

	for( int i = a; i <= b; ++i ) {

		if( w[i] ) {

			printf( "%d\n", i );
		}
	}
}

int main(  ) {

	int a, b;

	input( a, b );
	solved( a, b );
}