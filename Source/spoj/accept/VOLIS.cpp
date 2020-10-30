#include <cstdio>

int a [1001][2] = {0};
int b [1001][2] = {0};

int n, d;

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
	GET_INT(d);
	for(int i = 0, x; i < n; ++i) {
		
		GET_INT(x);
		
		a[i][0] = x + d;
		a[i][1] = x - d;
	}
}

int max(int a, int b) {
	
	return (a > b)? a : b;
}

int solved() {

	if(n == 0) {
		
		return 0;
	}	
	
	int res = 1;
	for(int i = 0; i < n; ++i) {
		
		b[i][0] = max(1, b[i][0]);
		b[i][1] = max(1, b[i][1]);
		for(int j = i + 1; j < n; ++j) {
			
			if(a[i][1] <= a[j][1]) {
				
				b[j][1] = max(b[j][1], b[i][1] + 1);
				res = max(res, b[j][1]);
			}
			else if(a[i][1] > a[j][1] && a[i][1] <= a[j][0]) {
				
				++b[i][1];
				res = max(res, b[i][1]);
			}
		}
	}
	
	return res;
}

int main() {
	
	input();
	printf("%d", solved());
}
