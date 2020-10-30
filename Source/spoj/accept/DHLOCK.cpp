#include <cstdio>
#include <algorithm>
#include <cmath>
#include <functional>
#include <map>
#include <iostream>

using namespace std;

int a[1000];
int b[1000];
int n, k;

void input() {
	scanf("%d%d", &n, &k);
	for (int i = 0; i < n; ++i) {
		scanf("%d", &a[i]);
	}
	for (int i = 0; i < n; ++i) {
		scanf("%d", &b[i]);
	}
}

int solved() {
	int cost = 1000000000;
	int tm1[1000];
	int tm2[1000];

	for (int i = 0; i < n; ++i) {
		int tmc = (n-i)%n;
		for (int j = 0; j < n; ++j) {
			int id = (i + j) % n;
			tm1[j] = a[id];
			tm2[j] = b[j];
		}

		int tmc2;
		for (int z = 0; z < n; ++z) {
			int cc = tm2[z] - tm1[z];

			if (cc < 0) { cc += k; }
			tmc2 = cc;
			for (int w = 0; w < n; ++w) {
				int tr = tm2[w] - tm1[w] - cc;
				if (tr < 0) { tr += k; }
				if (tr < 0) { tr += k; }
				if (tr < 0) { tr += k; }
				tmc2 += tr;
			}

			cost = min(cost, tmc2 + tmc);
		}
	}

	return cost;
}

int main() {
	input();
	++k;
	cout << solved();

	return 0;
}