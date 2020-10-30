#include <iostream>
#include <cstdio>
#include <algorithm>
#include <cmath>

using namespace std;

struct ac {
	bool type;
	int value;
};

int res[2000][2000];
ac store[2000][2000];
int n, m;

void input() {

	char c;
	scanf("%d%d", &n, &m);
	for (int i = 1; i <= n; ++i) {
		for (int j = 1; j <= m; ++j) {
			do {
				c = getchar();
				if (c == 'A' || c == 'B') {
					scanf("%d", &store[i][j].value);
					store[i][j].type = (c == 'A');
				}
			} while (c != 'A' && c != 'B');
		}
	}
}

int solved() {
	int f1[2000];
	int f2[2000];

	for (int i = 1; i <= n; ++i) {
		for (int j = 1; j <= m; ++j) {
			if (store[i][j].type == true) {
				f1[j] = f1[j-1] + store[i][j].value;
				f2[j] = f2[j-1];
			}
			else {
				f1[j] = f1[j-1];
				f2[j] = f2[j-1] + store[i][j].value;
			}
		}

		for (int j = 1; j <= m; ++j) {
			if (j == 1) {
				res[i][j] = max(res[i][j], res[i - 1][j] + f1[j - 1] + f2[m] - f2[j]);
			}
			else {
				res[i][j] = max(res[i][j], res[i - 1][j - 1] + f1[j - 1] + f2[m] - f2[j]);
				res[i][j] = max(res[i][j], res[i - 1][j] + f1[j - 1] + f2[m] - f2[j]);
				if (store[i][j].type == false) {
					res[i][j] = max(res[i][j], res[i][j - 1] - store[i][j].value);
				}
				else {
					res[i][j] = max(res[i][j], res[i][j - 1]);
				}
			}
		}
	}

	return res[n][m];
}

int main() {
	input();
	cout << solved();
}