#include <cstdio>
#include <cstring>

char s [200];
char g [200];
int k, n;

bool solved() {

	bool str [200] = {false};

	int count = 0;

	int len = strlen(s);
	for(int i = 0; i < len; ++i) {

		if(str[s[i]] == false) {

			str[s[i]] = true;
			++count;
		}
	}

	int error = 0;

	len = strlen(g);
	for(int i = 0; i < len; ++i) {

		if(str[g[i]] == true) {

			--count;
			str[g[i]] = false;

			if(count == 0) {

				return true;
			}
		}
		else {

			++error;
			if(error >= k) {

				return false;
			}
		}
	}

	return false;
}

int main() {

	scanf("%d", &n);

	for(int i = 0; i < n; ++i) {

		scanf("%d %s %s", &k, s, g);

		if(solved() == true) {

			printf("Correct\n");
		}
		else {

			printf("Wrong\n");
		}
	}
}