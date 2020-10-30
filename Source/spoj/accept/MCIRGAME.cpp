#include <iostream>
#include <cstdio>

using namespace std;

const long long cs = 10000000000000ll;

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

void div( long long* a, int b, long long* c, int &lena, int &lenc ) {

	long long t = 0;
	lenc = lena;

	for( int i = lena; i >= 0; --i ) {

		t *= cs;
		t += a[i];

		c[i] = t/b;
		t %= b;
	}

	for( ; c[lenc] == 0; --lenc );
}

void init( long long f[200][200], int g[200] ) {

	f[0][0] = 1;
	f[1][0] = 1;

	g[0] = 0;
	g[1] = 0;

	for( int i = 2; i <= 150; ++i ) {

		int j = i - 1;
		mul( f[i-1], (( j<<1 )+1)*((j<<1)+2), f[i], g[i-1], g[i] );
		div( f[i], ( j+1 )*( j+2 ), f[i], g[i], g[i] );
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

	long long f [200][200] = {0};
	int g [200] = {0};

	init( f, g );
	for( int n; ( cin>>n ) && n != -1; ) {

		print( f[n], g[n] );
		printf( "\n" );
	}
}