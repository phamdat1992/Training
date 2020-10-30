#include <cstdio>

struct node {

	int dy;
	int dx;
	int kh;
};

int store [10000][1001] = {0};
node* a = NULL;

int n, t, count = 0;

void init() {

	a = new node [count];
	int d = 0;
	for(int i = 0; i < n; ++i) {

		for(int j = 1; j <= store[i][0]; ++j) {

			for(int z = j + 1; z <= store[i][0]; ++z) {

				a[d].dx = store[i][j];
				a[d].dy = store[i][z];
				a[d].kh = i;
				++d;

				a[d].dx = store[i][z];
				a[d].dy = store[i][j];
				a[d].kh = i;
				++d;
			}
		}
	}
}

void quickSort(int l, int r) {

	node key = a[(l + r)>>1];

	int i = l, j = r;
    
	while(i <= j) {

		for(; (a[i].dx > key.dx) ||  (a[i].dx == key.dx && a[i].dy > key.dy) || (a[i].dx == key.dx && a[i].dy == key.dy && a[i].kh > key.kh); ++i);
		for(; (a[j].dx < key.dx) ||  (a[j].dx == key.dx && a[j].dy < key.dy) || (a[j].dx == key.dx && a[j].dy == key.dy && a[j].kh < key.kh); --j);

		if(i <= j) {

			if (i < j) {

				a[i].dx ^= a[j].dx ^= a[i].dx ^= a[j].dx;
				a[i].dy ^= a[j].dy ^= a[i].dy ^= a[j].dy;
				a[i].kh ^= a[j].kh ^= a[i].kh ^= a[j].kh;
			}

			++i;
			--j;
		}
	}

	if (l < j) quickSort(l, j);
	if (i < r) quickSort(i, r);
}

long long solved() {

	long long re = 0;

	int x = -1, y = -1, d = 0;
	for(int i = 0, kh = -1; i < count; kh = a[i].kh, ++i) {

		if(a[i].dx != x || a[i].dy != y) {

			if(d >= t) {

				++re;
			}

			d = 1;
			x = a[i].dx;
			y = a[i].dy;
		}
		else if(kh != a[i].kh) {

			++d;
		}
	}

	if(d >= t) {

		++re;
	}

	return re >> 1;
}

void input() {

	scanf("%d %d", &n, &t);
	for(int i = 0; i < n; ++i) {

		scanf("%d", &store[i][0]);
		count += (store[i][0] - 1)*store[i][0];

		for(int j = 1; j <= store[i][0]; ++j) {

			scanf("%d", &store[i][j]);
		}
	}
}

int main() {

	input();
	init();
	quickSort(0, count-1);

	printf("%lld", solved());
}