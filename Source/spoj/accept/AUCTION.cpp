#include <cstdio>
#include <queue>

using namespace std;

void input( int &n, int &m, priority_queue< int > &a ) {

	scanf( "%d%d", &n, &m );

	for( int i = 0, t; i < m; ++i ) {

		scanf( "%d", &t );

		a.push( t );
	}
}

void solved( int n, int m, priority_queue< int > &a ) {

	int f1 = 0;
	int f2 = 0;

	int k1 = 0;
	int k2 = 0;

	for( ; f1 <= m && f1 <= n; ) {

		if( f2*f1 >= k2 ) {

			k2 = f1*f2;
			k1 = f2;
		}

		if( a.size() ) {

			for( f2 = a.top(); a.size() > 0 && a.top() == f2; ++f1, a.pop() );
		}
		else { break; }
	}

	printf( "%d %d", k1, k2 );
}

int main(  ) {

	priority_queue< int > a;
	int n, m;

	input( n, m, a );
	solved( n, m, a );
}