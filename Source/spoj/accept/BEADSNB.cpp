#include <cstdio>
#include <algorithm>
#include <cmath>
#include <functional>
#include <map>
#include <iostream>

using namespace std;

map <int, int, greater<int> > gmax;
map <int, int> gmin;
int n;
int a[100001];

void input() {
	scanf("%d", &n);
	for (int i = 0; i < n; ++i) {
		scanf("%d", &a[i]);
	}
}

int solved() {
	int res = 0;
	map <int, int, greater<int> >::iterator it;
	map <int, int>::iterator ot;
	for (int i = n - 1; i >= 0; --i) {
		it = ::gmax.find(a[i]);
		if (it == ::gmax.end()) {
			::gmax[a[i]] = 1;
			it = ::gmax.find(a[i]);
		}
		if (it != ::gmax.begin()) {
			--it;
			::gmax[a[i]] = max(::gmax[a[i]], (*it).second + 1);

			++it;
		}
		++it;
		for (; it != ::gmax.end(); ) {
			if ((*it).second <= ::gmax[a[i]]) {
				::gmax.erase(it++);
			}
			else {
				break;
			}
		}

		ot = ::gmin.find(a[i]);
		if (ot == ::gmin.end()) {
			::gmin[a[i]] = 1;
			ot = ::gmin.find(a[i]);
		}
		if (ot != ::gmin.begin()) {
			--ot;
			::gmin[a[i]] = max(::gmin[a[i]], (*ot).second + 1);

			++ot;
		}
		++ot;
		for (; ot != ::gmin.end();) {
			if ((*ot).second <= ::gmin[a[i]]) {
				::gmin.erase(ot++);
			}
			else {
				break;
			}
		}

		res			= max(res, ::gmax[a[i]] + ::gmin[a[i]]);
	}

	return res;
}

int main() {
	input();
	cout << solved()-1;
}