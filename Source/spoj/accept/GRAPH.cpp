#include <cstdio>

int f [1001][1001] = {0};
short edg [1000050][2];

inline void readShort( short &x ) {

	register int c;

	while( !( ( x = getchar_unlocked() ) >= '0' && x <= '9' ) );

	x -= '0';
	while( ( ( c = getchar_unlocked() ) >= '0' && c <= '9' ) ) {

		x = ( x<<3 ) + ( x<<1 ) + ( c - '0' );
	}
}

int main(  ) {

	int len = 0;

	short u, v;
	short n, k;
	short c1, c2;

	int d = 0;

	char st = getchar_unlocked();
	char ft = getchar_unlocked();
	char rt = getchar_unlocked();

	for( ; ( st ^ 'E' ) | ( ft ^ 'N' );  ) {		

		switch( st ) {

			case 'A':	switch( ft ) {

						case 'D':	readShort( u );
								readShort( v );

								if( f[u][v] != d ) {

									f[u][v] = d;
									++len;
									edg[len][0] = u;
									edg[len][1] = v;
								}

								break;

						case 'N':	for( ; len && ( f[edg[len][0]][edg[len][1]] != d ); --len );

								if( len ) {

									printf( "%hd %hd\n", edg[len][0], edg[len][1] );

									f[edg[len][0]][edg[len][1]] = -d;
									--len;
								}
								else if( k && c1 <= n ) {

									for( ; ( c2 > n ) || ( c2 <= n && f[c1][c2] == -d ); ++c2 ) {

										if( c2 > n ) {

											if( ++c1 > n ) { break; }
											c2 = 0;
										}
									}

									if( c1 <= n && c2 <= n ) {

										printf( "%hd %hd\n", c1, c2 );

										f[c1][c2] = -d;
									}
									else { puts( "-1" ); }
								}
								else { puts( "-1" ); }

								break;
					};

					break;

			case 'D':	readShort( u );
					readShort( v );

					f[u][v] = -d;

					break;

			case 'E':	readShort( u );
					readShort( v );

					if( f[u][v] == d || ( k && f[u][v] != -d ) ) {

						puts( "YES" );
					}
					else { puts( "NO" ); }

					break;

			case 'N':	readShort( n );
					readShort( k );

					len = 0;
					++d;					

					c1 = 1;
					c2 = 1;
		};

		scanf( "\n" );
		st = getchar_unlocked();
		ft = getchar_unlocked();
		rt = getchar_unlocked();
	}
}



