#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

class SNOW {

	private:
		int a1, a2, a3, a4, a5, a6;

	public:
		SNOW( int b1, int b2, int b3, int b4, int b5, int b6 ) {

			a1 = b1; a2 = b2; a3 = b3; a4 = b4; a5 = b5; a6 = b6;
		};

		SNOW( const SNOW &scr ) {

			a1 = scr.a1;
			a2 = scr.a2;
			a3 = scr.a3;
			a4 = scr.a4;
			a5 = scr.a5;
			a6 = scr.a6;
		};

		bool operator < ( const SNOW &scr ) const {

			if( a1 < scr.a1 ) { return true; }

			if( a1 == scr.a1 ) {

				if( a2 < scr.a2 ) { return true; }

				if( a2 == scr.a2 ) {

					if( a3 < scr.a3 ) { return true; }

					if( a3 == scr.a3 ) {

						if( a4 < scr.a4 ) { return true; }

						if( a4 == scr.a4 ) {

							if( a5 < scr.a5 ) { return true; }

							if( a5 == scr.a5 ) {

								if( a6 < scr.a6 ) { return true; }
							}
						}
					}
				}
			}

			return false;
		}
};

set< SNOW > a;

void fil( int a1, int a2, int a3, int a4, int a5, int a6 ) {

	set< SNOW > b;

	b.insert( SNOW( a1, a2, a3, a4, a5, a6 ) );
	b.insert( SNOW( a2, a3, a4, a5, a6, a1 ) );
	b.insert( SNOW( a3, a4, a5, a6, a1, a2 ) );

	b.insert( SNOW( a4, a5, a6, a1, a2, a3 ) );
	b.insert( SNOW( a5, a6, a1, a2, a3, a4 ) );
	b.insert( SNOW( a6, a1, a2, a3, a4, a5 ) );

	b.insert( SNOW( a6, a5, a4, a3, a2, a1 ) );
	b.insert( SNOW( a5, a4, a3, a2, a1, a6 ) );
	b.insert( SNOW( a4, a3, a2, a1, a6, a5 ) );

	b.insert( SNOW( a3, a2, a1, a6, a5, a4 ) );
	b.insert( SNOW( a2, a1, a6, a5, a4, a3 ) );
	b.insert( SNOW( a1, a6, a5, a4, a3, a2 ) );

	a.insert( *b.begin() );
}

void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void solved(  ) {

	int n;
	int a1, a2, a3, a4, a5, a6;

	GET_INT( n );
	for( int i = 0, f; i < n; ++i ) {

		f = a.size();

		GET_INT( a1 );
		GET_INT( a2 );
		GET_INT( a3 );
		GET_INT( a4 );
		GET_INT( a5 );
		GET_INT( a6 );

		fil( a1, a2, a3, a4, a5, a6 );

		if( f == a.size() ) {

			printf( "Twin snowflakes found." );
			return;
		}
	}

	printf( "No two snowflakes are alike." );
}

int main(  ) {

	solved(  );
}