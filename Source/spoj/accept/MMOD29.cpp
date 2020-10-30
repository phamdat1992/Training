#include <iostream>

using namespace std;

long long pow( long long n, long long m, long long g ) {

	if( m == 1 ) { return n; }
	else {

		long long k = pow( n, m>>1, g );

		k *= k;
		k %= g;

		if( (m|1) == m ) {

			k *= n;
			k %= g;
		}

		return k;
	}
}

void solved( long long n ) {

	long long f1 = pow( 2, ( n<<1 ) + 1, 29 );
	long long f2 = pow( 3, n + 1, 58 );
	long long f3 = pow( 167, n + 1, 4814 );

	f1 -= 1;
	f2 -= 1;
	f3 -= 1;

	if( f1 < 0 ) { f1 += 29; }
	if( f2 < 0 ) { f2 += 58; }
	if( f3 < 0 ) { f3 += 4814; }

	f1 /= 1;
	f2 /= 2;
	f3 /= 166;

	f1 %= 29;
	f2 %= 29;
	f3 %= 29;

	cout<<( f1*f2*f3 )%29<<endl;
}

int main(  ) {

	long long n;

	cin>>n;

	while( n != 0 ) {

		solved( n );
		cin>>n;
	}
}