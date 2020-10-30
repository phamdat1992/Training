#include <cstdio>
#include <cstring>

char s [100] = {'\0'};
char t [100] = {'\0'};
char r [100] = {'\0'};
char f [100] = {'\0'};

void solved() {

	scanf("%s\n%s\n\n", s, t);

	int len = strlen(s);

	char min = NULL;
	char max = NULL;

	int cm1, cm2;

	for(int i = 0; i < len; ++i) {

		min = (s[i] < t[i])? s[i] : t[i];
		max = (s[i] > t[i])? s[i] : t[i];

		cm1 = max - min;
		cm2 = min - 'a' + 'z' - max;

		if(cm1 < cm2) {

			r[i] = min;
		}
		else {

			r[i] = 'a';
		}
	}

	r[len] = '\0';
	printf("%s\n", r);
}

int main() {

	do {

		scanf("%s\n", f);
		
		if(strcmp(f, "[END]") == 0) {
		
			break;
		}
		else {
		
			solved();
		}
	}
	while(strcmp(f, "[CASE]") == 0);
}