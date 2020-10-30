#include <iostream>
#include <cstdio>

using namespace std;

const long long cs = 100000000000000000ll;

long long f [1000][1000] = {0};
int g [1000] = {0};

void input( int &n, int &k ) {

	scanf( "%d%d", &n, &k );
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

	if( t > 0 ) { c[++lenc] = t; }
}

void sub( long long*a, long long* b, long long* c, int &lena, int &lenb, int &lenc ) {

	long long t = 0;
	for( int i = 0; i <= lena || i <= lenb; ++i ) {

		long long f1 = 0;
		long long f2 = 0;

		if( i <= lena ) { f1 = a[i]; }
		if( i <= lenb ) { f2 = b[i]; }

		t = f1 - f2 - t;

		if( t >= 0 ) {

			c[i] = t;
			t = 0;
		}
		else {

			c[i] = t + cs;
			t = 1;
		}
	}

	for( lenc = ( lena > lenb )? lena : lenb; c[lenc] == 0; --lenc );
}

void mul( long long* a, int b, long long* c, int &lena, int &lenc ) {

	long long t = 0;

	lenc = lena;
	for( int i = 0; i <= lena; ++i ) {

		t += a[i]*b;

		c[i] = t%cs;
		t /= cs;
	}

	for( ; t > 0; c[++lenc] = t%cs, t /= cs );
}

void init( int k ) {

	f[1][0] = 1;
	f[k+1][0] = 1;

	for( int i = 2; i <= k; ++i ) {

		mul( f[i-1], 2, f[i], g[i-1], g[i] );
		add( f[k+1], f[i], f[k+1], g[k+1], g[i], g[k+1] );
	}
}

void solved( int n, int k ) {

	if( n <= k + 1 ) { return; }

	for( int i = k + 2; i <= n; ++i ) {

		add( f[i-1], f[i-1], f[i], g[i-1], g[i-1], g[i] );
		sub( f[i], f[i-k-1], f[i], g[i], g[i-k-1], g[i] );
	}
}

void print( long long* a, int n ) {

	printf( "%lld", a[n] );

	for( int i = n - 1; i >= 0; --i ) {

		for( long long d = cs/10; d > 1 && a[i] < d; d /= 10 ) {

			printf( "0" );
		}

		printf( "%lld", a[i] );
	}
}

int main(  ) {

	int n, k;

	input( n, k );
	init( k );
	solved( n, k );
	add( f[n], f[n], f[n], g[n], g[n], g[n] );
	print( f[n], g[n] );
}