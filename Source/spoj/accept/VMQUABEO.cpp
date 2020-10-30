#include <functional>
#include <iostream>
#include <cstdio>
#include <set>

using namespace std;

int a[1000001];
int his[10001];
int n, l, d;

set <int, less<int> > giam;
set <int, greater<int> > tang;

void input() {
	scanf("%d %d %d", &n, &l, &d);
	for (int i = 0; i < n; ++i) {
		scanf("%d", &a[i]);
	}
}

long long solved() {
	long long res = 0ll;
	int fl = 0;
	for (int i = 0; i < n; ++i) {
		++his[a[i]];
		giam.insert(a[i]);
		tang.insert(a[i]);

		while (his[*giam.begin()] == 0) {
			giam.erase(giam.begin());
		}
		int fmin = *giam.begin();

		while (his[*tang.begin()] == 0) {
			tang.erase(tang.begin());
		}
		int fmax = *tang.begin();

		for (; fmax - fmin > d; ++fl) {
			
			if (his[a[fl]] > 0) {
				--his[a[fl]];
			}

			while (his[*giam.begin()] == 0) {
				giam.erase(giam.begin());
			}

			while (his[*tang.begin()] == 0) {
				tang.erase(tang.begin());
			}

			fmin = *giam.begin();
			fmax = *tang.begin();
		}

		if (i - fl + 1 >= l+1) {
			res += i - fl + 2 - (l+1);
		}
	}

	return res;
}

int main() {
	input();
	cout << solved();
}