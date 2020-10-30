#include <cstdio>
#include <iostream>
#include <map>
#include <algorithm>
#include <functional>;

using namespace std;

int k[1000001];
map <int, int> m;

int main() {

	int op, id, p;
	map<int, int>::iterator it;
	map<int, int>::reverse_iterator rit;
	do {
		scanf("%d", &op);
		switch (op) {
		case 0:
			return 0;
		case 1:
			scanf("%d%d", &id, &p);
			m[p] = id;
			++k[id];
			break;
		case 2:
			rit = m.rbegin();
			if (rit == m.rend() || k[(*rit).second] == 0) {
				printf("0\n");
			}
			else {
				--k[(*rit).second];
				printf("%d\n", (*rit).second);
				m.erase(m.find((*rit).first));
			}
			break;
		case 3:
			it = m.begin();
			if (it == m.end() || k[(*it).second] == 0) {
				printf("0\n");
			}
			else {
				--k[(*it).second];
				printf("%d\n", (*it).second);
				m.erase(it);
			}
			break;
		};
	} while (1);
}