#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

char s[1000001];
char ss[100];
int len;
int lenss;
int his[1000001][52];
int q, n;

int getIndex(char x) {
	if (x >= 'a' && x <= 'z') {
		return (int)(x - 'a');
	} else {
		return (int)('z'- 'a'+1 + x - 'A');
	}
}

void init() {
	for (int i = 0; i < len; ++i) {
		++his[i][getIndex(s[i])];
	}

	for (int i = 1; i < len; ++i) {
		for (int j = 0; j < 52; ++j) {
			his[i][j] += his[i - 1][j];
		}
	}
}

void solved(int l, int r, int &count, bool &nearL, bool &nearR) {
	int sum = 0;
	if (l > 0) {
		for (int i = 0; i < lenss; ++i) {
			sum += his[r][getIndex(ss[i])] - his[l-1][getIndex(ss[i])];
		}
	} else {
		for (int i = 0; i < lenss; ++i) {
			sum += his[r][getIndex(ss[i])];
		}
	}

	if (l == r) {
		if (sum == 1) {
			count = 1;
			nearL = 1;
			nearR = 1;
		}
		else {
			count = 0;
			nearL = false;
			nearR = false;
		}
	}
	else if (sum == 0) {
		count = 0;
		nearL = false;
		nearR = false;
	}
	else if (sum == r - l + 1) {
		count = 1;
		nearL = true;
		nearR = true;
	}
	else {
		int countL = 0;
		bool nearL1 = 0;
		bool nearR1 = 0;

		int countR = 0;
		bool nearL2 = 0;
		bool nearR2 = 0;

		int mid = (l + r) >> 1;

		solved(l, mid, countL, nearL1, nearR1);
		solved(mid + 1, r, countR, nearL2, nearR2);

		nearL = nearL1;
		nearR = nearR2;
		if (nearR1 == true && nearL2 == true) {
			count = countL + countR - 1;
		}
		else {
			count = countL + countR;
		}
	}
}


int main() {
	scanf("%d", &len);
	scanf("%s", s);
	scanf("%d", &q);

	init();
	for (int i = 0; i < q; ++i) {
		scanf("%s", ss);
		lenss = strlen(ss);
		int count = 0;
		bool l = false, r = false;
		solved(0, len - 1, count, l, r);
		printf("%d\n", count);
	}
}