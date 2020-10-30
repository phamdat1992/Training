#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

void print_word( char* q, int l ) {

	if( l > 0 ) {

		if( strcmp( q, "k" ) == 0 || strcmp( q, "ko" ) == 0 ) { printf( "khong" ); }
		else if( strcmp( q, "ng" ) == 0 ) { printf( "nguoi" ); }
		else if( strcmp( q, "n" ) == 0 ) { printf( "nhieu" ); }
		else if( strcmp( q, "dc" ) == 0 ) { printf( "duoc" ); }
		else if( strcmp( q, "hok" ) == 0 ) { printf( "khong" ); }
		else if( strcmp( q, "ntn" ) == 0 ) { printf( "nhu the nao" ); }
		else if( strcmp( q, "kq" ) == 0 ) { printf( "ket qua" ); }
		else printf( "%s", q );
	}
}

void solved(  ) {

	char q [1000];
	int l = 0;

	for( char c = getchar_unlocked(); c >= 32 && c <= 126; c = getchar_unlocked() ) {

		q[l] = c;
		q[++l] = 0;

		switch( c ) {

			case 'j':	printf( "gi" );
					l = 0;
					break;

			case 'w':	printf( "qu" );
					l = 0;
					break;

			case 'f':	printf( "ph" );
					l = 0;
					break;

			case 'z':	printf( "d" );
					l = 0;
					break;

			case ' ':	q[--l] = 0;
					print_word( q, l );
					l = 0;
					printf( " " );

					break;
		};
	}

	print_word( q, l );
}

int main(  ) {

	solved(  );
}