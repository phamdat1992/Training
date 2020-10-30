#include <iostream>
#include <cstdio>

using namespace std;

int fa [100001] = {0};
int fb [100001] = {0};
int fc [100001] = {0};

int flag [100001] = {0};

int *a, *b, *c;
int na, nb, nc;

void input(  ) {

	scanf( "%d %d %d", &na, &nb, &nc );

	a = new int [na];
	b = new int [nb];
	c = new int [nc];

	for( int i = 0; i < na; ++i ) {

		scanf( "%d", &a[i] );

		++fa[a[i]];
	}

	for( int i = 0; i < nb; ++i ) {

		scanf( "%d", &b[i] );

		++fb[b[i]];
	}

	for( int i = 0; i < nc; ++i ) { scanf( "%d", &c[i] ); }
}

void solved(  ) {

	int k = 0;
	int d = 0;
	int f = 0;
	int g = 1;

	for( int i = 0; i < nc; ++i ) {

		if( fb[c[i]] == 1 ) {

			if( f == na ) { k = max( k, d ); }

			d = 0;
			f = 0;
			++g;
		}
		else {

			++d;
			if( fa[c[i]] != 0 ) {

				if( flag[c[i]] != g ) {

					flag[c[i]] = g;
					fc[c[i]] = 1;

					++f;
				}
				else if( fc[c[i]] < fa[c[i]] ) {

					++fc[c[i]];
					++f;
				}
			}
		}
	}

	if( f == na ) { k = max( d, k ); }

	printf( "%d", k );
}

int main(  ) {

	input(  );

	solved(  );

	delete []a;
	delete []b;
	delete []c;
}