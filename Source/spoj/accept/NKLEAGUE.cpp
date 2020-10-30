#include <iostream>
#include <string>
#include <set>

using namespace std;

class MRR {

	private:
		int i;
		string a;
	public:
		bool operator < ( MRR const& scr ) const {

			return ( a[scr.i] == '1' );
		}    

		MRR( int x, const string &b ) { 

			i = x;
			a = b;
		}

		int get(  ) const { return i + 1; }
};

void input( int &n, set< MRR > &a ) {

	cin>>n;
	for( int i = 0; i < n; ++i ) {

		string g;

		cin>>g;
		a.insert( MRR( i, g ) );
	}
}

void output( set< MRR > &a ) {

	for( set< MRR >::iterator pos = a.begin(); pos != a.end(); ++pos ) {

		cout<<(*pos).get()<<" ";
	}
}

int main(  ) {

	set< MRR > a;
	int n;

	input( n, a );
	output( a );
}