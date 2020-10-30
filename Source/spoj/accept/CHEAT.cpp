#include <cstdio>
#include <iostream>
#include <algorithm>
#include <stack>

using namespace std;

stack <int> rr;
bool a[100001];
int n, x;

int main() {
	scanf("%d", &n);
	int flag = 1;
	for (int i = 1; i <= n; ++i) {
		scanf("%d", &x);
		if (a[x] == true) {
			cout << "YES";
			return 0;
		} else {
			for (; flag <= x; ++flag) {
				rr.push(flag);
				a[flag] = true;
			}
		}

		rr.pop();
		if (!rr.empty()) {
			a[rr.top()] = false;
		}
	}

	cout << "NO";
}