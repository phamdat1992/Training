#include <iostream>
#include <cstdio>
#include <algorithm>
#include <map>
#include <string>

using namespace std;

int a[2000][2000];
int r, c, s, t, b, l, h,value;

void updateColumn(int y, int value) {
	int i = c;
	while (i <= s) {
		a[y][i] += value;
		i += (i&-i);
	}
}

void updateRow(int value) {
	int i = r;
	while(i <= s) {
		updateColumn(i, value);
		i += (i&-i);
	}
}

int getColumn(int x, int y) {
	int i = y;
	int res = 0;
	while (i > 0) {
		res += a[x][i];
		i &= (i - 1);
	}

	return res;
}

int getRow(int x, int y) {
	int res = 0;
	int i = x;
	while (i > 0) {
		res += getColumn(i, y);
		i &= (i - 1);
	}

	return res;
}

int main() {
	int option = 0;
	do {
		scanf("%d", &option);
		switch (option) {
		case 0:	
			scanf("%d", &s);
			break;
		case 1:
			scanf("%d%d%d", &r, &c, &value);
			++r;
			++c;
			updateRow(value);
			break;
		case 2:
			scanf("%d%d%d%d", &l, &b, &h, &t);
			++l;
			++b;
			++h;
			++t;
			int res = getRow(h, t) - getRow(h, b-1) - getRow(l-1, t) + getRow(l-1, b - 1);
			cout << res << endl;
			break;
		};
	} while (option != 3);

}