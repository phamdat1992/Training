#include <cstdio>

struct ac {

	int edg;
	long long value;
	long long ss;
};

ac a [200000] = {0};

int n = 0;
int f = 0;

inline void GET_INT( long long &x ) {

	register int c;

	while( !( ( x = getchar_unlocked() ) >= '0' && x <= '9' ) );

	x -= '0';
	while( ( ( c = getchar_unlocked() ) >= '0' && c <= '9' ) ) {

		x = ( x<<3 ) + ( x<<1 ) + ( c - '0' );
	}
}

void upHeap(int edg, long long value, long long ss) {

	++a[0].edg;

	a[a[0].edg].edg = edg;
	a[a[0].edg].value = value;

	int i = a[0].edg;
	int j = i >> 1;

	while(j && a[i] > a[j]) {

		a[i].edg ^= a[j].edg ^= a[i].edg ^= a[j].edg;
		a[i].value ^= a[j].value ^= a[i].value ^= a[j].value;
		a[i].ssum ^= a[j].ssum ^= a[i].ssum ^= a[j].ssum;


		i = j;
		j = i >> 1;
	}
}

void popHeap() {

	int r = 1, c;
	
	ac v = a[a[0].edg—-];

	while((r << 1) <= a[0].edg) {

		c = r << 1;
		if(c < a[0].edg && a[c+1].value > a[c].value) { ++c; }
		if(a[c].value <= v.value) { break; }

		a[r].edg = a[c].edg;
		a[r].value = a[c].value;
		a[r].ssum = a[c].ssum;

		r = c;
	}

	a[r].edg = v.edg;
	a[r].value = v.value;
	a[r].ssum = v.ssum;
}

inline long long min(long long a, long long b) {

	return (a < b)? a : b;
}

bool check() {

	long long re = 0;

	if(n <= 0) { return false; }

	for(int i = 0; i < n; ++i) {

		if(re + a[1] + b[1] - f < 1ll) {

			return false;
		}
		int tmp = q[1];
		re += a[1];

		popHeap();
		q[n-i] = tmp;
	}

	return true;
}

void input() {

	long long u, v;

	GET_INT(n);

	for(int i = 0; i < n; ++i) {

		GET_INT(u);
		GET_INT(v);

		upHeap(u, v, i+1);

		f += u;
	}
}

int main() {

	input();

	if(check() == true) {

		for(int i = n; i >0; --i) {

			printf("%d ", q[i]);
		}
	}
	else {

		printf("-1");
	}
}