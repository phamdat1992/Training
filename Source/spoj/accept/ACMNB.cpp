#include <cstdio>

int a[800000] = {0};
int b[800000] = {0};

int n;

inline void GET_INT( int &x ) {

	register int c;

	while( !( ( x = getchar_unlocked() ) >= '0' && x <= '9' ) );

	x -= '0';
	while( ( ( c = getchar_unlocked() ) >= '0' && c <= '9' ) ) {

		x = ( x<<3 ) + ( x<<1 ) + ( c - '0' );
	}
}

void quickSort(int l, int r) {

	int key = a[(l + r - 1)>>1] - b[(l + r - 1)>>1];

	int i = l, j = r;
    
	while(i <= j) {

		for(; a[i] - b[i] < key; ++i);
		for(; a[j] - b[j] > key; --j);

		if(i <= j) {

			if (i < j) {

				a[i] ^= a[j] ^= a[i] ^= a[j];
				b[i] ^= b[j] ^= b[i] ^= b[j];
			}

			++i;
			--j;
		}
	}

	if (l < j) quickSort(l, j);
	if (i < r) quickSort(i, r);
}

void input() {

	GET_INT(n);

	for(int i = 0; i < (n << 1); ++i) {

		GET_INT(a[i]);
		GET_INT(b[i]);
	}
}

int solved() {

	int re = 0;

	for(int i = 0; i < n; ++i) {

		re += a[i];
	}

	for(int i = n; i < (n << 1); ++i) {

		re += b[i];
	}

	return re;
}

int main() {

	input();
	quickSort(0, (n << 1) - 1);

	printf("%d", solved());
}

