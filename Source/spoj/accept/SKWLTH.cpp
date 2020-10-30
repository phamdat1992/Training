#include <algorithm>
#include <cstdio>
#include <iostream>

using namespace std;

struct ac {
	int h;
	int w;
	int index;
};

int hicp[30001];
int kq[30001];
int bit[30001];
ac a[30001];
int n;

bool cmp(ac a, ac b) {
	return (a.h < b.h);
}

void input() {
	cin >> n;
	for (int i = 0; i < n; ++i) {
		cin >> a[i].h >> a[i].w;
		a[i].index = i;
	}
}

void update(int i, int value) {
	while (i <= 30000) {
		bit[i] = max(bit[i], value);
		i += (i&-i);
	}
}

int get(int i) {
	int res = 0;
	while (i > 0) {
		res = max(res, bit[i]);
		i &= (i - 1);
	}

	return res;
}

int main() {
	input();
	sort(a, a + n, cmp);

	int rt = -1;
	for (int i = 0; i < n; ) {
		if (a[i].h != rt) {
			int j;
			for (j = i; j < n && a[j].h == a[i].h; ++j) {
				kq[a[j].index] = get(30001-a[j].w-1) + 1;
			}
			for (j = i; j < n && a[j].h == a[i].h; ++j) {
				update(30001-a[j].w, kq[a[j].index]);
			}

			rt = a[i].h;

			i = j;
		}
		else {
			++i;
		}
	}

	for (int i = 0; i < n; ++i) {
		cout << kq[i] << endl;
	}
}