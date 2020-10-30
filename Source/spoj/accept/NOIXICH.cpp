#include <iostream>
#include <cstdio>
#include <queue>
#include <vector>

using namespace std;

void input( int &n, priority_queue< int, vector< int >, greater< int > > &a ) {

	scanf( "%d", &n );

	for( int i = 0, t; i < n; ++i ) {

		scanf( "%d", &t );

		a.push( t );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved( int n, priority_queue< int, vector< int >, greater< int > > &a ) {

	int kq = 0;

	for( int t; n > 0;  ) {

		t = a.top();
		a.pop();

		--n;

		if( t == n - 1 ) { return kq + t; }
		else if( t >= n ) { return kq + n; }
		else if( t < n ) {

			kq += t;
			n -= t;
		}
	}

	return kq;
}

int main(  ) {

	int n;
	priority_queue< int, vector< int >, greater< int > > a;

	input( n, a );
	output( solved( n, a ) );
}