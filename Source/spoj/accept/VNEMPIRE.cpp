#include <cstdio>

struct ac {
	
	int cost;
	int edgA;
	int edgB;
};

ac heap[1000000];
int a [100001][4];
int f [100001] = {0};
int n;

void upHeap(int cost, int edgA, int edgB) {
	
	++heap[0].cost;
	
	heap[heap[0].cost].cost = cost;
	heap[heap[0].cost].edgA = edgA;
	heap[heap[0].cost].edgB = edgB;
	
	int i = heap[0].cost;
	int j = i >> 1;
	
	while(j && heap[j].cost > heap[i].cost) {
		
		heap[j].cost ^= heap[i].cost ^= heap[j].cost ^= heap[i].cost;
		heap[j].edgA ^= heap[i].edgA ^= heap[j].edgA ^= heap[i].edgA;
		heap[j].edgB ^= heap[i].edgB ^= heap[j].edgB ^= heap[i].edgB;
		
		i = j;
		j = i >> 1;
	}
}

void popHeap() {

	ac v = heap[heap[0].cost--];
	int r = 1, c;

	while((r << 1) <= heap[0].cost) {

		c = r << 1;

		if(c < heap[0].cost && heap[c+1].cost < heap[c].cost) { ++c; }
		if(heap[c].cost >= v.cost) { break; }

		heap[r].cost = heap[c].cost;
		heap[r].edgA = heap[c].edgA;
		heap[r].edgB = heap[c].edgB;
		
		r = c;
	}

	heap[r].cost = v.cost;
	heap[r].edgA = v.edgA;
	heap[r].edgB = v.edgB;
}

void quickSort(int q, int l, int r) {

	int key = a[(l + r)>>1][q];

	int i = l, j = r;
    
	while(i <= j) {

		for(; a[i][q] < key; ++i);
		for(; a[j][q] > key; --j);

		if(i <= j) {

			if (i < j) {

				a[i][0] ^= a[j][0] ^= a[i][0] ^= a[j][0];
				a[i][1] ^= a[j][1] ^= a[i][1] ^= a[j][1];
				a[i][2] ^= a[j][2] ^= a[i][2] ^= a[j][2];
				a[i][3] ^= a[j][3] ^= a[i][3] ^= a[j][3];
			}

			++i;
			--j;
		}
	}

	if (l < j) quickSort(q, l, j);
	if (i < r) quickSort(q, i, r);
}



void input() {
	
	scanf("%d", &n);
	for(int i = 0; i < n; ++i) {
		
		scanf("%d", &a[i][1]);
		scanf("%d", &a[i][2]);
		scanf("%d", &a[i][3]);
		
		a[i][0] = i;
	}
}

int abs(int a) {
	
	return (a > 0)? a : -a;
}

void buildSet(int q, int l, int r) {
	
	for(int i = l; i <= r; ++i) {
		
		for(int j = i + 1; j <= r; ++j) {
			
			if(a[i][0] != a[j][0]) {
			
				upHeap(abs(a[i][q] - a[j][q]), a[i][0], a[j][0]);
			}
		}
	}
}

void buildHeap(int q) {
	
	int l1 = 0;
	int r1 = 0;
	int l2 = 0;
	int r2 = 0;
	
	int value = 2000000000;
	for(int i = 0; i < n; ++i) {
		
		if(a[i][q] != value) {
			
			buildSet(q, l1, r2);
			
			l1 = l2;
			r1 = r2;
			
			l2 = i;
			r2 = i;
			
			value = a[i][q];
		}
		else {
			
			r2 = i;
		}
	}
	
	buildSet(q, l1, r2);
}

int getFlag(int x) {
	
	if(x != f[x]) {
		
		f[x] = getFlag(f[x]);
	}
	
	return f[x];
}

void updateFlag(int x, int i) {
	
	if(x != f[x]) {
		
		updateFlag(f[x], i);
	}
	
	f[x] = i;
}

void init() {
	
	for(int i = 0; i <= n; ++i) {
		
		f[i] = i;
	}
}

int min(int a, int b) {
	
	return (a < b)? a : b;
}

long long solved() {
	
	quickSort(1, 0, n-1);
	buildHeap(1);
	
	quickSort(2, 0, n-1);
	buildHeap(2);
	
	quickSort(3, 0, n-1);
	buildHeap(3);
	
	long long res = 0;
	for(int count = 0; count < n-1; popHeap()) {
		
		int ed1 = getFlag(heap[1].edgA);
		int ed2 = getFlag(heap[1].edgB);
		int cost = heap[1].cost;
	
		if(ed1 != ed2) {
			
			int fmin = min(ed1, ed2);
			updateFlag(ed1, fmin);
			updateFlag(ed2, fmin);
			
			++count;
			res += (long long)cost;
		}
	}
	
	return res;
}

int main() {
	
	input();
	init();
	
	printf("%lld", solved());
}
