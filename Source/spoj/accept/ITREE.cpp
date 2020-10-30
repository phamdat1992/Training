#include <iostream>
#include <cstdio>
#include <vector>
#include <list>

using namespace std;

const int oo = 0x7fffffff;

int f[2000][2] = {0};

void input( int &n, vector< list< int > > &a ) {

	scanf( "%d", &n );

	a.resize( n + 1 );
	for( int i = 2, w, e; i <= n; ++i ) {

		scanf( "%d%d", &w, &e );

		a[w].push_back( i );
		a[w].push_back( e );
	}
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

void visit( int u, vector< list< int > > &a ) {

	if( a[u].size() == 0 ) {

		f[u][0] = 0;
		f[u][1] = oo;
	}
	else {

		f[u][0] = 0;
		f[u][1] = 0;

		for( list< int >::iterator pos = a[u].begin(); pos != a[u].end(); ) {

			int w = *(pos++);
			int r = *(pos++);

			visit( w, a );

			f[u][0] += f[w][0];
			f[u][1] += MIN( f[w][1], f[w][0] + r );
		}
	}
}

int main(  ) {

	int t;

	scanf( "%d", &t );

	for( int i = 0; i < t; ++i ) {

		vector< list< int > > a;
		int n;

		input( n, a );
		visit( 1, a );

		printf( "%d.00\n", f[1][1] );
	}
}