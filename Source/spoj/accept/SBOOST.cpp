#include <iostream>
#include <cstdio>
#include <set>
 
using namespace std;
 
class SBOOST {
 
        private:
                long long a;
                long long b;
                long long w;
 
        public:
                SBOOST( long long q, long long x, long long y ) {
 
                                a = x;
                                b = y;
                                w = q;
                        }
 
                long long geta(  ) const { return a; }
                long long getb(  ) const { return b; }
                long long getw(  ) const { return w; }
 
                bool operator < ( SBOOST const &scr ) const {
 
                                return a*scr.b > b*scr.a;
                        }
};
 
void input( long long &f, long long &m, long long &n, set< SBOOST > &s ) {
 
        scanf( "%lld %lld %lld", &f, &m, &n );
 
        for( long long i = 0, e, r; i < n; ++i ) {
 
                scanf( "%lld%lld", &e, &r );
                s.insert( SBOOST( i+1, e, r ) );
        }
}
 
void solved( long long f, long long m, set< SBOOST > &a ) {
 
        set< SBOOST >::const_iterator pos;
        set< long long > kq;
 
        for( pos = a.begin(); pos != a.end(); ++pos ) {
 
                long long e = ( *pos ).geta(  );
                long long r = ( *pos ).getb(  );
 
                if( ( f + e )*m > ( m + r )*f ) {
 
                        f += e;
                        m += r;
 
                        kq.insert( ( *pos ).getw(  ) );
                }
        }
 
        if( kq.size() == 0 ) {
 
                printf( "NONE" );
        }
        else {
 
                for( set< long long >::const_iterator nod = kq.begin(); nod != kq.end(); ++nod ) {
 
                        printf( "%lld\n", *( nod ) );
                }
        }
}
 
int main(  ) {
 
        long long n, m, f;
        set< SBOOST > a;
 
        input( f, m, n, a );
        solved( f, m, a );
}
