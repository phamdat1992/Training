#include <cstdio>
#include <cstring>

char s[1000003] = {'\0'};
int re[1000003] = {0};

int len = 0;

int min(int a, int b) {

	return (a < b)? a : b;
}

int ignoreEqual(int q, int r) {

	int k = 0;

	for(; r + k < len && s[q + k] == s[r + k]; ++k);
	return k;
}

int doNext(int q, int r) {

	for(; r < len && s[r] > s[q]; ++r);

	if(r == len) {

		re[++re[0]] = len - q;
		return len;
	}
	else {

		if(s[r] < s[q]) {

			re[++re[0]] = r - q;
			return r;
		}
		else if(s[r] == s[q]) {

			int t = ignoreEqual(q, r);

			if(s[r+t] < s[q+t]) {

				re[++re[0]] = r-q;
				return r;
			}
			else {

				return doNext(q, r+t);
			}
		}
	}
}

int getNextWord(int q) {

	int r = q + 1;
	int t = ignoreEqual(q, r);

	if(s[r+t] < s[q+t]) {

		re[++re[0]] = r-q;
		return r;
	}
	else {

		return doNext(q, r+t);
	}
}

int solved() {

	for(int q = 0; q != len; q = getNextWord(q));
	return re[0];
}

void input() {

	scanf("%s", s);
	len = strlen(s);
}

void tolower() {

	for(int i = 0; i < len; ++i) {

		if(s[i] < 'a') {

			s[i] += 32;
		}
	}
}

int main() {

	input();
	tolower();

	printf("%d ", solved());

	for(int i = 1; i <= re[0]; ++i) {

		printf("%d ", re[i]);
	}
}