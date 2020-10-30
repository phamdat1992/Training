#include <iostream>
#include <cstdio>

using namespace std;

int f[35][35] = {0};

void init(  ) {

	f[1][0] = 0;
	f[1][1] = 1;
	f[0][0] = 1;
	f[0][1] = 1;

	for( int i = 2; i <= 32; ++i ) {

		f[1][i] = i;
		f[0][i] = 1;
	}

	for( int i = 2; i <= 32; ++i ) {

		f[i][i] = 1;
		for( int j = i+1; j <= 32; ++j ) {

			f[i][j] = f[i][j-1] * ( j );
			f[i][j] /= ( j - i );
		}
	}
}

int solved( int n, int k ) {

	bool r [50] = {0};

	int lenr = 0;
	int s = 0;

	if( k == 1 ) { s = 1; }
	if( k < 0 || n < 0 ) { return 0; }
	if( k == 0 && n == 0 ) { return 0; }
	if( k == 1 && n == 0 ) { return 1; }

	for( lenr = 0; n > 0; r[++lenr] = n&1, n >>= 1 );
	if( k >= lenr ) { return 0; }

	for( int i = k; i < lenr-1; ++i ) {

		s += f[k][i];
	}

	for( int i = lenr-1; i > 0; --i ) {

		if( r[i] == 0 ) { --k; }
		else if( k > 0 ) {

			s += f[k-1][i-1];
		}
	}

	if( k == 0 ) { ++s; }

	return s;
}

int main(  ) {

	init(  );
	for( int n, k; cin>>n>>k; printf( "%d\n", solved( n, k ) ) );
}