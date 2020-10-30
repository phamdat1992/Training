#include <cstdio>
#include <algorithm>
#include <cmath>
#include <functional>

using namespace std;

int n, m, k;
long long a[1001][1001];
long long s[1001][1001];

void input() {
	scanf("%d%d%d", &n, &m, &k);
	for (int i = 1; i <= n; ++i) {
		for (int j = 1; j <= m; ++j) {
			scanf("%lld", &a[i][j]);
		}
	}
}

void init() {
	for (int i = 1; i <= n; ++i) {
		for (int j = 1; j <= m; ++j) {
			s[i][j] = s[i - 1][j] + s[i][j - 1] - s[i - 1][j - 1] + a[i][j];
		}
	}
}

long long vCot(int c1, int c2, int d1, int d2) {
	long long res = 1000000000000ll;
	int l = c1;
	int r = c2;

	do {

		int mid = (l + r) >> 1;
		
		long long areaL = s[d2][mid-1] - s[d2][c1-1] - (s[d1-1][mid-1] - s[d1-1][c1-1]);
		long long areaR = s[d2][c2] - s[d2][mid-1] - (s[d1 - 1][c2] - s[d1 - 1][mid-1]);

		res = min(res, abs(areaL - areaR));
		if (l == r) {
			break;
		}
		else if (areaL > areaR) {
			r = mid-1;
		}
		else {
			l = mid+1;
		}
	} while (l <= r);

	return res;
}

long long vDong(int c1, int c2, int d1, int d2) {
	long long res = 1000000000000ll;
	int l = d1;
	int r = d2;

	do {

		int mid = (l + r) >> 1;

		long long areaL = s[mid-1][c2] - s[mid-1][c1-1] - (s[d1 - 1][c2] - s[d1 - 1][c1-1]);
		long long areaR = s[d2][c2] - s[d2][c1-1] - (s[mid - 1][c2] - s[mid - 1][c1 - 1]);

		res = min(res, abs(areaL - areaR));
		if (l == r) {
			break;
		}
		else if (areaL > areaR) {
			r = mid-1;
		}
		else {
			l = mid+1;
		}
	} while (l <= r);

	return res;
}

int main() {
	input();
	init();
	
	int d1, c1, d2, c2;
	for (int i = 0; i < k; ++i) {
		scanf("%d%d%d%d", &d1, &c1, &d2, &c2);
		printf("%lld\n", min(vCot(c1, c2, d1, d2), vDong(c1, c2, d1, d2)));
	}
}