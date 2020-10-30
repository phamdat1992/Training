#include <iostream>
#include <cstdio>
#include <queue>
#include <vector>

using namespace std;

typedef long long int64;

void input( int64 &n, priority_queue< int64, vector< int64 >, greater< int64 > > &a ) {

	scanf( "%lld", &n );

	for( int64 i = 0, t; i < n; ++i ) {

		scanf( "%lld", &t );
		a.push( t );
	}
}

int main(  ) {

	int64 n, k;
	int64 kq;

	scanf( "%lld", &k );
	for( int64 i = 0; i < k; ++i ) {

		priority_queue< int64, vector< int64 >, greater< int64 > > a;

		input( n, a );
		kq = 0;

		while( a.size() > 1 ) {

			int64 w;

			w = a.top();
			a.pop();

			w += a.top();
			a.pop();

			a.push( w );
			kq += w;
		}

		printf( "%lld\n", kq );
	}
}