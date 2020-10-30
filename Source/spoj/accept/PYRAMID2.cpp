#include <cstdio>
#include <cstring>

int n;
char s[2000000] = {'\0'};

int solved() {

	int k = 0;

	bool check = true;

	int f1 = 0;
	int f2 = 0;

	int r1 = 0;
	int r2 = 0;

	int l1 = 0;
	int l2 = 0;

	for(int i = 0; i < n; f1 = f2 = 0) {

		//get '>'
		for(; i < n && s[i] == '>'; ++f1, ++i);

		//get '<'
		for(; i < n && s[i] == '<'; ++f2, ++i);

		if(f1 != 0 && f2 != 0) {

			l1 = f1;
			l2 = f2;

			k = ((r2+k) > f1)? (r2+k)-f1 : 0;
			r1 += f1;
			r2 = f2;
		}
	}

	int re = k + r1 + l2 - 1;

	return (re > 0)? re : 0;
}

int main() {

	scanf("%d\n", &n);
	scanf("%s", s);

	printf("%d", solved());
}