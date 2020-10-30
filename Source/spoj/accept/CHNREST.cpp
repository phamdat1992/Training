#include <iostream>
#include <cstdio>

using namespace std;

bool s [50][50] = {0};
long long a [50];

long long f [2000000] = {0};
bool r [2000000] = {0};

int n, m;

bool GET_INT( int &x ) {

	register int c;

	x = -1;
	for( c = getchar_unlocked(); ( c < '0' || c > '9' ) && ( c != '\n' ) && ( c != -1 ); c = getchar_unlocked() );

	if( c == '\n' || c == -1 ) { return false; }
	else {

		x = c - '0';
		for( c = getchar_unlocked(); c >= '0' && c <= '9'; c = getchar_unlocked() ) {

			x = ( x<<3 ) + ( x<<1 ) + c - '0';
		}

		if( c == '\n' || c == -1 ) { return false; }
		else { return true; }
	}
}

void input(  ) {

	scanf( "%d%d", &m, &n );

	for( int i = 0; i < m; ++i ) {

		scanf( "%lld", &a[i] );
	}

	scanf( "\n" );
	for( int i = 0; i < n; ++i ) {

		for( int u, f = 1; f > 0; ) {

			f = GET_INT( u );

			if( u > -1 ) { s[i][u-1] = 1; }
		}
	}
}

void output( long long kq ) {

	printf( "%lld", kq );
}

void init( int fm ) {

	int g = ( 1<<fm ) - 1;
	r[0] = 1;

	for( int i = 0; i <= g; ++i ) {

		int q = 0;
		long long k = 0;
		for( int j = 0, c = i; c > 0 && q > -1; c >>= 1, ++j ) {

			if( c&1 ) {

				for( int h = 0; h < n; ++h ) {

					if( s[h][j] == 1 ) {

						if( ( ( q >> ( h<<1 ) ) & 1 ) == 0 ) {

							q |= ( 1 << ( h<<1 ) );
						}
						else if( ( ( q >> ( ( h<<1 ) + 1 ) ) & 1 ) == 0 ) {

							q |= 1 << ( ( h<<1 ) + 1 );
						}
						else {

							q = -1;
							break;
						}
					}
				}

				k += a[j];
			}
		}

		if( q > 0 && ( r[q] == 0 || f[q] > k ) ) {

			f[q] = k;
			r[q] = 1;
		}
	}
}

long long solved( int fm ) {

	int g = ( 1<<fm ) - 1;
	long long kq = -1;
	int z = ( 1 << ( n<<1 ) ) - 1;

	for( int i = 0; i <= g; ++i ) {

		int q1 = 0;
		int q2 = z;

		long long k = 0;
		for( int j = m>>1, c = i; c > 0 && q1 > -1; c >>= 1, ++j ) {

			if( c&1 ) {

				for( int h = 0; h < n; ++h ) {

					if( s[h][j] == 1 ) {

						if( ( ( q1 >> ( h<<1 ) ) & 1 ) == 0 ) {

							q1 |= ( 1 << ( h<<1 ) );
							q2 ^= 1 << ( ( h<<1 ) + 1 );
						}
						else if( ( ( q1 >> ( ( h<<1 ) + 1 ) ) & 1 ) == 0 ) {

							q1 |= 1 << ( ( h<<1 ) + 1 );
							q2 ^= ( 1 << ( h<<1 ) );
						}
						else {

							q1 = -1;
							q2 = -1;

							break;
						}
					}
				}

				k += a[j];
			}
		}

		if( q1 != -1 && r[q2] == 1 ) {

			if( kq == -1 || kq > f[q2] + k ) {

				kq = f[q2] + k;
			}
		}
	}

	return kq;
}

int main(  ) {

	input(  );

	init( m>>1 );
	output( solved( m - ( m>>1 ) ) );
}