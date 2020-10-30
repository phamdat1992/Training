#include <iostream>
 
using namespace std;
 
int MIN( int a, int b ) {
 
    return ( a < b )? a:b;
}
 
void input( int &n, int* &a, int* &b ) {
 
    cin>>n;
    
    a = new int [n+2];
    b = new int [n+2];
 
    for( int i = 0; i < n; ++i ) {
 
        cin>>a[i];
    }
 
    for( int i = 0; i < n-1; ++i ) {
 
        cin>>b[i];
    }
 
    a[n] = 0;
    a[n+1] = 0;
    b[n-1] = a[n-1];
    b[n] = 0;
    b[n+1] = 0;
}
 
void output( int kq ) {
 
    cout<<kq;
}
 
int solved( int n, int* a, int*b ) {
 
    for( int i = n - 1; i >= 0; --i ) {
 
        a[i] = a[i] + MIN( a[i+1], b[i+1] );
        b[i] = b[i] + MIN( a[i+2], b[i+2] );
    }
 
    return MIN( a[0], b[0] );
}
 
int main(  ) {
 
    int n;
    int* a;
    int* b;
 
    input( n, a, b );
    output( solved( n, a, b ) );
 
    delete []a;
    delete []b;
}

