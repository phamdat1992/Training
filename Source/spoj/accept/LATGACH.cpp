#include <iostream>
#include <vector>

using namespace std;

void sum( vector< int > &a, vector< int > &b, vector< int > &s ) {

	int pos1 = a.size();
	int pos2 = b.size();

	int r1 = 0;
	int r2 = 0;

	int t = 0;

	while( r1 < pos1 || r2 < pos2 ) {

		if( r1 < pos1 ) {

			t += a[r1];
			++r1;
		}

		if( r2 < pos2 ) {

			t += b[r2];
			++r2;
		}

		s.push_back( t%10 );
		t /= 10;
	}

	for( ; t != 0; t /= 10 ) {

		s.push_back( t%10 );
	}
}

int main(  ) {

	int n, k;
	vector< vector<int> > a;

	a.resize( 200 );

	a[1].push_back(1);
	a[2].push_back(2);

	for( int i = 3; i <= 100; ++i ) {

		a[i].reserve( 20000 );
		sum( a[i-1], a[i-2], a[i] );
	}

	cin>>n;
	for( int i = 0; i < n; ++i ) {

		cin>>k;
		for( int i = a[k].size() - 1; i >= 0; --i ) {

			cout<<a[k][i];
		}

		cout<<endl;
	}
}