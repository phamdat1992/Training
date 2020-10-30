#include <iostream>
#include <cstdio>
#include <algorithm>
#include <functional>
#include <cmath>

using namespace std;

int cc[100001];
int id[100001];
int b[100001];
int a[100001];
bool visit[100001];
bool ffree[100001];
int m[100001];
int n;
int ff = 0;

void input() {

	scanf("%d", &n);
	for (int i = 1; i <= n; ++i) {
		scanf("%d", &a[i]);
	}
}

void solved(int u) {

	m[u] = ++ff;
	visit[u] = true;
	int v = a[u];

	if (visit[v] == true) {
		if (ffree[v] == false) {
			id[u] = v;
			++cc[id[u]];
			m[u] = m[v];
		}
		else {
			id[u] = u;
			cc[id[u]] = cc[id[v]] + 1;
		}
	}
	else {
		solved(v);
		if (m[u] >= m[v]) {
			m[u] = m[v];
			id[u] = id[v];
		}
		else {
			id[u] = u;
		}

		cc[id[u]] = cc[id[v]] + 1;
	}

	ffree[u] = true;
}

int main() {

	input();
	for (int i = 1; i <= n; ++i) {
		if (visit[i] == false) {
			solved(i);
		}
	}

	for (int i = 1; i <= n; ++i) {
		printf("%d\n", cc[id[i]]);
	}
}