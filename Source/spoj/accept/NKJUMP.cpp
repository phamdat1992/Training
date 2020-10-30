#include <cstdio>
#include <algorithm>
#include <cmath>
#include <iostream>
#include <functional>
#include <map>

using namespace std;

int a[2000];
int b[2000];
bool f[2000];
map <int, int> st;
map <int, int>::iterator it;
int n, len = 0;

void input() {
	scanf("%d", &n);
	for (int i = 0, x; i < n; ++i) {
		scanf("%d", &x);
		if (st.find(x) == st.end()) {
			st[x] = 0;
		}
		else {
			++st[x];
		}
	}
}

void init() {
	len = 0;
	for (it = st.begin(); it != st.end(); ++it, ++len) {
		a[len] = (*it).first;
		if ((*it).second >= 1) {
			f[len] = true;
		}
		(*it).second = len;
	}
}

int solved() {
	int res = 0;

	for (int i = 0; i < len; ++i) {
		for (int j = 0; j < len; ++j) {
			if (i != j || f[i] == true) {
				it = st.find(a[i] + a[j]);
				if (it != st.end()) {
					b[(*it).second] = max(b[(*it).second], b[i] + 1);
					b[(*it).second] = max(b[(*it).second], b[j] + 1);
					res = max(b[(*it).second], res);
				}
			}
		}
	}

	return res;
}

int main() {
	input();
	init();
	cout << solved()+1;
}