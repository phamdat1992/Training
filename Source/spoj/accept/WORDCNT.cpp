#include <iostream>
#include <cstdio>

using namespace std;

int main(  ) {

	int n;
	string s;

	cin>>n;;
	getline( cin, s );
	

	for( int i = 0; i < n; ++i ) {

		int len;
		int f = 0;
		int d = 0;
		int q = 0;
		int kq = 0;

		getline( cin, s );
		s += ' ';
		len = s.length();

		for( int i = 0; i < len; ++i ) {

			if( s[i] >= 'a' && s[i] <= 'z'  ) { ++d; }
			else if( d != 0 ) {

				if( f == d ) { ++q; }
				else {

					f = d;
					q = 1;
				}

				if( q > kq ) { kq = q; }
				d = 0;
			}
		}

		cout<<kq<<endl;
	}
}
