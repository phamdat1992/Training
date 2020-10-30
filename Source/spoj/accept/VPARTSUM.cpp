#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

const int oo = 0x7fffffff;

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

int solved(  ) {

	int n, k, q;
	int kq = oo;

	set<int> s;

	set<int>::const_iterator pos1;
	set<int>::const_iterator pos2;

	scanf( "%d%d%d", &n, &k, &q );
	
	for( int i = 0, a, t = 0; i < n && kq != 0; ++i ) {

		scanf( "%d", &a );

		t = ( t + a)%q;

		int q1 = t - k;
		int q2 = q1 + q;

		if( q1 < 0 ) {

			q1 += q;
			q2 += q;
		}

		pos1 = s.lower_bound( q1 );
		pos2 = s.lower_bound( q2 );

		int f1 = oo;
		int f2 = oo;

		if( pos1 != s.end() ) {

			if( ( *pos1 ) == q1 ) { f1 = 0; }
			else if( pos1 != s.begin() ) { f1 = ( q1 - *( --pos1 ) )%q; }
		}

		if( pos2 != s.end() ) {

			if( ( *pos2 ) == q2 ) { f2 = 0; }
			else if( pos2 != s.begin() ) { f2 = ( q2 - *( --pos2 ) )%q; }
		}

		kq = MIN( kq, MIN( f1, f2 ) );

		s.insert( t );
	}

	return kq + k;
}

int main(  ) {

	printf( "%d", solved(  ) );
}