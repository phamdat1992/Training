#include <iostream>
#include <cstring>
#include <cstdio>

using namespace std;

int a [20000][2] = {0};
int f [50] = {0};

char s [20000] = {0};

void solve(  ) {

	scanf( "%s", s );

	int len = strlen( s );

	for( int i = 0; i < len; ++i ) {

		++f[int( s[i] - 'a' )];
	}


	for( int i = 1; i <= len; ++i ) {

		int k = i;
		for( ; k && k%2 == 0; k /= 2, ++a[i][0] );
		for( ; k && k%5 == 0; k /= 5, ++a[i][1] );

		a[i][0] += a[i-1][0];
		a[i][1] += a[i-1][1];
	}

	int f1 = a[len][0];
	int f2 = a[len][1];

	for( int i = 0; i < 50; ++i ) {

		f1 -= a[f[i]][0];
		f2 -= a[f[i]][1];
	}

	printf( "%d", min( f1, f2 ) );
}

int main(  ) {

	solve(  );
}