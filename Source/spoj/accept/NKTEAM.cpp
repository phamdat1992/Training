#include <cstdio>
#include <algorithm>
#include <cmath>
#include <functional>
#include <map>
#include <iostream>

using namespace std;

struct ac {
	int d1;
	int d2;
	int d3;
};

ac a[100001];
int b[100001];
int n;

bool cmp(ac a, ac b) {
	return a.d1 < b.d1;
}

void input() {
	scanf("%d", &n);
	for (int i = 1, x; i <= n; ++i) {
		scanf("%d", &x);
		a[x].d1 = i;
	}
	for (int i = 1, x; i <= n; ++i) {
		scanf("%d", &x);
		a[x].d2 = i;
	}
	for (int i = 1, x; i <= n; ++i) {
		scanf("%d", &x);
		a[x].d3 = i;
	}
}

void update(int i, int value) {
	while (i <= 100000) {
		b[i] = min(b[i], value);
		i += (i&-i);
	}
}

int get(int i) {
	int res = 1000000;
	while (i > 0) {
		res = min(res, b[i]);
		i &= (i - 1);
	}

	return res;
}

int solved() {
	for (int i = 0; i <= 100000; ++i) {
		b[i] = 1000000;
	}

	int res = 0;
	sort(a, a + n+1, cmp);
	for (int i = 1; i <= n; ++i) {
		int r = get(a[i].d2);
		if (r == 1000000 || r > a[i].d3) {
			++res;
		}

		update(a[i].d2, a[i].d3);
	}

	return res;
}

int main() {
	input();
	cout << solved();
}