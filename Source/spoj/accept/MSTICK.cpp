#include <cstdio>

struct ac {
	
	int dx;
	int dy;
};

ac a[10000];
int f [10000];
int d;
int n, t;

void input() {
	
	scanf("%d", &n);
	for(int i = 0; i < n; ++i) {
		
		scanf("%d %d", &a[i].dx, &a[i].dy);
	}
}

void quickSort(int l, int r) {

	ac key = a[(l + r)>>1];

	int i = l, j = r;

	while(i <= j) {

		for(; (a[i].dx < key.dx) || (a[i].dx == key.dx && a[i].dy < key.dy); ++i);
		for(; (a[j].dx > key.dx) || (a[j].dx == key.dx && a[j].dy > key.dy); --j);

		if(i <= j) {

			if (i < j) {

				a[i].dx ^= a[j].dx ^= a[i].dx ^= a[j].dx;
				a[i].dy ^= a[j].dy ^= a[i].dy ^= a[j].dy;
			}

			++i;
			--j;
		}
	}

	if (l < j) quickSort(l, j);
	if (i < r) quickSort(i, r);
}

int solved() {
	
	++d;
	int count = 0;
	int res = 0;
	
	while(count < n) {
		
		++res;
		int dx = -1000000000;
		int dy = -1000000000;
		
		for(int i = 0; i < n; ++i) {
			
			if(f[i] != d && dx <= a[i].dx && dy <= a[i].dy) {
				
				dx = a[i].dx;
				dy = a[i].dy;
				
				f[i] = d;
				++count;
			}
		}
	}
	
	return res;
}

int main() {
	
	scanf("%d", &t);
	for(int i = 0; i < t; ++i) {
		
		input();
		quickSort(0, n-1);
		
		printf("%d\n", solved());
	}
}
