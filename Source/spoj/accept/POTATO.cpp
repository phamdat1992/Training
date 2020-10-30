#include <iostream>
#include <cstdio>
#include <string>

using namespace std;

int main() {
	string s = "";
	int n = 0;

	do {
		cin >> s;
		if (s.compare("[CASE]") == 0) {
			cin >> n;
			int tmp = (n % 5 == 0) ? 5 : n % 5;
			if (tmp == 2 || tmp == 5) {
				cout << "Hanako"<<endl;
			}
			else {
				cout << "Taro"<<endl;
			}
		}
		else {
			break;
		}
	} while (1);

	return 0;
}