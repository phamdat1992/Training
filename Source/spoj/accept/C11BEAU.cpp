#include <iostream>
#include <cstdio>

using namespace std;

long long MIN( long long a, long long b ) {

	return ( a < b )? a : b;
}

long long solved( long long ca, long long cb, long long ma, long long mb ) {

	if( ca == 0 || ma == 0 ) { return MIN( cb, mb ); }
	if( cb == 0 || mb == 0 ) { return MIN( ca, ma ); }

	long long kq = 0;
	long long t = MIN( ca, cb );

	long long f1 = ca/t;
	long long f2 = cb/t;

	if( ma*t >= ca ) {

		kq += ca;
		ca = 0;
	}
	else {

		kq += MIN( ma, f1 )*t;
		ca -= MIN( ma, f1 )*t;
	}

	if( mb*t >= cb ) {

		kq += cb;
		cb = 0;
	}
	else {

		kq += MIN( mb, f2 )*t;
		cb -= MIN( mb, f2 )*t;
	}

	if( ca != 0 ) { kq += MIN( ca, ma ); }
	if( cb != 0 ) { kq += MIN( cb, mb ); }

	return kq;
}

int main(  ) {

	long long n;
	long long ca, cb, ma, mb;

	scanf( "%lld", &n );

	for( int i = 0; i < n; ++i ) {

		scanf( "%lld%lld%lld%lld", &ca, &cb, &ma, &mb );

		printf( "%lld\n", solved( ca, cb, ma, mb ) );
	}
}