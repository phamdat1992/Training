#include <iostream>
#include <cstdio>

using namespace std;

long solved( long n ) {

	long kq = 0;

	for( long i = 2, t = (i*(i+1))>>1; t <= n; ++i, t = (i*(i+1))>>1 ) {

		if( ( n - t ) % i == 0 ) {

			++kq;
		}
	}

	return kq;
}

int main(  ) {

	long n;

	while( scanf( "%ld", &n ) != EOF ) {

		printf( "%ld\n", solved( n ) );
	}
}