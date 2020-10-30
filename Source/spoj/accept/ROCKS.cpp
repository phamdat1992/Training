#include <iostream>
#include <cstdio>

using namespace std;

int s [15] = {0};
bool q [15] = {0};

char w [2] = { 'O', 'X' };

int n;

void input(  ) {

	scanf( "%d", &n );
}

void solved(  ) {

	int f = ( 1<<n );
	for( int i = 1; i <= f; ++i ) {

		for( int j = 0; j < n; ++s[j], ++j ) {

			if( s[j] < ( 1<<j ) ) { printf( "%c", w[q[j]] ); }
			else if( s[j] < ( 1<<(j+1) ) ) { printf( "%c", w[!q[j]] ); }
			else {

				s[j] = 0;
				q[j] = !q[j];
				printf( "%c", w[q[j]] );
			}
		}

		printf( "\n" );
	}

	for( int i = 0; i < n; ++i, printf( "O" ) );
}

int main(  ) {

	input(  );
	solved(  );
}