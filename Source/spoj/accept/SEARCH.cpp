#include <iostream>
#include <cstdio>

using namespace std;

bool fa [100001] = {0};
bool fb [100001] = {0};
int fc [100001] = {0};

int ca, cb;

int *a, *b, *c;
int na, nb, nc;

void input(  ) {

	scanf( "%d %d %d", &na, &nb, &nc );

	a = new int [na];
	b = new int [nb];
	c = new int [nc];

	ca = 0;
	cb = 0;

	for( int i = 0; i < na; ++i ) {

		scanf( "%d", &a[i] );

		ca += fa[a[i]]^1;
		fa[a[i]] = 1;
	}

	for( int i = 0; i < nb; ++i ) {

		scanf( "%d", &b[i] );

		cb += fb[b[i]]^1;
		fb[b[i]] = 1;
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

			if( f == ca ) { k = max( k, d ); }

			d = 0;
			f = 0;
			++g;
		}
		else {

			++d;
			if( fa[c[i]] == 1 && fc[c[i]] != g ) {

				++f;
				fc[c[i]] = g;
			}
		}
	}

	if( f == ca ) { k = max( d, k ); }

	printf( "%d", k );
}

int main(  ) {

	input(  );

	solved(  );

	delete []a;
	delete []b;
	delete []c;
}