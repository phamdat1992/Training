#include <iostream>

using namespace std;

void input( int &n, int &k, int* &a ) {

	cin>>n;
	cin>>k;

	a = new int [n];
	for( int i = 0; i < n; ++i ) {

		cin>>a[i];
	}
}

void output( int kq ) {

	cout<<kq;
}

int find( int* c, int* d, int f, int x, int loca ) {

	if( f != 0 ) {
		
		if( x >= c[ f-1 ] ) {

			int l = 0;
			int r = f-1;
			int m = 0;

			do {

				m = ( l + r ) >> 1;

				if( c[m] > x ) { l = m+1; }
				else if( c[m] < x ) { r = m-1; }
				else if( c[m] == x ) { l = r+1; }

			} while( l <= r );

			if( c[m] > x ) { return loca - d[m+1]; }
			else { return loca - d[m]; }
		}
	}

	return -1;
}

int solved( int n, int k, int* a ) {

	int t = 0;
	int f = 0;
	int m = 0;

	int kq = -1;
	
	int* c = new int [n];
	int* d = new int [n];

	for( int i = 0; i < n; ++i ) {

		t += a[i];
		
		if( t < k ) {

			int g = find( c, d, f, t - k, i );
			
			if( g > kq ) {

				kq = g;
			}
		}
		else {

			kq = i + 1;
		}

		if( t < m ) {

			m = t;
			c[f] = m;
			d[f] = i;
			++f;
		}
	}

	delete []c;
	delete []d;

	return kq;
}

int main(  ) {

	int n, k;
	int* a;

	input( n, k, a );
	output( solved( n, k, a ) );

	delete []a;
}