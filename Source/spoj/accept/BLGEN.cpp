#include <cstdio>
#include <iostream>
#include <algorithm>
#include <functional>
#include <sstream>
#include <cmath>
#include <string>

using namespace std;

int st[1001][1001];
long long a[1001];
long long b[1001];
string s;
int la = 0, lb = 0, id = 0;

bool isDou(long long x) {

	long long tm = round(pow((double)x, 1.0 / 2.0));
	return tm*tm == x;
}

bool isPrim(long long x) {
	long long tm = round(pow((double)x, 1.0 / 3.0));
	if (tm*tm*tm != x) {
		return false;
	}
	long long rm = round(pow((double)tm, 1.0 / 2.0));

	for (long long i = 2ll; i <= rm; ++i) {
		if (tm % i == 0ll) {
			return false;
		}
	}

	return true;
}

void input() {
	
	getline(cin, s);
	stringstream ss(s);
	long long x;
	while (ss >> x) {
		if (isDou(x) || isPrim(x)) {
			a[++la] = x;
		}
	}
	getline(cin, s);
	stringstream sss(s);
	while (sss >> x) {
		if (isDou(x) || isPrim(x)) {
			b[++lb] = x;
		}
	}
}

int solved() {
	int res = 0;
	for (int i = 1; i <= la; ++i) {
		for (int j = 1; j <= lb; ++j) {
			if (a[i] == b[j]) {
				st[i][j] = max(st[i][j], st[i - 1][j - 1] + 1);
			}

			st[i][j] = max(st[i][j], st[i][j - 1]);
			st[i][j] = max(st[i][j], st[i-1][j]);

			res = max(res, st[i][j]);
		}
	}

	return res;
}

int main() {
	input();
	cout << solved();

	return 0;
}