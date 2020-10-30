#include <iostream>
#include <cstdio>

using namespace std;

void input( long &n, long &q, long* &a ) {

	scanf( "%ld%ld", &n, &q );

	a = new long [n+1];
	for( long i = 1; i <= n; ++i ) {

		scanf( "%ld", &a[i] );
	}
}

inline int MAX( long a, long b ) {

	return ( a > b )? a : b;
}

inline long MIN( long a, long b ) {

	return ( a < b )? a : b;
}

void init( long i, long l, long r, long* m1, long* m2, long* a ) {

	if( l == r ) {

		m2[i] = m1[i] = a[l];
		return;
	}

	long g = ( l + r ) >> 1;

	init( i << 1, l, g, m1, m2, a );
	init( ( i << 1 ) + 1, g+1, r, m1, m2, a );

	m1[i] = MAX( m1[ i << 1 ], m1[ ( i << 1 ) + 1 ] );
	m2[i] = MIN( m2[ i << 1 ], m2[ ( i << 1 ) + 1 ] );
}

long find_min( long i, long l, long r, long d, long c, long* m ) {

	if( d <= l && r <= c ) {

		return m[i];
	}

	long g = ( l + r ) >> 1;

	long t1 = 1000000;
	long t2 = 1000000;

	if( d <= g ) {

		t1 = find_min( i << 1 , l, g, d, c, m );
	}

	if( c > g ) {

		t2 = find_min( ( i << 1 )+1, g+1, r, d, c, m );
	}

	return MIN( t1, t2 );
}

long find_max( long i, long l, long r, long d, long c, long* m ) {

	if( d <= l && r <= c ) {

		return m[i];
	}

	long g = ( l + r ) >> 1;

	long t1 = 0;
	long t2 = 0;

	if( d <= g ) {

		t1 = find_max( i << 1 , l, g, d, c, m  );
	}

	if( c > g ) {

		t2 = find_max( ( i << 1 )+1, g+1, r, d, c, m );
	}

	return MAX( t1, t2 );
}

int main(  ) {

	long n, q;
	long* a;

	input( n, q, a );

	long* m1 = new long [ n<<4 ];
	long* m2 = new long [ n<<4 ];

	init( 1, 1, n, m1, m2, a );


	for( long i = 0; i < q; ++i ) {

		long c, d;

		scanf( "%ld%ld", &d, &c );

		if( c != d ) {

			long h = find_max( 1, 1, n, d, c, m1 );
			long k = find_min( 1, 1, n, d, c, m2 );

			 printf("%ld\n", h-k);
		}
		else {  printf("%ld\n", 0); }
	}

	delete []a;
	delete []m1;
	delete []m2;
}
