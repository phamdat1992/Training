#include <iostream>

using namespace std;

void input( int &m, int &n, int** &a ) {

	cin>>m;
	cin>>n;

	a = new int* [m];
	for( int i = 0; i < m; ++i ) {

		a[i] = new int [n];
		for( int j = 0; j < n; ++j ) {

			cin>>a[i][j];
		}
	}
}

void output( int kq ) {

	cout<<kq;
}

int MAX( int a, int b ) {

	return ( a > b )? a : b;
}

int find( int** a, int i, int j, int w ) {

	int m = a[j][i+1];

	if( j - 1 >= 0 ) { m = MAX( m, a[j-1][i+1] ); }
	if( j + 1 < w  ) { m = MAX( m, a[j+1][i+1] ); }

	return m;
}

int solved( int m, int n, int** a ) {

	for( int i = n-2; i >= 0; --i ) {

		for( int j = 0; j < m; ++j ) {

			a[j][i] += find( a, i, j, m );
		}
	}

	int kq = a[0][0];
	for( int i = 0; i < m; ++i ) {

		if( a[i][0] > kq ) {

			kq = a[i][0];
		}
	}

	return kq;
}

int main(  ) {

	int n;
	int m;

	int** a;

	input( m, n, a );
	output( solved( m, n, a ) );

	for( int i = 0; i < m; ++i ) {

		delete []a[i];
	}

	delete []a;
}