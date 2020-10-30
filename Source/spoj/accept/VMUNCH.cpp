#include <iostream>
#include <cstdio>
#include <queue>

using namespace std;

void input( int &m, int &n, char** &a ) {

	char c;

	scanf( "%d%d", &m, &n );
	a = new char* [m];

	for( int i = 0; i < m; ++i ) {

		a[i] = new char [n];
		for( int j = 0; j < n; ++j ) {

			cin>>c;

			switch( c ) {

				case '*' : 	a[i][j] = 1;
						break;

				case '.' :	a[i][j] = 0;
						break;

				case 'B' :	a[i][j] = 1;
						break;

				case 'C' :	a[i][j] = 10;
						break;
			};
		} 
	}
}

void output( int kq ) {

	printf( "%d", kq );
}

bool trai( queue<int> &f, char** a, int x, int y, int t, int m, int n ) {

	if( y > 0 ) {

		if( a[x][y-1] == 0 ) {

			f.push(x);
			f.push(y-1);
			f.push(t+1);

			a[x][y-1] = 1;
		}
		else if( a[x][y-1] == 10 ){

			return true;
		}
	}

	return false;
}

bool phai( queue<int> &f, char** a, int x, int y, int t, int m, int n ) {

	if( y < n-1 ) {

		if( a[x][y+1] == 0 ) {

			f.push(x);
			f.push(y+1);
			f.push(t+1);

			a[x][y+1] = 1;
		}
		else if( a[x][y+1] == 10 ){

			return true;
		}
	}

	return false;
}

bool tren( queue<int> &f, char** a, int x, int y, int t, int m, int n ) {

	if( x > 0 ) {

		if( a[x-1][y] == 0 ) {

			f.push(x-1);
			f.push(y);
			f.push(t+1);

			a[x-1][y] = 1;
		}
		else if( a[x-1][y] == 10 ){

			return true;
		}
	}

	return false;
}

bool duoi( queue<int> &f, char** a, int x, int y, int t, int m, int n ) {

	if( x < m - 1 ) {

		if( a[x+1][y] == 0 ) {

			f.push(x+1);
			f.push(y);
			f.push(t+1);

			a[x+1][y] = 1;
		}
		else if( a[x+1][y] == 10 ){

			return true;
		}
	}

	return false;
}

int solved( int m, int n, char** a ) {

	queue<int> f;

	int x = 0;
	int y = 0;
	int t = 0;

	f.push(0);
	f.push(0);
	f.push(0);

	while( 1 ) {

		x = f.front();
		f.pop();

		y = f.front();
		f.pop();

		t = f.front();
		f.pop();

		if( trai( f, a, x, y, t, m, n ) ) { break; }
		if( phai( f, a, x, y, t, m, n ) ) { break; }
		if( tren( f, a, x, y, t, m, n ) ) { break; }
		if( duoi( f, a, x, y, t, m, n ) ) { break; }
	}

	return ( t + 1 );
}

int main(  ) {

	char** a;
	int m, n;

	input( m, n, a );
	output( solved( m, n, a ) );

	for( int i = 0; i < m; ++ i ) {

		delete []a[i];
	}

	delete []a;
}
