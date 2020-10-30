#include <cstdio>

long long n;

long long a [500000] = {0};
long long b [500000] = {0};

void GET_INT(long long &x) {

	register long long c;

	while( !( ( x = getchar_unlocked() ) >= '0' && x <= '9' ) );

	x -= '0';
	while( ( ( c = getchar_unlocked() ) >= '0' && c <= '9' ) ) {

		x = ( x<<3 ) + ( x<<1 ) + ( c - '0' );
	}
}

long long solved() {

	long long kq = 0;

	for(long long i = 0, f = 0, x = 0; i < n; ++i) {

		//GET_INT(x);
		scanf("%lld", &x);

		for(;f > 0 && a[f-1] < x; kq += b[--f]);

		if(f > 0) {

			if(a[f-1] == x) {

				kq += b[f-1]++;
				kq += (f > 1);
			}
			else if(a[f-1] > x) {

				++kq;
				a[f] = x;
				b[f] = 1;

				++f;
			}
		}
		else if(f == 0) {

			a[f] = x;
			b[f] = 1;

			++f;
		}
	}

	return kq;
}

int main() {

	//GET_INT(n);
	scanf("%lld", &n);
	printf("%lld", solved());
}