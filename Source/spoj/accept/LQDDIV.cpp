#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

class DIV {

	private:
		long long u, x;

	public:
		DIV( long long a, long long b ) {

			u = a;
			x = b;
		}

		bool operator < ( const DIV &scr ) const {

			if( u < scr.u ) { return true; }
			else if( u == scr.u ) {

				if( x < scr.x ) { return true; }
				else { return false; }
			}
			else { return false; }
		}

		long long get_u(  ) const { return u; }
		long long get_x(  ) const { return x; }
};

set< DIV > s;

long long a [50];

long long sum;
long long k1, k2;

int n;

void input(  ) {

	scanf( "%d", &n );

	sum = 0;
	for( int i = 0; i < n; ++i ) {

		scanf( "%lld", &a[i] );
		sum += a[i];
	}
}

void output(  ) {

	printf( "%lld %lld", k1, k2>>1 );
}

long long _abs( long long a ) {

	return ( a >= 0 )? a : -a;
}

void init( int m, long long* a ) {

	int f = ( 1<<m ) - 1;

	set< DIV >::iterator pos;
	for( int i = 0, g; i <= f; ++i ) {

		g = 0;
		for( int j = 0, t = i; t > 0; t >>= 1, ++j ) {

			if( t&1 ) {

				g += a[j];
			}
		}

		pos = s.lower_bound( DIV( g, 0 ) );

		if( pos != s.end() ) {

			if( (*pos).get_u() == g ) {

				int z = (*pos).get_x();

				s.erase( pos );
				s.insert( DIV( g, z + 1 ) );
			}
			else { s.insert( DIV( g, 1 ) ); }
		}
		else { s.insert( DIV( g, 1 ) ); }
	}
}

void update( int g, set< DIV >::iterator &pos ) {

	long long p = _abs( sum - ( ( (*pos).get_u() + g ) << 1 ) );
			
	if( p < k1 ) {

		k1 = p;
		k2 = (*pos).get_x();
	}
	else if( p == k1 ) {

		k2 += (*pos).get_x();
	}
}

void solved( int m, long long* a ) {

	int f = ( 1<<m ) - 1;

	k1 = sum;
	k2 = 0;

	set< DIV >::iterator pos;
	for( int i = 0, g; i <= f; ++i ) {

		g = 0;
		for( int j = 0, t = i; t > 0; t >>= 1, ++j ) {

			if( t&1 ) {

				g += a[j];
			}
		}

		pos = s.lower_bound( DIV( _abs( ( sum>>1 ) - g ), 0 ) );

		if( pos != s.end() ) {

			update( g, pos );

			{
				set< DIV >::iterator cur = pos;

				if( ++cur != s.end() ) { update( g, cur ); }
			}
		}

		if( pos != s.begin() ) { update( g, --pos ); }
	}
}

int main(  ) {

	input(  );

	init( n>>1, a );
	solved( n - ( n>>1 ), a + ( n>>1 ) );

	output(  );
}