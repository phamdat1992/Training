#include <iostream>
#include <cstdio>

using namespace std;

bool check( int a, int b, int n ) {

	for( int i = 0, d1 = 0, d2 = 0; i < n; ++i, a >>= 1, b >>= 1 ) {

		if( ((a&1) == 0) && ((b&1) == 0) ) {

			if( d1 == 1 ) { return false; }
			else { d1 = 1; }
		}
		else { d1 = 0; }

		if( ((a&1) == 1) && ((b&1) == 1) ) {

			if( d2 == 1 ) { return false; }
			else { d2 = 1; }
		}
		else { d2 = 0; }

	}

	return true;
}

long long solved( int n, int m ) {

	int f = (1<<n)-1;

	long long* q = new long long [f+1];
	long long* e = new long long [f+1];

	for( int i = 0; i <= f; ++i ) {

		q[i] = 1;
	}

	for( int i = 1; i < m; ++i ) {

		for( int j = 0; j <= f; ++j ) {

			e[j] = 0;
			for( int k = 0; k <= f; ++k ) {

				if( check( j, k, n ) ) {

					e[j] += q[k];
				}
			}
		}

		swap( e, q );
	}

	long long kq = 0;
	for( int i = 0; i <= f; ++i ) {

		kq += q[i];
	}

	delete []q;
	delete []e;

	return kq;
}

int main(  ) {

	int n, m, k;

	scanf( "%d", &k );
	for( int i = 1; i <= k; ++i ) {

		scanf( "%d%d", &n, &m );

		if( m < n ) { swap( m, n ); }
		printf( "%lld\n", solved( n, m ) );
	}
}