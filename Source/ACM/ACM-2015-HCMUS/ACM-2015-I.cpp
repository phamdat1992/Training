#include <cstdio>

int table [9] = {0};
int fill [10001] = {0};
int query [9] = {0};

int compute [9][10001] = {0};
int checkBit [10] = {0, 1, 3, 7, 15, 31, 63, 127, 255, 0};
int flag [256] = {0};

int n, m, k, r, t, q;

void init() {

	for(int i = 0; i < m; ++i) {

		for(int j = 1; j <= n; ++j ) {

			compute[j][i] = 0;
			if(i > 0) {

				compute[j][i] = compute[j][i-1];
			}

			if(compute[j][i] >= r) {

				compute[j][i] -= r;
			}
			else {

				compute[j][i] = 0;
			}
		}
		
		if(fill[i] != 0) {

			compute[fill[i]][i] = table[fill[i]];
		}
	}
}

void reset() {

	for(int i = 1; i < 256; ++i) {

		flag[i] = m;
	}

	flag[0] = 0;
}

bool solved() {

	int l = (1 << (n)) - 1;
	int tmp;

	for(int i = 0; i < m-k; ++i ) {

		for(int j = 1; j <= n; ++j) {

			if(compute[j][i] >= query[j]) {

				for(int z = 0; z <= l; ++z) {

					if(( (z >> (j-1)) & 1 ) == 0) {

						tmp = z|(1 << (j-1));
						if(flag[z] <= i && flag[tmp] > i) {

							flag[tmp] = (flag[tmp] < i+k)? flag[tmp] : i+k;

							if(tmp == checkBit[n]) {

								return true;
							}
						}
					}
				}
			}
		}
	}

	return false;
}

int main() {

	scanf("%d", &t);

	for(int i = 0; i < t; ++i) {

		scanf("%d %d %d %d", &n, &m, &k, &r);

		for(int j = 1; j <= n; ++j) {

			scanf("%d", &table[j]);
		} 

		for(int j = 0; j < m; ++j) {

			scanf("%d", &fill[j]);
		}

		init();
		scanf("%d", &q);

		for(int z = 0; z < q; ++z) {

			reset();

			for(int j = 1; j <= n; ++j) {

				scanf("%d", &query[j]);
			}

			if(solved() == true) {

				printf("Yes\n");
			}
			else {

				printf("No\n");
			}
		}
	}
}