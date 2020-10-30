#include <iostream>
#include <cstdio>
#include <cmath>
#include <algorithm>
#include <functional>
#include <cstring>

using namespace std;

struct trie {
	trie* pn[30];
	bool check;
};

trie root;
char s[100000];
int n;
int len = 0;
int res = 0;

void init(trie &x) {

	x.check = false;
	for (int i = 0; i < 30; ++i) {
		x.pn[i] = NULL;
	}
}

void add(int index, trie &x) {

	int offset = (int)(s[index] - 'a');

	if (x.pn[offset] == NULL) {
		x.pn[offset] = new trie;
		init(*x.pn[offset]);
	}

	if (index == len - 1) {
		(*x.pn[offset]).check = true;
	}
	else {
		add(index + 1, (*x.pn[offset]));
	}
}

void dfs(int f, trie &x) {

	if (x.check == true) {
		::res = max(::res, ++f);
	}

	for (int i = 0; i < 30; ++i) {
		if (x.pn[i] != NULL) {
			dfs(f, *x.pn[i]);
		}
	}
}

int main() {

	scanf("%d", &n);
	for (int i = 0; i < n; ++i) {
		scanf("%s", s);
		::len = strlen(s);
		add(0, ::root);
	}

	dfs(0, ::root);
	cout << ::res;
	return 0;
}