#include <iostream>
#include <cstdio>

using namespace std;

int main(  ) {

	int b [50000] = {0};
	int a [50000] = {0};

	int m, n;
	char c;

	int f = 0;

	scanf( "%d%d", &m, &n );

	for( int i = 0; i < m; ++i ) {

		for( int j = 0; j < n; ++ j ) {

			cin>>c;

			if( c == '.' ) { a[j] = 0; }
			else {

				if( a[j] != 0 && b[a[j]] < 2 ) {

					++b[a[j]];
				}
				else if( j > 0 && a[j-1] != 0 && b[a[j-1]] < 2 ) {

					++b[a[j-1]];
				}
				else {

					++f;
					a[j] = f;
					++b[f];
				}
			}
		}
	}

	printf( "%d", f );
}