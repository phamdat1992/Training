#include <cstdio>
#include <algorithm>
#include <cmath>
#include <functional>
#include <map>
#include <iostream>

using namespace std;

struct ac {
	int cos;
	int engin;
};

bool visit[201];
bool ffree[201];
int cc[20001];
int nl[20001];
int s[20001];
int m[20001];
int a[201];
int n, t, l, r, fm = 0;
ac rr[201];

void input() {
	scanf("%d", &l, &n, &r);
	
	m[0] = -1;
	s[0] = -1;
	for (int i = 1; i <= n; ++i) {
		a[i] = -1;
	}
	
	for (int i = 0, v1, v2; i < r; ++i) {
		++fm;
		scanf("%d%d%d%d", &v1, &v2, &cc[fm], &nl[fm]);
		s[fm] = v2;
		m[fm] = a[v1];
		a[v1] = fm;
	}
}

void dfs(int u) {
	
	if (u == n) {
		return;
	} else {
		rr[u].cos = 1000000000;
		rr[u].engin = 1000000000;
	}
	
	visit[u] = true;

	for (int pv = a[u]; s[pv] != -1; pv = m[pv]) {
		if (visit[s[pv]] == false) {
			dfs(s[pv]);
		}
		else if (ffree[s[pv]] == false) {
			continue;
		}
		
		if (cc[pv] + rr[s[pv]].cos < rr[u].cos && nl[pv] + rr[s[pv]].engin <= l) {
			rr[u].cos = cc[pv] + rr[s[pv]].cos;
			rr[u].engin = nl[pv] + rr[s[pv]].engin;
		} else if (cc[pv] + rr[s[pv]].cos == rr[u].cos && nl[pv] + rr[s[pv]].engin < rr[u].engin) {
			rr[u].engin = nl[pv] + rr[s[pv]].engin;
		}
	}
	
	ffree[u] = true;
}

int main() {
	scanf("%d", &t);
	for (int i = 0; i < t; ++i) {
		input();
		dfs(1);
		
		if (rr[1].engin <= l) {
			cout<<1<<endl;
		} else {
			cout<<rr[1].cos<<endl;
		}
	}
}