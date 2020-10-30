#include <iostream>
#include <cstdio>

using namespace std;

const long long cs = 1000000000000000ll;

long long f [600][200] = {0};
int g [600] = {0};
int v [600] = {0};

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

void init(  ) {

	f[0][0] = 0;
	f[1][0] = 1;
	f[2][0] = 2;

	v[0] = 1;
	v[1] = 1;
	v[2] = 1;
}

void solved( int n ) {

	long long h [200] = {0};

	int lenh = 0;

	if( v[n] == 1 ) { return; }

	v[n] = 1;

	if( v[n-1] == 0 ) { solved( n - 1 ); }
	if( v[n-2] == 0 ) { solved( n - 2 ); }

	mul( f[n-2], n - 1, h, g[n-2], lenh );
	add( f[n-1], h, f[n], g[n-1], lenh, g[n] );
}

int main(  ) {

	int n;

	scanf( "%d", &n );

	init(  );
	solved( n );
	print( f[n], g[n] );
}