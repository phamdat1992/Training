#include <cstdio>

bool a[1000004] = {false};
int b[1000004] = {0};
int n;

void init() {

	for(int i = 2; i <= 1000; ++i) {

		for(int j = i; j*i <= 1000003; ++j) {

			a[i*j] = true;
		}
	}

	int f = 2;

	for(int i = 3; i <= 1000003; ++i) {

		if(a[i] == true) { b[i] = f; }
		else {

			b[f] = i;
			f = i;
			b[i] = i;
		}
	}
}

int abs(int x) {

	return (x < 0)? -x : x;
}

int solved(int x) {

	int g1 = b[x];
	int g2 = b[b[x]];

	if(a[x] == false) {

		return 0;
	}
	else {

		return(abs(x - g1) < abs(g2 - x))? abs(x - g1) :abs(g2 - x);
	}
}

int main() {

	init();
	scanf("%d", &n);
	
	for(int i = 0, x; i < n; ++i) {

		scanf("%d", &x);
		printf("%d\n", solved(x));
	}
}