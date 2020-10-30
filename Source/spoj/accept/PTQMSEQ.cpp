#include <iostream>
#include <cstdio>
#include <algorithm>

using namespace std;

long long a[1094783];
long long fmax[1094783];
long long fsum[1094783];
int n;

void input() {
	scanf("%d", &n);
	for (int i = 0; i < n; ++i) {
		scanf("%lld", &a[i]);
	}
}

long long solved() {
	long long res = -1000000000ll;
	bool check = true;
	for (int i = 0; i < n; ++i) {
		if (a[i] <= 0) {
			check = false;
		}
		res = max(res, a[i]);
	}

	if (check == true) {
		res = 0;
		long long fmin = 1000000000;
		for (int i = 0; i < n; ++i) {
			fmin = min(fmin, a[i]);
			res += a[i];
		}

		return res - fmin;
	}

	if (res > 0) {
		long long ss = 0;
		for (int i = 0; i < n; ++i) {
			ss += a[i];
			if (ss < 0) {
				ss = 0;
			} else if (ss > res) {
				res = ss;
			}
		}
	}
	
	long long smax = 0;
	long long ssum = 0;
	for (int i = 0; i < n; ++i) {
		ssum += a[i];
		smax = max(smax, ssum);
		::fmax[i] = smax;
	}

	ssum = 0;
	for (int i = n - 1; i >= 0; --i) {
		ssum += a[i];
		::fsum[i] = ssum;
	}

	for (int i = 0; i < n; ++i) {
		if (i > 0) {
			long long tmp = ::fsum[i] + ::fmax[i - 1];
			if (tmp > res) {
				res = tmp;
			}
		}
		else if (::fsum[i] > res) {
			res = ::fsum[i];
		}
	}

	return res;
}

int main() {
	input();
	cout << solved();
}