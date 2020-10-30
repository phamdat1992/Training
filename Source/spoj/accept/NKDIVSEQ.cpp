#include <iostream>
#include <cstdio>

using namespace std;

void input( long &n ) {

	cin>>n;
}

void output( long kq ) {

	cout<<kq;
}

long solved( long n ) {

	long t1 = 1;
	long t2 = 1;
	long i = 1;

	if( n == 1l ) { return 1l; }

	for( i = 1; i+t1+1 <= n; i += t1, ++t1 ) {

		t2 = ( ( t1 )*( t2 + t1 - 1 ) )/( t1 + 1 ) + 1;
	}

	t2 += n - i;
	return t2*t1;
}

int main(  ) {

	long n;

	input( n );
	output( solved( n ) );
}