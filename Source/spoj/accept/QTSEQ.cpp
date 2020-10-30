#include <iostream>
#include <cstdio>

using namespace std;

long long a [1000001];

long long _max [1000001];
long long _min [1000001];

long long q1 [1000001];
long long q2 [1000001];

long long n;

void GET_LL( long long &x ) {

	register int c;
	bool f = 0;

	for( c = getchar_unlocked(); ( c < '0' || c > '9' ) && c != '-' ; c = getchar_unlocked() );

	if( c == '-' ) {

		f = 1;
		x = 0;
	}
	else { x = c - '0'; }

	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}

	if( f ) { x = -x; }
}

void input(  ) {

	GET_LL( n );
	for( long long i = 0; i < n; ++i ) {

		GET_LL( a[i] );
	}
}

void init(  ) {

	_max[n-1] = a[n-1];
	_min[n-1] = a[n-1];

	q1[n-1] = 1;
	q2[n-1] = 1;

	for( long long i = n - 2, f = a[n-1]; i >= 0; --i ) {

		f += a[i];

		if( f < _min[i+1] ) {

			_min[i] = f;
			q1[i] = 1;
		}
		else if( f == _min[i+1] ) {

			_min[i] = f;
			q1[i] = q1[i+1]+1;
		}
		else if( f > _min[i+1] ) {

			_min[i] = _min[i+1];
			q1[i] = q1[i+1];
		}

		if( f > _max[i+1] ) {

			_max[i] = f;
			q2[i] = 1;
		}
		else if( f == _max[i+1] ) {

			_max[i] = f;
			q2[i] = q2[i+1]+1;
		}
		else if( f < _max[i+1] ) {

			_max[i] = _max[i+1];
			q2[i] = q2[i+1];
		}
	}
}

long long _abs( long long x ) {

	return ( ( x < 0 )? -x : x );
}

void solved(  ) {

	long long e = -1;
	long long r = 0;

	for( long long i = 0, f = a[0]; i < n-1; ++i, f += a[i] ) {

		long long f1 = _abs( f - _min[i+1] );
		long long f2 = _abs( f - _max[i+1] );

		if( f1 > e ) {

			e = f1;
			r = q1[i+1];
		}
		else if( f1 == e ) { r += q1[i+1]; }

		if( _min[i+1] != _max[i+1] ) {

			if( f2 > e ) {

				e = f2;
				r = q2[i+1];
			}
			else if( f2 == e ) { r += q2[i+1]; }
		}
	}

	printf( "%lld %lld", e, r );
}

int main(  ) {

	input(  );

	init(  );
	solved(  );
}