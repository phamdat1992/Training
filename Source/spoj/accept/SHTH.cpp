#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

const long long cs = 10000;

long long* add( long long* a, long long* b, long long* c, int &lena, int &lenb, int &lenc ) {

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

	return c;
}

long long* sub( long long* a, long long* b, long long* c, int &lena, int &lenb, int &lenc ) {

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

	lenc = ( lena > lenb )? lena : lenb;
	for( ; c[lenc] == 0; --lenc );

	return c;
}

long long* mul( long long* a, int b, long long* c, int &lena, int &lenc ) {

	long long t = 0;

	if( b == 0 ) { return c; }

	lenc = lena;
	for( int i = 0; i <= lena; ++i ) {

		t += a[i]*b;

		c[i] = t%cs;
		t /= cs;
	}

	if( t > 0 ) { c[++lenc] = t; }

	return c;
}

long long* div( long long* a, int b, long long* c, int &lena, int &lenc ) {

	long long t = 0;

	if( b == 0 ) { return c; }

	lenc = lena;
	for( int i = lena; i >= 0; --i ) {

		t *= cs;
		t += a[i];

		c[i] = t/b;
		t %= b;
	}

	for( ; c[lenc] == 0; --lenc );

	return c;
}

void init( long long** f, int* g, int k, int n ) {

	f[0] = new long long [2000];

	f[0][0] = 1;
	g[0] = 0;

	for( int i = 1; i < k; ++i ) {

		f[i] = new long long [2000];

		f[i] = mul( f[i-1], n - i, f[i], g[i-1], g[i] );
		f[i] = div( f[i], i, f[i], g[i], g[i] );
	}
}

void cop( long long* &a, long long* &b, int &lena, int &lenb ) {

	b = new long long [2000];
	lenb = lena;

	for( int i = 0; i <= lena; ++i ) {

		b[i] = a[i];
	}
}

bool bigger( long long* a, long long* b, int lena, int lenb ) {

	if( lena > lenb ) { return true; }
	if( lena < lenb ) { return false; }

	for( int i = lena; i >= 0; --i ) {

		if( a[i] > b[i] ) { return true; }
		if( a[i] < b[i] ) { return false; }
	}

	return false;
}

void input( long long* &r, int &lenr ) {

	char s [2000];
	long long d = 1;

	scanf( "%s\n", s );
	
	lenr = 0;
	r = new long long [2000];
	r[0] = 0;

	for( int i = strlen( s ) - 1; i >= 0; --i, d *= 10 ) {

		if( d < cs ) {

			r[lenr] += ( long long )( d*( s[i] - '0' ) );
		}
		else {

			r[++lenr] = ( long long )( s[i] - '0' );
			d = 1;
		}
	}
}

void print( long long* a, int n ) {

	for( int i = n; i >= 0 ; --i ) {

		if( i != n ) {

			for( long long d = cs/10; a[i] < d && d > 1; d /= 10 ) {

				printf( "0" );
			}
		}

		printf( "%lld", a[i] );
	}
}

void problem1( long long** f, int* g, int k, int n ) {

	long long* r;
	long long* t;

	int lenr;
	int lent;

	cop( f[k-1], t, g[k-1], lent );
	input( r, lenr );

	for( int i = 1, d = 1; i <= k; ++i ) {

		for(  ; bigger( r, t, lenr, lent ); sub( r, t, r, lenr, lent, lenr ), div( mul( t, ( n - d - k + i ), t, lent, lent ), ( n - d ), t, lent, lent ), ++d );

		div( mul( t, ( k - i ), t, lent, lent ), ( n - d ), t, lent, lent );
		printf( "%d ", d++ );
	}

	delete []r;
	delete []t;
}

void problem2( long long** f, int* g, int k, int n ) {

	long long* kq = new long long [2000];
	long long* t;

	long long zero[1] = {0};

	int lenkq = 0;
	int lent = 0;

	cop( f[k-1], t, g[k-1], lent );
	kq[0] = 1;

	for( int i = 1, d = 1, r; i <= k; ++i, ++d ) {

		scanf( "%d", &r );

		for( ; d < r; add( kq, t, kq, lenkq, lent, lenkq ), div( mul( t, ( n - d - k + i ), t, lent, lent ), ( n - d ), t, lent, lent ), ++d );

		t = div( mul( t, ( k - i ), t, lent, lent ), ( n - d ), t, lent, lent );
	}

	printf( "\n" );
	print( kq, lenkq );

	delete []t;
	delete []kq;
}

int main(  ) {

	int n, k;

	scanf( "%d%d\n", &n, &k );

	long long** f = new long long* [k];
	int* g = new int [n];

	init( f, g, k, n );

	problem1( f, g, k, n );
	problem2( f, g, k, n );

	for( int i = 0; i < k; ++i ) {

		delete []f[i];
	}

	delete []f;
	delete []g;
}