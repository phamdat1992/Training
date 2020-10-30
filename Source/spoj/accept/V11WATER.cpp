#include <iostream>
#include <cstdio>

using namespace std;

void input( long long &n, long long* &a ) {

	scanf( "%lld", &n );

	a = new long long [n];
	for( long long i = 0; i < n; ++i ) {

		scanf( "%lld", &a[i] );
	}
}

void output( long long kq ) {

	printf( "%lld", kq );
}

long long MAX( long long a, long long b ) {

	return ( a > b )? a : b;
}

long long MIN( long long a, long long b ) {

	return ( a < b )? a : b;
}

long long solved( long long n, long long* a ) {

	long long* f1 = new long long [n];
	long long* f2 = new long long [n];

	f1[0] = 0;
	for( long long i = 1; i < n; ++i ) {

		f1[i] = MAX( f1[i-1], a[i-1] );
	}

	f2[n-1] = 0;
	for( long long i = n - 2; i >= 0; --i ) {

		f2[i] = MAX( f2[i+1], a[i+1] );
	}

	long long kq = 0;
	for( long long i = 1; i < n-1; ++i ) {

		long long f = MIN( f1[i], f2[i] );
		kq += ( f > a[i] )? ( f - a[i] ) : 0;
	}

	delete []f1;
	delete []f2;

	return kq;
}

int main(  ) {

	long long* a;
	long long n;

	input( n, a );
	output( solved( n, a ) );

	delete []a;
}