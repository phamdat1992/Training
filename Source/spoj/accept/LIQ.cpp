#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

int main(  ) {

	long long n;

	set< long long > g;
	set< long long >::iterator pos;

	scanf( "%lld", &n );
	for( long long i = 0, a; i < n; ++i ) {

		scanf( "%lld", &a );

		pos = g.lower_bound( a );
		if( pos != g.end() ) { g.erase( pos ); }

		g.insert( a );
	}

	printf( "%d", g.size() );
}