#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

const long long cs = 100000000000000000ll;

long long f [251][501][15] = {0};
int g[251][501] = {0};

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

	lenc = ( lena > lenb )? lena : lenb;

	if( t > 0 ) { c[++lenc] = t; }
}

void sub( long long* a, long long* b, long long* c, int &lena, int &lenb, int &lenc ) {

	long long t = 0;

	for( int i = 0; i <= lena || i <= lenb; ++i ) {

		long long f1 = 0;
		long long f2 = 0;

		if( i <= lena ) { f1 = a[i]; }
		if( i <= lenb ) { f2 = b[i]; }

		t = f1 - f2 - t;

		if( t < 0 ) {

			c[i] = t + cs;
			t = 1;
		}
		else {

			c[i] = t;
			t = 0;
		}
	}

	lenc = ( lena > lenb )? lena : lenb;
	for( ; c[lenc] == 0; --lenc );
}

void init( int n ) {

	long long t [15] = {0};
	int lent = 0;

	for( int i = n; i <= ( n << 1 ); f[n][i][0] = 1, ++f[n][0][0], ++i );

	for( int i = n - 1; i > 0; --i ) {

		t[0] = 0;
		lent = 0;

		for( int j = i; j <= ( i<<1 ); ++j ) {

			add( t, f[i+1][j], t, lent, g[i+1][j], lent );
			sub( f[i+1][0], t, f[i][j], g[i+1][0], lent, g[i][j] );

			add( f[i][0], f[i][j], f[i][0], g[i][0], g[i][j], g[i][0] );
		}

		
	}
}

void input( long long* r, int &n ) {

	char s [250] = {0};

	scanf( "%s", s );

	r[0] = 0;
	n = 0;

	long long d = 1;
	for( int i = strlen( s ) - 1; i >= 0; --i, d *= 10 ) {

		if( d < cs ) {

			r[n] += ( long long )( d*( s[i] - '0' ) );
		}
		else {

			r[++n] = ( long long )( s[i] - '0' );
			d = 1;
		}
	}
}

bool bigger( long long* a, long long* b, int lena, int lenb ) {

	if( lena > lenb ) { return true; }
	if( lena < lenb ) { return false; }

	for( int i = lena; i >= 0; --i ) {

		if( a[i] < b[i] ) { return false; }
		if( a[i] > b[i] ) { return true; }
	}

	return false;
}

void solved( int n ) {

	long long r [15] = {0};
	int lenr = 0;

	input( r, lenr );

	for( int i = 1, j = 1; i <= n; ++i, ++j ) {

		for( ; j < ( i << 1 ) && bigger( r, f[i][j], lenr, g[i][j] ); sub( r, f[i][j], r, lenr, g[i][j], lenr ), ++j );

		printf( "%d ", j );
	}
}



int main(  ) {
	
	int n;

	scanf( "%d\n", &n );

	init( n );
	solved( n );
}