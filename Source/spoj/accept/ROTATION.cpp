#include <iostream>
#include <cstdio>

using namespace std;

int main(  ) {

	int n;
	int d = 0;

	scanf( "%d", &n );
	for( int i = 1, w, e ,r; i < n; ++i ) {

		scanf( "%d%d%d", &w, &e, &r );
		d ^= (r==1);
	}

	printf( "%d", d );
}