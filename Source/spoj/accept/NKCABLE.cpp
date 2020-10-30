#include <iostream>
 
using namespace std;
 
int MIN( int a, int b ) {

	return ( a < b )? a:b;
}
 
void input( int &n, int* &a ) {
 
    cin>>n;
    --n;
    a = new int[n];
    for( int i = 0; i < n; ++i ) {
 
        cin>>a[i];
    }
}
 
void output( int kq ) {
 
    cout<<kq;
}
 
int solved( int n, int* a ) {
 
    int f1 = a[0];
    int f2 = a[1]+a[0];
    int f3;
 
    if( n == 1 ) { return f1; }
    else if( n == 2 ) { return f2; }
    else {
 
        for( int i = 2; i < n; ++i ) {
    
            f3 = MIN( f1, f2 ) + a[i];
            f1 = f2;
            f2 = f3;
        }
 
        return f3;
    }
}
 
int main(  ) {
 
    int n;
    int* a;
 
    input( n, a );
    output( solved( n, a ) );
 
    delete []a;
}