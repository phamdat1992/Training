#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

multiset< int, greater< int > > l;
set< int, greater< int > > s;

void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x << 3 ) + ( x << 1 ) + c - '0';
	}
}

void output(  ) {

	for( multiset< int, greater< int > >::iterator pos = l.begin(); pos != l.end(); ++pos ) {

		s.insert( *pos );
	}

	printf( "%d\n", s.size() );
	for( set< int, greater< int > >::iterator pos = s.begin(); pos != s.end(); ++pos ) {

		printf( "%d\n", *pos );
	}
}

void solved(  ) {

	char c;

	for( int u; cin>>c; ) {

		if( c == '+' ) {

			GET_INT( u );
			if( l.size() < 15000 ) {

				l.insert( u );
			}
		}
		else if( c == '-' ) {

			if( !l.empty() ) {

				int f = *l.begin();
				for( ; !l.empty() && f == *l.begin(); l.erase( l.begin() ) );
			}
		}
	}
}

int main(  ) {

	solved(  );
	output(  );
}