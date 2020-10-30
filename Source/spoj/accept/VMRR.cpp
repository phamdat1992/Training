#include <iostream>
#include <cstdio>
#include <string>

using namespace std;

long long f [1000050] = {0};

void input( string &s, char &u, char &v ) {

	getline( cin, s );
	cin>>u>>v;
}

void output( long long kq ) {

	printf( "%lld", kq );
}

long long solved( string &s, char u, char v ) {

	int lens = s.length()-1;

	long long t = 0;
	for( int i = lens; i >= 0; --i ) {

		if( s[i] == v ) {

			++t;
			f[i] = t;
		}
	}

	long long kq = 0;
	for( int i = 0, j; i <= lens; ++i ) {

		for( ; i <= lens && s[i] != u; ++i );
		for( j = i+1; j <= lens && s[j] != v; ++j );

		if( j <= lens && i <= lens && j > i && s[i] == u && s[j] == v ) {

			kq += f[j];
		}
	}

	return kq;
}

int main(  ) {

	string s;
	char u, v;

	input( s, u, v );
	output( solved( s, u, v ) );
}

