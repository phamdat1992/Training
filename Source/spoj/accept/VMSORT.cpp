#include <iostream>
#include <string>
#include <set>

using namespace std;

int main(  ) {

	set<string> a;
	int k, l;

	cin>>k;

	for( int i = 0; i < k; ++i ) {

		cin>>l;
		for( int j = 0; j < l; ++ j ) {

			string f;

			cin>>f;
			a.insert( f );
		}
	}

	cout<<a.size();
}