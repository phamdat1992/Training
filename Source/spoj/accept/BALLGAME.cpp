#include <iostream>
#include <cstdio>
#include <set>
#include <list>

using namespace std;

int n, m;

class BALL {

	private:
		char c;
		int f1;
		int f2;

	public:
		BALL( char q, int w, int e ) {

			c = q;
			f1 = w;
			f2 = e;
		}

		bool operator < ( const BALL &scr ) const {

			if( f1 <= scr.f1 ) { return true; }
			else { return false; }
		}

		char get_c(  ) const { return c; }
		int get_f1(  ) const { return f1; }
		int get_f2(  ) const { return f2; }
};

void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void GET_CHAR( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c != 'A' && c != 'B'; c = getchar_unlocked() );
	x = c;
}

void input( multiset< BALL > &save ) {

	GET_INT( n );
	GET_INT( m );

	for( int i = 0, q, w, e; i < m; ++i, scanf( "\n" ) ) {

		GET_CHAR( q );

		GET_INT( w );
		GET_INT( e );

		save.insert( BALL( char( q ), w, e ) );
	}
}

void solved( multiset< BALL > &save ) {

	multiset< int > s;

	list< BALL > l;
	multiset< BALL > q;

	int d1 = 0;
	int d2 = 0;

	for( int i = 1; i <= n; ++i ) { s.insert( i ); }

	multiset< BALL >::const_iterator pos;
	for( pos  = save.begin(); pos != save.end(); ++pos ) {

		for( ; ! q.empty() && (*q.begin()).get_f1() <= (*pos).get_f1(); q.erase( q.begin() ) ) {

			s.insert( (*q.begin()).get_f2() );
		}

		if( s.empty() ) {

			if( (*pos).get_c() == 'A' ) {

				printf( "Alice loses at her turn: %d\n", ++d1 );
			}
			else {

				printf( "Bob loses at his turn: %d\n", ++d2 );
			}

			printf( "Game lasts: %d minute(s)", (*pos).get_f1() );

			break;
		}
		else {

			if( (*pos).get_c() == 'A' ) {

				++d1;

				l.push_back( BALL( 'A', *(s.begin()), 0 ) );
				q.insert( BALL( 'A', (*pos).get_f1() + (*pos).get_f2(), *(s.begin()) ) );

				s.erase( s.begin() );
			}
			else {

				++d2;

				multiset< int >::const_iterator flag = s.end();
				--flag;

				l.push_back( BALL( 'B', (*flag), 0 ) );
				q.insert( BALL( 'B', (*pos).get_f1() + (*pos).get_f2(), (*flag) ) );

				s.erase( flag );
			}
		}
	}

	if( pos == save.end() ) {

		printf( "DRAW\n" );

		multiset< BALL >::const_iterator flag = q.end();
		--flag;

		printf( "Game lasts: %d minute(s)\n", (*flag).get_f1() );

		for( list< BALL >::const_iterator cur = l.begin(); cur != l.end(); ++cur ) {

			if( (*cur).get_c() == 'A' ) {

				printf( "Alice takes the hole: %d\n", (*cur).get_f1() );
			}
			else {

				printf( "Bob takes the hole: %d\n", (*cur).get_f1() );
			}
		}
	}
}

int main(  ) {

	multiset< BALL > save;

	input( save );
	solved( save );
}