#include <iostream>
#include <cstdio>
#include <vector>
#include <list>
#include <set>

using namespace std;

void input( int &n, vector< list< int > > &a ) {

	scanf( "%d", &n );

	a.resize( n + 1 );
	for( int g, i; cin>>g; ) {

		scanf( "%d", &i );
		for( int j = 0, d; j < i; ++j ) {

			scanf( "%d", &d );
			a[g].push_back( d );
		}
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int visit( int u, vector< list< int > > &a ) {

	multiset< int, greater< int > > luu;

	if( a[u].size() == 0 ) { return 1; }
	
	for( list< int >::iterator pos = a[u].begin(); pos != a[u].end(); ++pos ) {

		luu.insert( visit( *pos, a ) );
	}

	int t = 0;
	int kq = 0;

	for( set< int >::const_iterator pos = luu.begin(); pos != luu.end(); ++pos ) {

		if( t < ( *pos ) ) {

			kq += ( *pos ) - t;
			t = (*pos);
		}

		--t;
	}

	return ( kq == 0 ) ? 1 : kq;
}

int main(  ) {

	vector< list< int > > a;
	int n;

	input( n, a );
	output( visit( 1, a ) );
}