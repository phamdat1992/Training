#include <iostream>
#include <cstdio>

using namespace std;

long long f [20] = {0};

void init(  ) {

	f[0] = 1;
	f[1] = 1;

	for( int i = 2; i <= 10; f[i] = f[i-1]*i, ++i );
}

void solved( int n, long long k, long long &g ) {

	g += k/f[n];
	for( int i = 1; i < n; ++i ) {

		solved( n-i, k/f[i], g );
	}
}

int main(  ) {

	long long g = 0;

	init(  );
	for( int n; ( cin>>n ) && n != -1; g = 0 ) {

		solved( n, f[n], g );
		printf( "%lld\n", g );
	}
}