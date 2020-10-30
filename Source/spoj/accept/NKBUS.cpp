#include <iostream>
 
using namespace std;

typedef long long int64;

int64 popheap( int64* a ) {

    int64 r,c,v;
    int64 kq = a[1];
    
    v = a[a[0]--];
    r = 1l;
    
    while( ( r<<1 ) <= a[0] ) {
          
        c = r<<1;
        if( c < a[0] && a[c+1] < a[c] ) { ++c; }
        if( a[c] >= v ) { break; }
        
        a[r] = a[c];
        r = c;
    }
    
    a[r] = v;
    
    return kq;
}

void upheap( int64* a, int64 x ) {

    a[++a[0]] = x;
    
    int64 l = a[0];
    int64 i = l >> 1;
    
    while( i && a[i] > a[l] ) {
    
           swap( a[i], a[l] );
           
           l = i;
           i = l >> 1;       
    }
}
 
void input( int64 &n, int64 &m, int64 &sum, int64 &sonv, int64* a ) {
 
    cin>>n;
    cin>>m;
 
    sum = 0l;
    sonv = 0l;
    
    a[0] = 0l;
 
    for( int i = 0l; i < n; ++i ) {
 
        int64 tem;
        int64 wr;
 
        cin>>tem;
        cin>>wr;
 
        for( int64 j = 0l; j < wr; ++j ) {
 
            int64 we;
 
            cin>>we;
            if( we <= sum ) {
 
                ++sonv;
            }
            else {
 
                upheap( a, we - sum );
            }
        }
 
        sum += tem;
    }
}
 
void output( int64 kq ) {
 
    cout<<kq;
}
 
int main(  ) {
 
    int64* a = new int64[ 250000 ];
 
    int64 n, m;
    int64 sum, sonv;
 
    input( n, m, sum, sonv, a );
        
    int64 h = a[0];
    int64 t = 0l;
    
    if( m > sonv ) {   

        if( m - sonv < a[0] ) {
                
                for( h = m - sonv; h > 0l; --h ) {
                
                     t = popheap( a );     
                }
        }
        else {
                for( int64 i = 1l; i <= h; ++i ) {
     
                        if( a[i] > t ) {
     
                                 t = a[i];
                        }
                }
        }
    }
 
    delete []a;

    output( sum + t );
}