#include <iostream>
#include <cstdio>
#include <list>

using namespace std;

typedef long long int64;

inline void GET_LL( long long &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void input( int64 &n, int64 &k, int64* &a ) {

	GET_LL( n );
	GET_LL( k );

	a = new int64 [n];

	for( int64 i = 0; i < n; ++i ) {

		GET_LL( a[i] );
	}
}

void output( int64 kq ) {

	printf( "%lld", kq );
}

int64 solved( int64 n, int64 k, int64* a ) {

	int64* s = new int64 [n];
	int64* t = new int64 [n];
	int64* g = new int64 [n];
	int64* q = new int64 [n];

	list< int64 >::iterator pos;

	//tinh cho k = 1
	for( int64 w = 0, z = 0, i = n-1; i >= 0; z += a[i], --i ) {

		s[i] = z;
		t[i] = s[i] + w;
		w = t[i];
	}

	if( k == 1 ) { return t[0]; }

	//tinh cho k = 2
	g[0] = t[0];
	for( int64 i = 1; i < n; ++i ) {

		g[i] = t[0] - s[i-1]*i;
	}

	for( int64 i = 2; i < k; ++i ) {

		{
			list< int64 > m;

			m.push_front( 0 );
			q[0] = g[0];

			for( int64 j = 1; j < n; ++j ) {

				q[j] = g[0];
				for( pos = m.begin(); pos != m.end(); ) {

					int64 h = g[*pos] - s[j-1]*( j-(*pos) );
					if( h < q[j] ) { 

						q[j] = h;
						++pos;
					}
					else { pos = m.erase( pos ); }
				}


				if( g[j] < g[m.front()] ) {

					m.push_front( j );
				}				
			}

			swap( q, g );
		}
	}

	int64 min = g[0];
	for( int64 i = 1; i < n; ++i ) {

		if( g[i] < min ) { min = g[i]; }
	}

	delete []s;
	delete []t;
	delete []q;
	delete []g;

	return min;
}

int main(  ) {

	int64* a;
	int64 n, k;

	input( n, k, a );
	output( solved( n, k, a ) );

	delete []a;
}


