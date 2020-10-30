#include <cstdio>
#include <cstring>

using namespace std;

int his[1000002];
long long a[1000002];
char s[1000002];

int main() {
	scanf("%s", s);
	int count = 0;

	int n = strlen(s);
	for (int i = 0; i <= n; ++i) {
		if (s[i] != '7') {
			if (count > 0) {
				++his[count];
				count = 0;
			}
		}
		else {
			++count;
		}
	}

	long long d = 0;
	long long ss = 0;
	for (int i = n; i >= 1; --i) {
		if (his[i] > 0) {
			ss += his[i];
			d += his[i];
		}

		a[i] = ss;
		ss += d;
	}

	for (int i = 1; i <= n; ++i) {
		if (a[i] > 0) {
			printf("%d %lld\n", i, a[i]);
		}
	}
}