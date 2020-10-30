#include <iostream>

using namespace std;

void input( int &n, int* &a ) {

	cin>>n;

	a = new int [n];
	for( int i = 0; i < n; ++i ) {

		cin>>a[i];
	}
}

void output( int kq ) {

	cout<<kq;
}

void update( int* a, int x, int n  ) {

	while( x <= n ) {

		++a[x];
		x += x & (-x);
	}
}

int get( int*a, int i ) {

	int kq = 0;

	while( i > 0 ) {

		kq += a[i];
		i &= ( i - 1 );
	}

	return kq;
}

int solved( int n, int* a ) {

	int c[65000] = {0};

	int kq = 0;

	for( int i = 0; i < n; ++i ) {

		update( c, a[i], 60000 );
		kq += ( i + 1 - get( c, a[i] ) );
	}

	return kq;
}

int main(  ) {

	int n;
	int* a;

	input( n, a );
	output( solved( n, a ) );

	delete []a;
}
