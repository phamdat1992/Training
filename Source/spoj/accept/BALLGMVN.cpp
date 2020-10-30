#include <iostream>
#include <cstdio>
#include <map>
#include <algorithm>
#include <cmath>
#include <functional>
#include <string>

using namespace std;

struct node {
	int x;
	int y;
};

struct ac {
	int id1;
	int id2;
	double ff;
};

node a[2002];
ac b[2000000];
int n;

bool cmp(ac &x1, ac &x2) {
	if (x1.id1 < x2.id1) {
		return true;
	}
	else if (x1.id1 == x2.id1) {
		return (x1.ff < x2.ff);
	}

	return false;
}

void quickSort(int l, int r) {

	ac key = b[(l + r - 1) >> 1];

	int i = l, j = r;

	while (i <= j) {

		for (; cmp(b[i], key); ++i);
		for (; cmp(key, b[j]); --j);

		if (i <= j) {

			if (i < j) {

				swap(b[i].ff, b[j].ff);
				b[i].id1 ^= b[j].id1 ^= b[i].id1 ^= b[j].id1;
				b[i].id2 ^= b[j].id2 ^= b[i].id2 ^= b[j].id2;
			}

			++i;
			--j;
		}
	}

	if (l < j) quickSort(l, j);
	if (i < r) quickSort(i, r);
}

void input() {
	scanf("%d", &n);
	n <<= 1;
	for (int i = 1; i <= n; ++i) {
		scanf("%d", &a[i].x);
		scanf("%d", &a[i].y);
	}
}	

void add(int i, int j, int nb) {
	double mau = (double)a[i].y - (double)a[j].y;
	double tu = (double)a[i].x - (double)a[j].x;
	double radius;
	if (mau == 0.0) {
		radius = 1000000000.0;
	}
	else {
		radius = (tu) / (mau);
	}

	b[nb].ff = radius;
	b[nb].id1 = i;
	b[nb].id2 = j;
}

void solved() {

	for (int i = 1; i <= (n>>1); ++i) {
		for (int j = (n>>1)+1, nb = 0; j <= n; ++j, ++nb) {
			add(i, j, nb);
		}

		quickSort(0, (n>>1)-1);
		int fr = 1000000000;
		double xr = 100000000000.0;
		for (int ik = 0; ik < (n >> 1); ++ik) {
			if (b[ik].ff != xr) {
				fr = b[ik].id2;
				xr = b[ik].ff;
			}
			else {
				cout << fr << " " << b[ik].id1 << " " << b[ik].id2;
				return;
			}
		}
	}

	for (int i = (n >> 1)+1; i <= n; ++i) {
		for (int j = 1, nb = 0; j <= (n >> 1); ++j, ++nb) {
			add(i, j,  nb);
		}

		quickSort(0, (n >> 1) - 1);
		int fr = 1000000000;
		double xr = 100000000000.0;
		for (int ik = 0; ik < (n >> 1); ++ik) {
			if (b[ik].ff != xr) {
				xr = b[ik].ff;
				fr = b[ik].id2;
			}
			else {
				cout << fr << " " << b[ik].id1 << " " << b[ik].id2;
				return;
			}
		}
	}

	cout << -1;
}

int main() {
	input();
	solved();
}