#include <iostream>
#include <cstdio>

using namespace std;

int t [100000<<2] = {0};
bool f [100000<<2] = {0};

void update( int i, int l, int r, int u, int v ) {

	if( v < l || u > r ) { return; }
	else if( u <= l && r <= v ) {

		f[i] ^= 1;
		t[i] = r - t[i] - l + 1;

		return;
	}

	f[i<<1] ^= f[i];
	f[(i<<1)+1] ^= f[i];

	int m = ( l + r )>>1;

	if( f[i] == 1 ) {

		t[i<<1] = m - t[i<<1] -l + 1;
		t[(i<<1)+1] = r - t[(i<<1)+1] - m;
	}

	f[i] = 0;

	update( i<<1, l, m, u, v );
	update( (i<<1)+1, m+1, r, u, v );

	t[i] = t[i<<1] + t[(i<<1)+1];
}

int query( int i, int l, int r, int u, int v ) {

	if( v < l || u > r ) { return 0; }
	else if( u <= l && r <= v ) {

		return t[i];
	}

	f[i<<1] ^= f[i];
	f[(i<<1)+1] ^= f[i];

	int m = ( l + r )>>1;

	if( f[i] == 1 ) {

		t[i<<1] = m - t[i<<1] -l + 1;
		t[(i<<1)+1] = r - t[(i<<1)+1] - m;
	}

	f[i] = 0;

	int res = 0;
	res += query( i<<1, l, m, u, v );
	res += query( (i<<1)+1, m+1, r, u, v );

	return res;
}

int main(  ) {

	int n, m;

	scanf( "%d%d", &n, &m );
	for( int i = 0, w, u, v; i < m; ++i ) {

		scanf( "%d%d%d", &w, &u, &v );

		if( w == 0 ) { update( 1, 1, n, u, v ); }
		else { printf( "%d\n", query( 1, 1, n, u, v ) ); }
	}
}