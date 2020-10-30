#include <iostream>
#include <cstdio>

using namespace std;

const long long cs = 1000000000ll;

long long f [1000001] = {0};

void input( int &n, int &k ) {

	scanf( "%d%d", &n, &k );
}

void output( long long kq ) {

	printf( "%lld", kq );
}

void init( int k ) {

	f[1] = 1;
	f[k + 1] = 1;

	for( int i = 2; i <= k; ++i ) {

		f[i] = f[i-1]<<1;
		f[i] %= cs;

		f[k+1] += f[i];
		f[k+1] %= cs;
	}
}

long long solved( int n, int k ) {

	for( int i = k + 2; i <= n; ++i ) {

		f[i] = f[i-1] << 1;
		f[i] %= cs;

		f[i] -= f[i-k-1];

		if( f[i] < 0 ) { f[i] += cs; }
	}

	return (f[n]<<1)%cs;
}

int main(  ) {

	int n, k;

	input( n, k );
	init( k );
	output( solved( n, k ) );
}