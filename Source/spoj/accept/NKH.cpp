#include <iostream>
#include <cstdio>
#include <string>

using namespace std;

string p1, p2, pm;

void solved() {

	int ls1 = 0;
	int ls2 = 0;
	for (int i = 0; i < pm.length();) {
		int f1 = ls1;
		int f2 = ls2;

		if (p1[f1] == p2[f2]) {
			for (; p1[f1] == pm[i]; ++f1);
			for (; p2[f2] == pm[i]; ++f2);

			int count = 0;
			for (;pm[i] == pm[i + count]; ++count);
			if (pm[i + count] == p1[f1]) {
				for (int j = 0; j < (f1-ls1); ++j) {
					cout << 1;
				}
				for (int j = 0; j < count - (f1-ls1); ++j) {
					cout << 2;
				}

				ls2 += count - (f1 - ls1);
				ls1 = f1+1;

				if (f1 < p1.length()) {
					cout << 1;
				}
			}
			else {
				for (int j = 0; j < count - (f2-ls2); ++j) {
					cout << 1;
				}
				for (int j = 0; j < (f2-ls2); ++j) {
					cout << 2;
				}

				if (f2 < p2.length()) {
					cout << 2;
				}

				ls1 += count - (f2-ls2);
				ls2 = f2+1;
			}

			i += count+1;
		}
		else {
			if (p1[f1] == pm[i]) {
				cout << 1;
				ls1 += 1;
			} else {
				cout << 2;
				ls2 += 1;
			}

			++i;
		}
	}
}

int main() {
	cin >> p1 >> p2 >> pm;
	solved();
}