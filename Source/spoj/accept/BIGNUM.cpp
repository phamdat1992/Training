#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

const long long cs = 10000;

void input( char* a, char* b ) {

	scanf( "%s\n%s", a, b );
}

void toArr( char* a, long long* s, int &n ) {

	n = 0;
	long long d = 1;
	for( int i = strlen( a ) - 1; i >= 0; --i, d *= 10 ) {

		
		if( d < cs ) {

			s[n] += d*( long long )( a[i] - '0' );
		}
		else {

			d = 1;
			s[++n] = ( long long )( a[i] - '0' );
		}
	}
}

int comp( char* a, char* b ) {

	if( strlen( a ) < strlen( b ) ) { return -1; }
	else if( strlen( a ) > strlen( b ) ) { return 1; }
	else { return strcmp( a, b ); }
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

	lenc = ( lena > lenb )? lena : lenb;

	if( t != 0 ) { c[++lenc] = t; }
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

			t += cs;
			c[i] = t;
			t = 1;
		}
		else {

			c[i] = t;
			t = 0;
		}
	}

	lenc = ( lena > lenb ) ? lena : lenb;

	for( ; c[lenc] == 0 && lenc > 0; --lenc );
}

void mul( long long* a, long long* b, long long* c, int &lena, int &lenb, int &lenc ) {

	for( int i = 0; i <= lena; ++i ) {

		for( int j = 0; j <= lenb; ++j ) {

			c[i+j] += a[i]*b[j];
		}
	}

	
	long long t = 0;
	for( lenc = 0; lenc <= lena + lenb; ++lenc ) {

		t += c[lenc];
		c[lenc] = t%cs;
		t /= cs;
	}

	if( lenc > 0 ) { --lenc; }

	for( ; t > 0; t /= cs ) {

		c[++lenc] = t%cs;
	}
	for( ; c[lenc] == 0 && lenc > 0 ; --lenc );
}

void print( long long* s, int n ) {

	for( int i = n; i >= 0; --i ) {

		if( i != n ) {

			if( s[i] < 10 ) { printf( "0" ); }
			if( s[i] < 100 ) { printf( "0" ); }
			if( s[i] < 1000 ) { printf( "0" ); }
		}

		printf( "%lld", s[i] );
	}
}

int main(  ) {

	long long a [2000] = {0};
	long long b [2000] = {0};

	long long c [2000] = {0};
	long long t [2000] = {0};
	long long n [2000] = {0};

	char s1 [2000] = {0};
	char s2 [2000] = {0};

	int lena = 0;
	int lenb = 0;
	int lenc = 0;
	int lent = 0;
	int lenn = 0;

	input( s1, s2 );

	toArr( s1, a, lena );
	toArr( s2, b, lenb );

	int ss = comp( s1, s2 );

	add( a, b, c, lena, lenb, lenc );
	print( c, lenc );

	printf( "\n" );
	if( ss < 0 ) {

		printf( "-" );
		sub( b, a, t, lenb, lena, lent );
	}
	else if( ss > 0 ) { sub( a, b, t, lena, lenb, lent ); }
	print( t, lent );

	printf( "\n" );
	mul( a, b, n, lena, lenb, lenn );
	print( n, lenn );
}