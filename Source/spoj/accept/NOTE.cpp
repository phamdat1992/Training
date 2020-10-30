#include <iostream>
#include <cstdio>

using namespace std;

char solved( int f, int c ) {

	int g = ( 1 << ( f - 1 ) );

	char s = 'D';
	for( int i = g; i != c; ) {

		g >>= 1;

		if( c < i ) {

			i -=g;
			s = 'U';
		}
		else {

			i += g;
			s = 'D';
		}
	}

	return s;
}

int main(  ) {

	for( int f = 1, c = 1; f != 0 && c != 0;  ) {

		scanf( "%d%d", &f, &c );

		if( f != 0 && c != 0 ) {

			printf( "%c\n", solved( f, c ) );
		}
	}
}