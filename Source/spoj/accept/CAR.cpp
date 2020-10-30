#include <iostream>
#include <cstdio>
#include <queue>

using namespace std;

class CAR {

	private:
		int x, y, f;

	public:
		CAR( int g, int a, int b ) { 

					x = a;
					y = b;
					f = g;
				}

		int getx(  ) const { return x; }
		int gety(  ) const { return y; }
		int getf(  ) const { return f; }

		bool operator < ( CAR const &scr ) const {

					return ( ( x*y + scr.x*( y + scr.y ) ) > ( scr.x*scr.y + x*( y + scr.y ) ) );
				}
};

void input( int &n, priority_queue< CAR > &s ) {

	int a [20000];
	int b [20000];

	scanf( "%d", &n );

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &a[i] );
	}

	for( int i = 0; i < n; ++i ) {

		scanf( "%d", &b[i] );
	}

	for( int i = 0; i < n; ++i ) {

		s.push( CAR( i+1, a[i], b[i] ) );
	}
}

long long solved( priority_queue< CAR > &s ) {

	long long kq = 0;
	long long ti = 0;

	queue< int > r;

	while( s.size() > 0 ) {

		ti += s.top().gety();
		kq += ti*s.top().getx();

		r.push( s.top().getf() );
		s.pop();
	}

	printf( "%lld\n", kq );

	for( ; r.size() > 0; r.pop() ) {

		printf( "%d ", r.front() );
	}
}

int main(  ) {

	priority_queue< CAR > s;
	int n;

	input( n, s );
	solved( s );
}