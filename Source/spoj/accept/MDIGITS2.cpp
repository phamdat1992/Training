#include<iostream>
#include<string>

using namespace std;

int main(  ) {

	int n;
	string s="";
	char t[7];

	cin>>n;

	for( int i=1; i<=n; ++i ) {

		sprintf( t, "%d", i );
		s += t;
	}

	sprintf( t, "%d", n );
	cout<<s.find(t) + 1;
}