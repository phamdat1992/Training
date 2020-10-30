#include <cstdio>

int a [100000] = {0};
int b [100000] = {0};

const int modun = 2111992;
int n, k;

int solved() {

	a[0] = 1;
	b[0] = 1;

	for(int i = 1; i < n; ++i) {

		//female
		a[i] = a[i-1] + b[i-1];

		if(i > k) {

			b[i] = b[i-k-1];
			b[i] += a[i-k-1];
		}
		else {

			b[i] = 1;
		}

		if(a[i] >= modun) {

			a[i] %= modun;
		}

		if(b[i] >= modun) {

			b[i] %= modun;
		}
	}

	return (a[n-1] + b[n-1]) % modun;
}

int main() {

	scanf("%d %d", &n, &k);
	printf("%d", solved());
}