#include <cstdio>

int a [10000] = {0};
int b [10000] = {0};

int go [30001] = {0};

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

	int key = a[(l + r - 1)>>1];

	int i = l, j = r;
    
	while(i <= j) {

		for(; a[i] < key; ++i);
		for(; a[j] > key; --j);

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

	for(int i = 0; i < n; ++i) {

		GET_INT(a[i]);
		GET_INT(b[i]);
	}
}

inline int max(int a, int b) {

	return (a > b)? a : b;
}

int solved() {

	int re = 0;

	for(int i = 0, j = 0; i <= 30000 ; ++i ) {

		re = max(re, go[i]);

		for(; j < n && a[j] == i; ++j) {

			int tmp = b[j];
			go[tmp] = max(go[tmp], re + b[j] - i);
		}

		re = max(re, go[i]);
	}

	return re;
}

int main() {

	input();
	quickSort(0, n-1);

	printf("%d", solved());
}