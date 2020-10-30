#include <iostream>
#include <cstdio>
#include <functional>
#include <algorithm>
#include <cmath>

using namespace std;

struct ac {
	int h;
	int w;
	int z;
};

struct luu {
	int flag;
	int id;
};

luu sr[100002];
ac a[300001];
int bit[100002];
int n;
int res[300001];

void input() {

	scanf("%d", &n);
	for (int i = 0; i < n; ++i) {
		scanf("%d%d", &a[i].h, &a[i].w);
		a[i].z = i;
	}
}

bool cmp(ac a, ac b) {
	return (a.h < b.h || (a.h== b.h && a.w < b.w));
}

void update(int i) {
	while (i <= 100001) {
		++bit[i];
		i += (i&-i);
	}
}

int get(int i) {
	int res = 0;
	while (i > 0) {
		res += bit[i];
		i &= (i - 1);
	}

	return res;
}

int main() {
	input();
	sort(a, a + n, cmp);
	
	for (int i = 0; i <= 100000; ++i) {
		sr[i].flag = sr[i].id = 0;
	}

	for (int i = 0; i < n; ++i) {
		res[a[i].z] = get(a[i].w + 1);
		if (sr[a[i].w + 1].flag != a[i].h) {
			sr[a[i].w + 1].flag = a[i].h;
			sr[a[i].w + 1].id = 1;
		}
		else {
			res[a[i].z] -= sr[a[i].w + 1].id;
			++sr[a[i].w + 1].id;
		}

		update(a[i].w + 1);
	}

	for (int i = 0; i < n; ++i) {
		printf("%d\n", res[i]);
	}
}