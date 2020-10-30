#include <iostream>

using namespace std;

int main(  ) {

	int n, m;

	cin>>n;

	for( int i = 0; i < n; ++i ) {

		cin>>m;

		int t = (m-1)/9;
		int h = (m-1)%9;

		for( int j = 0; j < t; ++j ) { cout<<"123456790"; }
		for( int j = 1; j <= h; ++j ) { cout<<j; }
		for( int j = h+1; j > 1; --j ) { cout<<j; }
		for( int j = 0; j < t; ++j ) { cout<<"098765432"; }

		cout<<1<<endl;
	}
}