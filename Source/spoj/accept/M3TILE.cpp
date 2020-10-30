#include <cstdio>

int main(  ) {

	int k [100] = {0};
	int n;

	k[0] = 1;
	k[2] = 3;
	k[4] = 11;

	for( int i = 6; i <= 30; i += 2 ) {

		k[i] = ( k[i-2] << 2 ) - k[i-4];
	}

	scanf( "%d", &n );
	while( n != -1 ) {

		printf( "%d\n", k[n] );
		scanf( "%d", &n );
	}
}