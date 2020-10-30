#include <iostream>
#include <cstdio>

using namespace std;

int main() {
	int a, b, c;
	do {
		if (scanf("%d", &a) == true &&
			scanf("%d", &b) == true &&
			scanf("%d", &c) == true) {
			if (b - a > c - b) {
				cout << b - a - 1<<endl;
			}
			else {
				cout << c - b - 1<<endl;
			}
		}
		else {
			break;

		}
	}			while (1);
}