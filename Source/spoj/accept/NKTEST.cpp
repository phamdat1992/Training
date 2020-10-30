#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

char str [15] = {0};

long long solved( long long &m ) {	

	long long f = 1;	

	scanf( "%s\n", str );
	for( long long k; strcmp( str, "ELSE" ) != 0 && strcmp( str, "END_IF" ) != 0 && strcmp( str, "ENDPROGRAM" ) != 0; scanf( "%s\n", str ) ) {

		if( strcmp( str, "IF" ) == 0 ) {

			k = solved( m );

			if( m == 1 ) { k += solved( m ); }
			else { ++k; }

			f *= k;
		}
	}

	if( strcmp( str, "ELSE" ) == 0 ) { m = 1; }
	else if( strcmp( str, "END_IF" ) == 0 ) { m = 2; }
	else if( strcmp( str, "ENDPROGRAM" ) == 0 ) { m = 3; }

	return f;
}

int main(  ) {

	long long m;
	printf( "%lld", solved( m ) );
}