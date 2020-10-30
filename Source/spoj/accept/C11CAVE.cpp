#include <iostream>
#include <cstdio>

using namespace std;

int a[500001];
int b[500001];
int n, h;

void input() {
	scanf("%d%d", &n, &h);
	int x, y;
	for (int i = 0; i < n; ++i) {
		if (i & 1) {
			scanf("%d", &x);
			++a[x];
		}
		else {
			scanf("%d", &y);
			++b[y];
		}
	}
}

void solved() {
	int resh = 1000000000;
	int count = 0;
	int n1 = n >> 1;
	int n2 = 0;
	for (int i = 1; i <= h; ++i) {
		int tmp = (a[i]+n1-a[i]) + b[h - i + 1]+n2;
		if (tmp < resh) {
			resh = tmp;
			count = 1;
		} else if (tmp == resh) {
			++count;
		}

		n1 -= a[i];
		n2 += b[h - i + 1];
	}

	cout << resh << " " << count;
}

int main() {
	input();
	solved();

	return 0;
}