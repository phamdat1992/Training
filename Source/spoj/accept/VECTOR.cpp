#include <iostream>
#include <cstdio>
#include <utility>
#include <set>

using namespace std;

int a [50][2];
int n, v1, v2;

multiset< pair< int, int > > s1;
multiset< pair< int, int > > s2;

void input(  ) {

	scanf( "%d", &n );
	
	for( int i = 0; i < n; ++i ) {

		scanf( "%d %d", &a[i][0], &a[i][1] );
	}

	scanf( "%d %d", &v1, &v2 );
}

void comp( int n, int a[][2], multiset< pair< int, int > > &s ) {

	int f = ( 1<<n )-1;

	for( int i = 0, u, v; i <= f; ++i ) {

		u = 0;
		v = 0;
		for( int k = i, j = 0; k > 0; k >>= 1, ++j ) {

			if( k&1 ) {

				u += a[j][0];
				v += a[j][1];
			}
		}

		s.insert( make_pair( u, v ) );
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved(  ) {

	int kq = 0;

	int d1 = 0;
	int d2 = 0;

	for( ; !s1.empty(); ) {

		int h1 = (*s1.begin()).first;
		int h2 = (*s1.begin()).second;

		int u1 = v1 - h1;
		int u2 = v2 - h2;

		d1 = 0;
		d2 = 0;

		for( multiset< pair< int, int > >::iterator cur = s2.find( make_pair( u1, u2 ) ); cur != s2.end(); s2.erase( cur ), cur = s2.find( make_pair( u1, u2 ) ), ++d1 );
		for( ; !s1.empty() && (*s1.begin()).first == h1 && (*s1.begin()).second == h2; s1.erase( s1.begin() ), ++d2 );

		kq += d1*d2;
	}

	return kq;
}

int main(  ) {

	input(  );

	comp( n>>1, a, s1 );
	comp( ( n>>1 )+(n&1), a+( n>>1 ), s2 );

	output( solved(  ) );
}