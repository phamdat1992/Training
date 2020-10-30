#include <iostream>
 
using namespace std;
 
void input( int &n, int* &a ) {
 
    cin>>n;
        
        a = new int [n];
        for( int i = 0; i < n; ++i ) {
 
                cin>>a[i];
        }
}
 
void output( int kq ) {
 
        cout<<kq;
}
 
int solved( int n, int* a ) {
 
        int* b = new int [n];//min trai
        int* c = new int [n];//cong don
        int* d = new int [n];//min phai
 
        int count = 0;
        int min = 0;
        int t = 0;
        int h = 0;
 
        for( int i = 0; i < n; ++i ) {
        
                c[i] = t + a[i];
                t = c[i];
 
                min = ( min > c[i] )? c[i] : min;
                b[i] = min;
 
                if( h <= 0 || a[ n-1-i ] < 0 ) {
 
                        h += a[n-i-1];
                }
                if( h > 0 ) { h = 0; }
 
                d[ n-1-i ] = h;
        }
 
        for( int i = 0; i < n; ++i ) {
 
                if( a[i] > 0 ) {
 
                        if( i+1 < n && d[i+1]+a[i] > 0 || i+1 == n ) {
                                
                                if( i-1 >= 0 && c[ n-1 ]-c[i]+a[i]+b[i-1] > 0 || i == 0 ) {
 
                                        ++count;
                                }
                        }
                }
        }
 
        delete []b;
        delete []c;
        delete []d;
 
        return count;
}
 
int main(  ) {
 
        int n;
        int *a;
 
        input( n, a );
        output( solved( n, a ) );
 
        delete []a;
}

