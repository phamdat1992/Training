#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

class BALL {

	private:
		int time;
		int host;

	public:
		BALL( int a, int b ) {

			time = a;
			host = b;
		}

		bool operator < ( const BALL &scr ) const {

			return time < scr.time;
		}

		int get_time(  ) const { return time; }
		int get_host(  ) const { return host; }
};

int n, m;
set< int > s;
multiset< BALL > p;

void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void input(  ) {

	GET_INT( n );
	GET_INT( m );

	for( int i = 1; i <= n; ++i ) {

		s.insert( i );
	}
}

void solved( int t, int x, int w ) {

	for( ; !p.empty() && (*p.begin()).get_time() <= t; p.erase( p.begin() ) ) {

		s.insert( (*p.begin()).get_host() );
	}

	if( !s.empty() ) {

		set< int >::iterator pos = s.lower_bound( x );

		if( pos != s.end() ) {

			if( pos != s.begin() ) { 

				set< int >::iterator cur = pos;
				--cur;

				if( ( *pos - x ) >= ( x - *cur ) ) {

					pos = cur;
				}
			}
		}
		else { --pos; }

		printf( "%d\n", *pos );

		p.insert( BALL( t+w, *pos ) );
		s.erase( pos );
	}
	else {

		printf( "0\n" );
	}
}

int main(  ) {

	input(  );

	for( int i = 0, t, x, w; i < m; ++i ) {

		GET_INT( t );
		GET_INT( x );
		GET_INT( w );

		solved( t, x, w );
	}
}