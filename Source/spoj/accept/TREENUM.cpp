#include <iostream>
#include <cstdio>

using namespace std;

const int cs = 1000000;

void multiply( long long* a, long long* b, long long m, int &lena, int &lenb ) {

	long long t = 0;
	for( int i = 0; i <= lena; ++i ) {

		t += a[i]*m;
		b[i] = t%cs;
		t /= cs;
	}

	for( lenb = lena; t > 0; t /= cs ) {

		b[++lenb] = t%cs;
	}
}

void add( long long* a, long long* b, long long* c, int &lena, int &lenb, int &lenc ) {

	long long t = 0;
	for( int i = 0; i <= lena || i <= lenb; ++i ) {

		long long f1 = 0;
		long long f2 = 0;

		if( i <= lena ) { f1 = a[i]; }
		if( i <= lenb ) { f2 = b[i]; }

		t += f1 + f2;

		c[i] = t%cs;
		t /= cs;
	}

	lenc = ( lena > lenb )? lena: lenb;

	if( t > 0 ) { c[++lenc] = t; }
}

void init( long long s[100][1000], int* f ) {

	f[0] = 0;
	s[0][0] = 1;

	for( int i = 1; i <= 65; ++i ) {

		multiply( s[i-1], s[i], 3, f[i-1], f[i] );
	}
}

void input( int &n ) {

	scanf( "%d", &n );
}

void print( long long* a, int len ) {

	for( int i = len; i >= 0; --i ) {

		if( i != len ) {

			for( int j = 10; j < cs; j *= 10 ) {

				if( a[i] < j ) { printf( "0" ); }
			}
		}

		printf( "%lld", a[i] );
	}
}

void solved( int n, long long s[100][1000], int* f ) {

	unsigned long long a;
	for( int i = 0; i < n; ++i ) {

		long long kq[1000] = {0};
		int len = 0;

		scanf( "%llu", &a );

		for( int j = 0; j <= 65 && a > 0; a >>= 1, ++j ) {

			if( (a&1) ) {

				add( s[j], kq, kq, f[j], len, len );
			}
		}

		print( kq, len );
		printf( "\n" );
	}
}

int main(  ) {

	long long s[100][1000] = {0};
	int f [100] = {0};

	int n;

	input( n );
	init( s, f );

	solved( n, s, f );
}