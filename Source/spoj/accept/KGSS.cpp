#include <cstdio>
#include <algorithm>
#include <cmath>
#include <functional>
#include <map>
#include <iostream>

using namespace std;

struct ac {
	int v1;
	int v2;
};

int a[100000];
ac s[1000000];
int n, q, x, y;

void input() {
	scanf("%d", &n);
	for (int i = 0; i < n; ++i) {
		scanf("%d", &a[i]);
	}
}

void init(int l, int r, int i) {
	if (l == r) {
		s[i].v1 = a[l];
		s[i].v2 = -1000000000;
	}
	else {
		int mid = (l + r) >> 1;
		int id1 = i << 1;
		int id2 = (i << 1) + 1;

		init(l, mid, id1);
		init(mid + 1, r, id2);

		if (s[id1].v1 > s[id2].v1) {
			s[i].v1 = s[id1].v1;
			s[i].v2 = max(s[id1].v2, s[id2].v1);
		}
		else if (s[id2].v1 > s[id1].v1) {
			s[i].v1 = s[id2].v1;
			s[i].v2 = max(s[id2].v2, s[id1].v1);
		}
		else {
			s[i].v1 = s[id2].v1;
			s[i].v2 = s[i].v1;
		}
	}
}

void update(int l, int r, int i, int index, int value) {
	if (l > index || r < index) { 
		return; 
	}
	else if (l == r && l == index) {
		s[i].v1 = value;
		s[i].v2 = -1000000000;
	}
	else {
		int mid = (l + r) >> 1;
		int id1 = i << 1;
		int id2 = (i << 1) + 1;

		update(l, mid, id1, index, value);
		update(mid + 1, r, id2, index, value);

		if (s[id1].v1 > s[id2].v1) {
			s[i].v1 = s[id1].v1;
			s[i].v2 = max(s[id2].v1, s[id1].v2);
		}
		else if (s[id1].v1 < s[id2].v1) {
			s[i].v1 = s[id2].v1;
			s[i].v2 = max(s[id2].v2, s[id1].v1);
		}
		else {
			s[i].v1 = s[id2].v1;
			s[i].v2 = s[i].v1;
		}
	}
}

bool getValue(int l, int r, int i, int dl, int dr, ac &x) {
	if (l > dr || r < dl) {
		return false;
	}
	else if (l >= dl && r <= dr) {
		x.v1 = s[i].v1;
		x.v2 = s[i].v2;
		return true;
	}
	else {
		int mid = (l + r) >> 1;
		int id1 = i << 1;
		int id2 = (i << 1) + 1;

		ac rr1, rr2;

		if (getValue(l, mid, id1, dl, dr, rr1)) {
			x.v1 = rr1.v1;
			x.v2 = rr1.v2;

			if (getValue(mid + 1, r, id2, dl, dr, rr2)) {
				if (x.v1 > rr2.v1) {
					x.v2 = max(x.v2, rr2.v1);
				}
				else if (rr2.v1 > x.v1) {
					x.v2 = max(rr2.v2, x.v1);
					x.v1 = rr2.v1;
				}
				else {
					x.v2 = x.v1;
				}
			}
		}
		else if (getValue(mid + 1, r, id2, dl, dr, rr2)){
			x.v1 = rr2.v1;
			x.v2 = rr2.v2;
		}
		else {
			return false;
		}

		return true;
	}
}

int main() {
	input();
	init(0, n-1, 1);
	scanf("%d", &q);
	ac res;
	char c;
	for (int i = 0; i < q; ++i) {
		scanf("\n%c %d %d", &c, &x, &y);
		switch (c) {
		case 'U':
			update(0, n - 1, 1, x - 1, y);
			break;
		case 'Q':
			getValue(0, n - 1, 1, x - 1, y - 1, res);
			printf("%d\n", res.v1+res.v2);
			break;
		}

	}
}