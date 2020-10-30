#include <iostream>

using namespace std;

int main(  ) {

	char a[256];
	char b[256];
	
	cin>>a;
	cin>>b;
	
	int lena = strlen( a );
	int lenb = strlen( b );
	
	int h = 0;
	
	for( int i = lenb - 1; i >= 0; --i ) {
	
		if( b[ i ] == a[ lena - 1 ] ) {
		
			h = 0;
			while( a[ lena-h-1 ] == b[ i - h ] ) {
			
				++h;
			}
			
			if( h == i + 1 ) {
			
				break;
			}
			else { h = 0; }
		}
	}
	
	cout<<lena+lenb-h;
}