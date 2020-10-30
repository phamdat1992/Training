#include <iostream>
#include <cmath>
#include <algorithm>

using namespace std;

int n, t;

int nb(int a, int b) {

	int count = 0;

	while (a != b) {
		int f1 = max(a, b);
		int f2 = min(a, b);

		count += f1 / f2;
		if (f1%f2 == 0) {
			f1 = f2;
			count -= 1;
		}
		else {
			f1 %= f2;
		}

		a = f1;
		b = f2;
	}

	if (a != 1) {
		return -1;
	}
	else {
		return count;
	}
}

int solved() {
	int res = 1000000000;

	for (int i = 1; i <= n; ++i) {
		int tm = nb(i, n);
		if (tm > -1) {
			res = min(res, tm);
		}
	}

	return res;
}

int main() {
	cin >> t;
	for (int i = 0; i < t; ++i) {
		cin >> n;
		cout << solved() << endl;
	}
}