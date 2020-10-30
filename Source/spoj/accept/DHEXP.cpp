#include <cstdio>
#include <iostream>
#include <algorithm>
#include <cmath>
#include <functional>  

using namespace std;

long long a[200000];
int n, k;

void input() {

	scanf("%d%d", &n, &k);
	for (int i = 0; i < n; ++i) {
		scanf("%lld", &a[i]);
	}
}

long long solved() {

	long long res = a[0];
	sort(a + 1, a + n, greater<long long>());
	
	for (int i = 1; i < n; ++i) {
		if (i <= k) {
			res += a[i];
		}
		else {
			res -= a[i];
		}
	}

	return res;
}

int main() {
	input();
	cout << solved();
}