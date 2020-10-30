#include <cstdio>

int a [100000] = {0};

int n, m;

void input() {

	scanf("%d %d", &m, &n);
	for(int i = 0, x; i < n; ++i) {

		scanf("%d", &a[i]);
	}
}

bool countQ(int x) {

	int r = n, w;

	for(int i = 0; i < n; ++i) {

		if(a[i] > x) {

			w = a[i] / x + ((a[i] % x) != 0);
			if(r + w - 1 > m) {

				return false;
			}
			else {

				r += w-1;
			}
		}
	}

	return true;
}

int getMax() {

	int max = 0;
	for(int i = 0; i < n; ++i) {

		if(max < a[i]) {

			max = a[i];
		}
	}

	return max;
}

int solved() {

	int l = 1, r = 1000000000, mid;

	do {

		mid = (l+r) >> 1;
		if(countQ(mid) == true) {

			r = mid;
		}
		else {

			l = mid+1;
		}
	}
	while(l != r);

	return r;
}

int main() {

	input();
	printf("%d", solved());
}