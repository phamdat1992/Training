#include <cstdio>
#include <queue>
#include <iostream>

using namespace std;

void input( int &a, int &b ) {

	char c;
	long long f = 0;

	a = 0;
	b = 0xffff;

	for( int i = 0; i < 8; ++i ) {

		for( int j = 0; j < 4; ++j ) {

			cin>>c;

			f <<= 1;
			f |= ( c == '1' );
		}
	}

	b &= f;
	a = f >> 16;
}

void output( int kq ) {

	printf( "%d", kq );
}

void init( int* q, int s[][4] ) {

	q[0] = 0x8000;
	q[1] = 0x4000;
	q[2] = 0x2000;
	q[3] = 0x1000;
	
	q[4] = 0x0800;
	q[5] = 0x0400;
	q[6] = 0x0200;
	q[7] = 0x0100;
	
	q[8] = 0x0080;
	q[9] = 0x0040;
	q[10] = 0x0020;
	q[11] = 0x0010;

	q[12] = 0x0008;
	q[13] = 0x0004;
	q[14] = 0x0002;
	q[15] = 0x0001;

	s[0][0] = 0x0000;
	s[0][1] = 0x0000;
	s[0][2] = 0x4000;
	s[0][3] = 0x0800;

	s[1][0] = 0x0000;
	s[1][1] = 0x8000;
	s[1][2] = 0x2000;
	s[1][3] = 0x0400;

	s[2][0] = 0x0000;
	s[2][1] = 0x4000;
	s[2][2] = 0x1000;
	s[2][3] = 0x0200;

	s[3][0] = 0x0000;
	s[3][1] = 0x0000;
	s[3][2] = 0x2000;
	s[3][3] = 0x0100;

	s[4][0] = 0x8000;
	s[4][1] = 0x0400;
	s[4][2] = 0x0080;
	s[4][3] = 0x0000;

	s[5][0] = 0x4000;
	s[5][1] = 0x0800;
	s[5][2] = 0x0200;
	s[5][3] = 0x0040;

	s[6][0] = 0x2000;
	s[6][1] = 0x0400;
	s[6][2] = 0x0100;
	s[6][3] = 0x0020;

	s[7][0] = 0x0000;
	s[7][1] = 0x1000;
	s[7][2] = 0x0200;
	s[7][3] = 0x0010;

	s[8][0] = 0x0000;
	s[8][1] = 0x0800;
	s[8][2] = 0x0040;
	s[8][3] = 0x0008;

	s[9][0] = 0x0400;
	s[9][1] = 0x0080;
	s[9][2] = 0x0020;
	s[9][3] = 0x0004;

	s[10][0] = 0x0200;
	s[10][1] = 0x0040;
	s[10][2] = 0x0010;
	s[10][3] = 0x0002;

	s[11][0] = 0x0000;
	s[11][1] = 0x0100;
	s[11][2] = 0x0020;
	s[11][3] = 0x0001;

	s[12][0] = 0x0000;
	s[12][1] = 0x0000;
	s[12][2] = 0x0080;
	s[12][3] = 0x0004;

	s[13][0] = 0x0000;
	s[13][1] = 0x0040;
	s[13][2] = 0x0008;
	s[13][3] = 0x0002;

	s[14][0] = 0x0000;
	s[14][1] = 0x0020;
	s[14][2] = 0x0004;
	s[14][3] = 0x0001;

	s[15][0] = 0x0000;
	s[15][1] = 0x0000;
	s[15][2] = 0x0010;
	s[15][3] = 0x0002;
}

int solved( int a, int b ) {

	int f [100000] = {0};
	int q [16];
	int s [16][4];
	int w, e;

	queue<int> g;

	g.push( a );
	g.push( 0 );

	f[a] = 1;
	init( q, s );

	do {

		w = g.front();
		g.pop();

		e = g.front();
		g.pop();

		for( int i = 0; i < 16; ++i ) {

			if( ( w|q[i] ) == w ) {

				int h = w ^ q[i];
				for( int j = 0; j < 4; ++j ) {

					int v = h | s[i][j];
					if( f[v] == 0 ) {

						f[v] = 1;
						g.push( v );
						g.push( e+1 );
					}
				}
			}
		}

	} while( w != b );

	return e;
}

int main(  ) {

	int a, b;

	input( a, b );
	output( solved( a, b ) );
}
