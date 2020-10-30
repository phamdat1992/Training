#include <cstdio>

int n;

int time [500002] = {0};
int cost [500002] = {0};

long long flagTime [500002] = {0};
long long flagCost [500002] = {0};

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

	for(int i = 1; i <= n; ++i) {

		GET_INT(time[i]);
		GET_INT(cost[i]);
	}
}

void upHeap(long long tcost, long long ttime) {


	flagCost[++flagCost[0]] = tcost;
	flagTime[++flagTime[0]] = ttime;
	
	int i = flagCost[0];
	int j = i >> 1;

	while(j && flagCost[j] > flagCost[i]) {

		flagTime[i] ^= flagTime[j] ^= flagTime[i] ^= flagTime[j];
		flagCost[i] ^= flagCost[j] ^= flagCost[i] ^= flagCost[j];

		i = j;
		j = i >> 1;
	}
}

void popHeap() {

	int r, c;
	
	long long v = flagCost[flagCost[0]--];
	long long f = flagTime[flagTime[0]--];

	r = 1;

	while((r << 1) <= flagCost[0]) {

		c = r << 1;
		if(c < flagCost[0] && flagCost[c+1] < flagCost[c]) { ++c; }
		if(flagCost[c] >= v) { break; }

		flagCost[r] = flagCost[c];
		flagTime[r] = flagTime[c];

		r = c;
	}

	flagCost[r] = v;
	flagTime[r] = f;
}

long long solved() {

	long long re = 0;

	int tcost = 0;
	int ttime = 0;

	for(int i = 1; i <= n; ++i) {

		upHeap(re + cost[i], time[i]);
		for(; flagTime[0] != 0 && flagTime[1] < i; popHeap());

		re = flagCost[1]; 
	}

	return re;
}

int main() {

	input();
	printf("%lld", solved());
}