#include <cstdio>

void input( int &k, int &h ) {

	scanf( "%d%d", &k, &h );
}

void solved( int x ) {

	if( x != 0 ) {

		solved( x >> 1 );
		printf( "%d", (x&1) );
	}
}

int main(  ) {

	int k, h;

	input( k, h );
	solved( k );
}