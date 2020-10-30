#include <iostream>
#include <string>
#include <queue>

using namespace std;

class NUMCON {

	private:
		string st;

	public:
		NUMCON( string scr ) { st = scr; }
		string get(  ) const { return st; }
		bool operator < ( NUMCON const &scr ) const {

			return ( st + scr.st ) < ( scr.st + st );
		}
};

void input( priority_queue< NUMCON > &a ) {

	string w;

	while( ( cin>>w ) ) {

		a.push( NUMCON( w ) );
	}
}

void output( priority_queue< NUMCON > &a ) {

	for( ; a.size() > 0; a.pop() ) {

		cout<<a.top().get(  );
	}
}

int main(  ) {

	priority_queue< NUMCON > a;

	input( a );
	output( a );
}