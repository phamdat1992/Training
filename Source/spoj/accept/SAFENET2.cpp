#include <iostream>
#include <cstdio>

using namespace std;

struct node {

	int vertex;
	node* pNext;
};

int a [100000] = {0};
int c [50000] = {0};

int m [50000] = {0};
int k [50000] = {0};

node save [50000] = {0};

int n, g, r, q;

void GET_INT( int &x ) {

	register int c;

	for( c = getchar_unlocked(); c < '0' || c > '9'; c = getchar_unlocked() );

	x = c - '0';
	for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

		x = ( x<<3 ) + ( x<<1 ) + c - '0';
	}
}

void input(  ) {

	node* p1;
	node* p2;

	GET_INT( n );
	GET_INT( g );

	for( int i = 0, u, v; i < g; ++i ) {

		GET_INT( u );
		GET_INT( v );

		p1 = new node;
		p1->vertex = v;
		p1->pNext = save[u].pNext;

		p2 = new node;
		p2->vertex = u;
		p2->pNext = save[v].pNext;

		save[u].pNext = p1;
		save[v].pNext = p2;
	}
}

void output(  ) {

	printf( "%d", q );
}

void dfs( int u ) {

	m[u] = k[u] = ++r;

	for( node* cur = save[u].pNext; cur != 0; cur = cur->pNext ) {

		int v = cur->vertex;

		if( c[v] != u ) {

			if( m[v] == 0 ) {

				c[v] = u;

				a[++a[0]] = u;
				a[++a[0]] = v;

				dfs( v );

				k[u] = min( k[u], k[v] );

				if( k[v] == m[u] ) {

					int k = 1;
					for( int r = 0, e = 0; r != u || e != v; e = a[a[0]--], r = a[a[0]--], ++k );
					q = max( q, k );
				}
			}
			else {

				k[u] = min( k[u], m[v] );
			}
		}
	}
}

void solved(  ) {

	r = 0;
	q = 0;

	if( g != 0 ) {

		q = 2;
		for( int i = 1; i <= n; ++i ) {

			if( m[i] == 0 ) {

				dfs( i );
			}
		}
	}
	else if( n != 0 ) { q = 1; }
}

int main(  ) {

	input(  );

	solved(  );
	output(  );
}