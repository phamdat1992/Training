#include <iostream>
#include <cstdio>
#include <vector>
#include <stack>
#include <list>

using namespace std;

void input( int &n, int &m, vector<list<int> > &a ) {

	fscanf( stdin, "%d%d", &n, &m );

	a.resize( n+1 );
	for( int i = 0; i < m; ++i ) {

		int w, r;

		fscanf( stdin, "%d%d", &w, &r );

		a[w].push_front( r );
	}

	fclose( stdin );
}

void output( int kq ) {

	fprintf( stdout, "%d", kq );
	fclose( stdout );
}

int MIN( int a, int b ) {

	return ( a < b )? a : b;
}

void visit( int u, int &g, int &kq, vector<list<int> > &a, int* v, int* f, bool* c, stack<int> &s ) {

	v[u] = f[u] = ++g;

	s.push(u);

	for( list<int>::iterator pos = a[u].begin(); pos != a[u].end(); ++pos ) {

		if( ! c[*pos] ) {

			if( v[*pos] != 0 ) {

				f[u] = MIN( f[u], v[*pos] );
			}
			else {

				visit( *pos, g, kq, a, v, f, c, s );
				f[u] = MIN( f[u], f[*pos] );
			}
		}
	}

	if( v[u] == f[u] ) {

		++kq;
		int j;

		do {

			j = s.top();
			s.pop();
			c[j] = true;

		} while( j != u );
	}
}

int solved( int n, vector<list<int> > &a ) {

	int v [20000] = {0};
	int f [20000] = {0};

	bool c[20000] = {0};

	int g = 0;
	int kq = 0;

	stack<int> s;

	for( int i = 1; i <= n; ++i ) {

		if( v[i] == 0 ) {

			visit( i, g, kq, a, v, f, c, s );
		}
	}

	return kq;
}

int main(  ) {

	vector<list<int> > a;
	int n, m;

	input( n, m, a );
	output( solved( n, a ) );
}