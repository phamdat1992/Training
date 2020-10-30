#include <cstdio>
#include <iostream>
#include <algorithm>
#include <functional>
#include <cmath>

using namespace std;

int a[1002];
int b[1002][51];
int n, t;

void input() {
	scanf("%d%d", &n, &t);
	for (int i = 1; i <= n; ++i) {
		scanf("%d", &a[i]);
	}
}

int solved() {
	
	int tm[51];
	for (int i = 1; i <= n; ++i) {
		for (int j = 0; j < t; ++j) {
			tm[j] = b[i - 1][j];
			b[i][j] = b[i - 1][j];
		}

		for (int j = 0; j < t; ++j) {
			if (j == 0 || tm[j] > 0) {
				int id = (j + a[i]) % t;
				b[i][id] = max(tm[id], tm[j] + 1);
			}
		}
	}

	return b[n][0];
}

int main() {
	input();
	cout << solved();

	return 0;
}