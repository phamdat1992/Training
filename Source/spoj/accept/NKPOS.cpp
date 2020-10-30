#include <iostream>
#include <cstdio>
#include <vector>
#include <list>
#include <stack>

using namespace std;

vector< list< int > > a;

int c [200000][2] = {0};
int f [200000] = {0};

void input( int &n, int &m ) {

	scanf( "%d%d", &n, &m );

	a.resize( n+1 );
	for( int i = 0, x; i < n; scanf( "%d", &x ), ++i );
	for( int i = 0; i < m; ++i ) {

		scanf( "%d%d", &c[i][0], &c[i][1] );

		a[c[i][0]].push_back( i );
		a[c[i][1]].push_back( i );
	}
}

void solved( int n, int m ) {

	stack< int > w;
	stack< int > r;

	w.push( 1 );
	for( ; ! w.empty(); ) {

		int u = w.top();

		bool check = false;
		for( list< int >::iterator pos = a[u].begin(); (! check) && pos != a[u].end(); pos = a[u].erase( pos ) ) {

			if( f[*pos] == 0 ) {

				f[*pos] = 1;
				w.push( ( u != c[*pos][0] )? c[*pos][0] : c[*pos][1] );

				check = true;
			}
		}

		if( check == false ) {

			r.push( u );
			w.pop();
		}
	}

	printf( "%d\n", r.size() - 1 );
	for( ; ! r.empty();  ) {

		printf( "%d ", r.top() );
		r.pop();
	}
}

int main(  ) {

	int n, m;

	input( n, m );
	solved( n, m );
}