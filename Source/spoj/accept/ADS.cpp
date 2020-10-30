#include <cstdio>

int a [3000] = {0};
int n, m;

int get(int x) {

	if(x != a[x]) {

		a[x] = get(a[x]);
	}

	return a[x];
}

void update(int x, int v) {

	if(x != a[x]) {

		update(a[x], v);
	}

	a[x] = v;
}

void init() {

	for(int i = 0; i <= n; ++i) {

		a[i] = i;
	}
}

int MIN(int a, int b) {

	return (a < b)? a : b;
}

int solved() {

	int u, v, f;
	int re = 0;

	for(int i = 0; i < m; ++i) {

		scanf("%d %d", &u, &v);

		f = MIN(get(u), get(v));
		update(u, f);
		update(v, f);
	}

	for(int i = 1; i <= n; ++i) {

		if(i == get(i)) {

			++re;
		}
	}

	return m - n + re;
}

int main() {

	scanf("%d %d", &n, &m);
	init();
	printf("%d", solved());
}