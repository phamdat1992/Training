#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

const long long cs = 1000000000000000ll;

void add( long long* a, long long* b, long long* c, int &lena, int &lenb, int &lenc ) {

	long long t = 0;
	for( int i = 0; i <= lena || i <= lenb; ++i ) {

		long long f1 = 0;
		long long f2 = 0;

		if( i <= lena ) { f1 = a[i]; }
		if( i <= lenb ) { f2 = b[i]; }

		t += f1 + f2;

		c[i] = t%cs;
		t/= cs;
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
}

void mul( long long* a, int b, long long* c, int &lena, int &lenc ) {

	long long t = 0;
	lenc = lena;

	for( int i = 0; i <= lena; ++i ) {

		t += a[i]*b;

		c[i] = t%cs;
		t /= cs;
	}

	if( t > 0 ) { c[++lenc] = t; }
}

void div( long long* a, int b, long long* c, int &lena, int &lenc ) {

	long long t = 0;

	if( b == 0 ) { return; }
	lenc = lena;

	for( int i = lena; i >= 0; --i ) {

		t *= cs;
		t += a[i];

		c[i] = t/b;
		t %= b;
	}

	for( ; c[lenc] == 0; --lenc );
}

void init( long long** f, int* g, int n, int k ) {

	f[0] = new long long[2000];
	f[0][0] = 1;
	g[0] = 0;

	for( int i = 1; i < k; ++i ) {

		f[i] = new long long [2000];

		mul( f[i-1], n - i, f[i], g[i-1], g[i] );
	}
}

void input( long long* &r, int &lenr ) {

	char s [2000] = {0};

	r = new long long [2000];
	lenr = 0;
	r[0] = 0;

	scanf( "%s\n", s );

	long long d = 1;
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

bool bigger( long long* a, long long* b, int lena, int lenb ) {

	if( lena < lenb ) { return false; }
	if( lena > lenb ) { return true; }

	for( int i = lena; i >= 0; --i ) {

		if( a[i] > b[i] ) { return true; }
		if( a[i] < b[i] ) { return false; }
	}

	return false;
}

void cop( long long* &a, long long* &b, int &lena, int &lenb ) {

	b = new long long [2000];
	lenb = lena;

	for( int i = 0; i <= lena; ++i ) {

		b[i] = a[i];
	}
}

void problem1( long long** f, int* g, int n, int k ) {

	int w [200] = {0};

	long long* r;
	long long* t;

	int lenr;
	int lent;

	cop( f[k-1], t, g[k-1], lent );
	input( r, lenr );

	for( int i = 1; i <= k; ++i ) {

		int j = 1;
		for( ; w[j] == 1 ; ++j );

		for( ; bigger( r, t, lenr, lent ) && j <= n; sub( r, t, r, lenr, lent, lenr ) ) {

			++j;
			for( ; w[j] == 1 ; ++j );
		}

		printf( "%d ", j );
		w[j] = 1;

		div( t, n-i, t, lent, lent );
	}

	delete []r;
	delete []t;
}

void print( long long* a, int n ) {

	printf( "%lld", a[n] );

	for( int i = n-1; i >= 0; --i ) {

		for( long long d = cs/10; d > a[i] && d > 1; d /= 10 ) {

			printf( "0" );
		}

		printf( "%lld", a[i] );
	}
}

void problem2( long long** f, int* g, int n, int k ) {

	int w [200] = {0};

	long long* q = new long long [2000];
	long long* t = new long long [2000];

	int lenq = 0;
	int lent = 0;

	q[0] = 1;
	cop( f[k-1], t, g[k-1], lent );

	for( int i = 1, r; i <= k; ++i ) {

		scanf( "%d", &r );
		w[r] = 1;

		int j = 1;
		for( ; w[j] == 1 ; ++j );

		for( ; j < r; add( q, t, q, lenq, lent, lenq ) ) {

			++j;
			for( ; w[j] == 1 ; ++j );
		}

		div( t, n-i, t, lent, lent );
	}

	printf( "\n" );
	print( q, lenq );

	delete []q;
	delete []t;
}

int main(  ) {

	long long** f;
	int* g;

	int n, k;

	scanf( "%d%d\n", &n, &k );

	f = new long long* [ k ];
	g = new int [k];

	init( f, g, n, k );

	problem1( f, g, n, k );
	problem2( f, g, n, k );

	for( int i = 0; i < k; ++i ) {

		delete []f[i];
	}

	delete []f;
	delete []g;
}
