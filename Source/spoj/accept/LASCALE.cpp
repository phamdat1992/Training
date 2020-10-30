#include <iostream>
#include <cstdio>
#include <queue>

using namespace std;

const long long cs = 3ll;

void input( long long &n ) {

	scanf( "%lld", &n );
}

void solved( long long n ) {

	queue< long long > q1;
	queue< long long > q2;

	for( long long t = 1, r = 0, s = 0; n > 0 || r > 0; t += t<<1 ) {

		s = n%cs;
		s += r;

		if( s == 3 ) {

			s = 0;
			r = 1;
		}

		n /= cs;

		if( s == 1 ) {

			r = 0;
			q2.push( t );
		}
		else if( s == 2 ) {

			r = 1;
			q1.push( t );
		}
	}

	printf( "%d ", q1.size() );
	for( ; q1.size() > 0; q1.pop() ) {

		printf( "%lld ", q1.front() );
	}

	printf( "\n%d ", q2.size() );
	for( ; q2.size() > 0; q2.pop() ) {

		printf( "%lld ", q2.front() );
	}
}

int main(  ) {

	long long n;

	input( n );
	solved( n );
}