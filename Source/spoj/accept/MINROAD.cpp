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
};

int n, a, b;
ac s[300001];

void input() {
	scanf("%d%d%d", &n, &a, &b);
	for (int i = 1; i <= n; ++i) {
		scanf("%d%d", &s[i].d1, &s[i].d2);
	}
}

bool cmp(ac a, ac b) {
	return a.d1 < b.d1;
}

int solved() {
	sort(s + 1, s + n + 1, cmp);
	int res = 1000000000;
	int start = 1;
	int c1 = (s[1].d2 == 1);
	int c2 = (s[1].d2 == 2);

	for (int i = 2; i <= n; ++i) {
		c1 += (s[i].d2 == 1);
		c2 += (s[i].d2 == 2);

		while (c1 > a) {
			if (s[start].d2 == 1) {
				--c1;
				++start;
				continue;
			}
			else {
				if (c2 > b) {
					while (c2 > b) {
						if (s[start].d2 == 2) {
							++start;
							--c2;
						}
						else {
							break;
						}
					}
					continue;
				}
			}

			break;
		}

		while (c2 > b) {
			if (s[start].d2 == 2) {
				--c2;
				++start;
				continue;
			}
			else {
				if (c1 > a) {
					while (c1 > a) {
						if (s[start].d2 == 1) {
							++start;
							--c1;
						}
					}

					continue;
				}
			}

			break;
		}

		if (c1 >= a && c2 >= b) {
			res = min(res, s[i].d1 - s[start].d1);
		}
	}

	return res;
}

int main() {
	input();
	int r = solved();

	if (r == 1000000000) {
		cout << -1;
	}
	else {
		cout << r;
	}
}