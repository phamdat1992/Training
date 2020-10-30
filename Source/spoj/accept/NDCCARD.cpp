#include <cstdio>
#include <iostream>

using namespace std;

bool a[10001];
int n, m;

void input() {
	scanf("%d%d", &n, &m);
	int x;
	for (int i = 0; i < n; ++i) {
		scanf("%d", &x);
		a[x] = true;
	}
}

int solved() {
	int res = 0;
	for (int i = 1; i <= 10000; ++i) {
		if (a[i] == true) {
			int r = 1;
			int l = 10000;
			int st = r;
			int next = r;
			for (; l > r; --l) {
				if (a[l] && l != i) {
					for (; r < l; r = next) {
						if (a[r] && r != i) {
							int luu = i + r + l;
							if (luu <= m) {
								st = r;
								next = (next > r) ? next : r + 1;
								if (luu >= res) {
									res = luu;
								}
							}
							else {
								next = r;
								r = st;
								break;
							}		
						} else {
						
							next = (next > r) ? next : r + 1;
						}
					}
				}
			}
		}
	}

	return res;
}

int main() {
	input();
	cout << solved();
}