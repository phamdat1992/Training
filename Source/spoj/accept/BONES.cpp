#include <iostream>
#include <cstdio>

using namespace std;

int solved( int s1, int s2, int s3 ) {

	int f[1000] = {0};

	for( int i = 1; i <= s1; ++i ) {

		for( int j = 1; j <= s2; ++j ) {

			for( int k = 1; k <= s3; ++k ) {

				++f[ i+j+k ];
			}
		}
	}

	int kq = 0;
	for( int i = 1; i < 1000; ++i ) {

		if( f[i] > f[kq] ) { kq = i; }
	}

	return kq;
}

int main(  ) {

	int s1, s2, s3;

	scanf( "%d%d%d", &s1, &s2, &s3 );
	printf( "%d", solved( s1, s2, s3 ) );
}