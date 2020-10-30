#include <iostream>
#include <cstdio>

using namespace std;

struct ac {
	int h;
	int l;
};

int a[1001][1001];
int h[1001][1001];
ac st[1001];
int n, m, len;

void input() {
	scanf("%d%d", &n, &m);
	char c;
	for (int i = 1; i <= n; ++i) {
		for (int j = 1; j <= m; ++j) {
			do {
				c = getchar();
			} while (c != '0' && c != '1');
			
			a[i][j] = (c== '1');
		}
	}
}

void init() {
	for (int i = 0; i <= 1000; ++i) {
		st[i].h = st[i].l = 0;
	}
}

long long solved() {
	long long res = 0ll;

	for (int i = 1; i <= n; ++i) {
		len = 0;
		long long tr = 0ll;
		for (int j = 1; j <= m; ++j) {
			int rr = 1;
			if (a[i][j] == true) {
				h[i][j] = h[i - 1][j] + 1;
			}

			if (h[i][j] < st[len].h) {
				while (h[i][j] < st[len].h) {
					tr -= st[len].h*st[len].l;
					rr += st[len].l;
					--len;
				}
			}
			if (h[i][j] != st[len].h) {
				++len;
				st[len].h = h[i][j];
				st[len].l = rr;
				tr += st[len].h*rr;
			}
			else if (h[i][j] == st[len].h) {
				st[len].l += rr;
				tr += st[len].h*rr;
			}

			res += tr;
		}
	}

	return res;
}

int main() {
	input();
	init();
	cout << solved();
}