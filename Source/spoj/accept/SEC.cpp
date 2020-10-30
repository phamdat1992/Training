#include <iostream>
#include <cstdio>
#include <algorithm>
#include <functional>
#include <cmath>
#include <cstring>
#include <stack>

using namespace std;

struct ac {
	ac* pn[2];
	bool check;
	long long f1; // ra ngoai
	long long f2; // trong luong
	stack <int> id;
};

ac root;
int index1[500001];
int index2[500001];
bool s1[1000000];
bool s2[1000000];
bool* s;
int n, m, len;
long long res[1000000];

void input() {
	scanf("%d%d", &n, &m);

	for (int i = 0, kd = 0; i < n; ++i) {
		scanf("%d", &index1[i]);
		for (int j = 0; j < index1[i]; ++j, ++kd) {
			scanf("%d", &s1[kd]);
		}
	}

	for (int i = 0, kd = 0; i < m; ++i) {
		scanf("%d", &index2[i]);
		for (int j = 0; j < index2[i]; ++j, ++kd) {
			scanf("%d", &s2[kd]);
		}
	}
}

void init(ac &x) {

	x.pn[0] = x.pn[1] = NULL;
	x.f2 = 0;
	x.f1 = 0;
	x.check = false;
}

void buildTree(int index, ac &x, int id) {

	int offset = (int)(s[index]);
	
	if (x.pn[offset] == NULL) {
		x.pn[offset] = new ac;
		init(*x.pn[offset]);
	}
	if (index == len - 1) {
		(*x.pn[offset]).check = true;
		(*x.pn[offset]).id.push(id);
	}
	else {
		buildTree(index + 1, (*x.pn[offset]), id);
	}
}

void add(int index, ac* x) {

	if (x != NULL) {

		int offset = (int)(s[index]);
		if (index == len - 1) {
			++x->f2;
		} else if (x->pn[s[index + 1]] == NULL) {
			++x->f1;
		} else {
			add(index + 1, x->pn[s[index + 1]]);
		}
	}
}

long long solved(ac &x, int ssum) {

	long long re = 0;
	for (int i = 0; i < 2; ++i) {
		if (x.pn[i] != NULL) {
			re += solved(*(x.pn[i]), ssum + x.f2);
		}
	}

	if (x.check == true) {
		while (!x.id.empty()) {
			res[x.id.top()] = x.f1 + x.f2 + re + ssum;
			x.id.pop();
		}
	}

	return x.f1 + x.f2 + re;
}

int main() {

	input();
	init(root);

	s = s2;
	for (int i = 0; i < m; ++i) {
		len = index2[i];
		buildTree(0, ::root, i);
		s = s + index2[i];
	}

	s = s1;
	for (int i = 0; i < n; ++i) {
		len = index1[i];
		add(0, root.pn[s[0]]);
		s = s + index1[i];
	}

	solved(::root, 0);
	for (int i = 0; i < m; ++i) {
		cout << res[i] << endl;
	}
}