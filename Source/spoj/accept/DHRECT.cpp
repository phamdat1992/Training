#include <cstdio>

int a[300000];

int n, t;

inline void GET_INT( int &x ) {

	register int c;

	while( !( ( x = getchar_unlocked() ) >= '0' && x <= '9' ) );

	x -= '0';
	while( ( ( c = getchar_unlocked() ) >= '0' && c <= '9' ) ) {

		x = ( x<<3 ) + ( x<<1 ) + ( c - '0' );
	}
}

void input() {
	
	GET_INT(n);
	for(int i = 0; i < n; ++i) {
		
		GET_INT(a[i]);
	}
}

void quickSort(int l, int r) {

	int key = a[(l + r)>>1];

	int i = l, j = r;
    
	while(i <= j) {

		for(; a[i] > key; ++i);
		for(; a[j] < key; --j);

		if(i <= j) {

			if (i < j) {

				a[i] ^= a[j] ^= a[i] ^= a[j];
			}

			++i;
			--j;
		}
	}

	if (l < j) quickSort(l, j);
	if (i < r) quickSort(i, r);
}

long long solved() {
	
	int gx [10];
	int gy [10];
	
	int f = 0;
	gx[f] = 0;
	gy[f] = 0;
	
	for(int i = 0; i < n; ++i) {
		
		if(a[i] != gx[f]) {
			
			if(gy[f] >= 2) {
				
				++f;
			}
			
			gx[f] = a[i];
			gy[f] = 1;
		}
		else {
			
			++gy[f];
			if(gy[f] >= 4) {
				
				return (long long)gx[0]*(long long)gx[0];
			}
			else if(gy[f] >= 2 && f > 0) {
				
				return (long long)gx[0]*(long long)gx[1];
			}
		}
	}
	
	return -1;
}

int main() {
	
	GET_INT(t);
	for(int i = 0; i < t; ++i) {
		
		input();
		quickSort(0, n-1);
		printf("%lld\n", solved());
	}
}

