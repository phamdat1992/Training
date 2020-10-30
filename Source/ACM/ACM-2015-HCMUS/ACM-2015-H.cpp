#include <cstdio>

int a [6][3] = {{0, 1, 2}, 
		{1, 0, 2},
		{1, 2, 0},
		{2, 1, 0},
		{2, 0, 1},
		{0, 2, 1}};

int b [3] = {0};
int n, k;

int tinh(int &x, int a, int b, int q) {

	switch(q) {

		case 0: x = a + b;
			return true;

		case 1: x = a - b;
			return true;

		case 2: x = a*b;
			return true;

		case 3: if(b == 0 || a%b != 0) {

				return false;
			}
			else {

				x = a/b;
				return true;
			}
	};
}



bool dequi(int i) {

	int x;

	for(int q1 = 0; q1 < 4; ++q1) {

		for(int q2 = 0; q2 < 4; ++q2) {

			if( tinh(x, b[a[i][0]], b[a[i][1]], q1) == true ) {

				if( tinh(x, x, b[a[i][2]], q2) == true ) {

					if( x == k ) {

						return true;
					}
				}
			}

			if( tinh(x, b[a[i][1]], b[a[i][2]], q2) == true ) {

				if( tinh(x, b[a[i][0]], x, q1) == true ) {

					if( x == k ) {

						return true;
					}
				}
			}
		}

	}

	return false;
}

bool solved() {

	for(int i = 0; i < 6; ++i) {

		if(dequi(i) == true) {

			return true;
		}
	}

	return false;
}

int main() {

	scanf("%d", &n);

	for(int i = 0; i < n; ++i) {

		scanf("%d %d %d", &b[0], &b[1], &b[2]);
		scanf("%d", &k);

		if(solved() == true) {

			printf("Possible\n");
		}
		else {

			printf("Impossible\n");
		}
	}
}