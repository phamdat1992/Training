#include <iostream>
#include <cstdio>

using namespace std;

long long his[10];
long long res = 0;
int n;

void init() {

	for (int tmp = n; tmp > 0; tmp /= 10) {
		for (int j = 1; j <= 9; ++j) {
			his[j] += tmp / 10;
		}

		for (int j = 1; j <= tmp % 10; ++j) {
			his[j] += 1;
		}
	}
}

long long reduce(long long x) {
	for (; x % 10 == 0; x /= 10);
	return x % 10;
}

long long cal(int v, int l, int i) {
	if (l < i || i < 1) {
		return 1;
	}
	else {
		long long x = v;
		while ((i << 1) <= l) {
			x *= x;
			x = reduce(x);
			i <<= 1;
		}

		x *= cal(v, l - i, 1);
		x = reduce(x);

		return x;
	}
}

long long solved() {

	long long res = 1;
	for (int i = 1; i <= 9; ++i) {
		res *= cal(i, his[i], 1);
	}

	return reduce(res);
}

int main() {

	scanf("%d", &n);
	init();
	cout << solved();
}