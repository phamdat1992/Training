#include <iostream>
#include <cstdio>
#include <vector>
#include <stack>
#include <list>

using namespace std;

int n, s;
int r = 0;

int h [1000] = {0};
int v [1000] = {0};
int m [1000] = {0};
int f [1000] = {0};

vector< list< int > > a;

void input(  ) {

	scanf( "%d%d", &n, &s );

	a.resize( n + 1 );
	for( int i = 0; i < s; ++i ) {

		int w, e;

		scanf( "%d%d", &w, &e );
		a[w].push_front(e);
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

void visit( int k, int u, stack<int> &q ) {

	m[u] = f[u] = ++r;

	q.push( u );

	for( list< int >::const_iterator pos = a[u].begin(); pos != a[u].end(); ++pos ) {

		if( v[*pos] > 0 && h[v[*pos]] == v[*pos] ) {

			h[v[*pos]] = h[k];
		}
		else if( v[*pos] == 0 ) {

			if( m[*pos] != 0 ) {

				m[u] = MIN( m[u], f[*pos] );
			}
			else {

				visit( k, *pos, q );
				m[u] = MIN( m[u], m[*pos] );
			}
		}
	}

	if( m[u] == f[u] ) {

		int z;
		do {

			z = q.top();
			q.pop();

			v[z] = ( u == k )? k : -k;

		} while( z != u );
	}
}

int solved(  ) {

	stack<int> q;
	int kq = 0;

	for( int i = 1; i <= n; ++i ) {

		if( v[i] == 0 ) {

			h[i] = i;
			visit( i, i, q );
		}
	}

	for( int i = 1; i <= n; ++i ) {

		if( h[i] == i ) { ++kq; }
	}

	return kq;
}

int main(  ) {

	input(  );
	output( solved(  ) );
}