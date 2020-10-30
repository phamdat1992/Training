#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

int f [200] = {0};
int n, s;

void input(  ) {

	set< int > w;

	scanf( "%d%d", &n, &s );
	for( int i = 0, g; i < n; ++i ) {

		scanf( "%d", &g );

		w.insert( g );		
	}

	int i = 0;
	for( set< int >::const_iterator pos = w.begin(); pos != w.end(); ++pos, ++i ) {

		f[i] = *pos;
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int solved(  ) {

	int q [20000] = {0};
	int kq = 0;

	if( s > 10000 ) {

		int r = s - 10000;
		kq = r/f[n-1];

		if( r%f[n-1] != 0 ) { ++kq; }

		s -= kq*f[n-1];
	}

	for( int i = 0; i < s; ++i ) {

		for( int j = 0; j < n; ++j ) {

			if( q[i+f[j]] == 0 || q[i+f[j]] > q[i] + 1 ) {

				q[i+f[j]] = q[i] + 1;
			}
		}
	}

	return kq + q[s];
}

int main(  ) {

	input(  );
	output( solved(  ) );
}