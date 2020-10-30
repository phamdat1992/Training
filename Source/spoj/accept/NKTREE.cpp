#include <iostream>
#include <cstdio>

using namespace std;

int main(  ) {

	long long min = 0x8000000000000000ll;
	long long max = 0x7fffffffffffffffll;

	long long x;
	long long a = max;

	while( ( cin>>x ) ) {

		if( x <= min || x >= max || x == a ) {

			printf( "NO" );
			return 0;
		}
		else if( x > a ) { min = a; }
		else if( x < a ) { max = a; }

		a = x;
	}

	printf( "YES" );
}
