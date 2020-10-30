#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

char s[16];
char r[16];
int n;

int main() {
	scanf("%d", &n);
	scanf("%s", r);

	for (int i = 1; i < n; ++i) {
		scanf("%s", s);
		for (int j = 0; j <= strlen(s); ++j) {
			r[j] ^= s[j];
		}
	}

	printf("%s", r);
}