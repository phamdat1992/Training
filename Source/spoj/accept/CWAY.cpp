#include <iostream>
#include <cstdio>

using namespace std;

const long long cs = 100000000000000ll;

long long f [1001][300] = {0};
int g [1001] = {0};

void input( long long &n ) {

	scanf( "%lld", &n );
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

void print( long long* a, int n ) {

	printf( "%lld", a[n] );
	for( int i = n - 1; i >= 0; --i ) {

		for( long long d = cs/10; d > 1 && a[i] < d; d /= 10 ) {

			printf( "0" );
		}

		printf( "%lld", a[i] );
	}
}

void solved( int n ) {

	long long k [300] = {0};
	int lenk = 0;

	k[0] = 1;
	f[0][0] = 1;
	g[0] = 0;

	for( int i = 1; i <= n; ++i ) {

		mul( f[i-1], n-i+1, f[i], g[i-1], g[i] );
		add( k, f[i], k, lenk, g[i], lenk );
	}

	print( k, lenk );
}

int main(  ) {

	long long n;

	input( n );
	solved( n - 2 );
}