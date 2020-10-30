#include <cstdio>

int matrix [51][51] = {0};
int res [51][51][25][2] = {0};
int heap[200000][3] = {0};
int xucxac[200000][6] = {0};

int n, m;
int t1, t2;
int s1, s2;

inline void GET_INT( int &x ) {

	register int c;

	while( !( ( x = getchar_unlocked() ) >= '0' && x <= '9' ) );

	x -= '0';
	while( ( ( c = getchar_unlocked() ) >= '0' && c <= '9' ) ) {

		x = ( x<<3 ) + ( x<<1 ) + ( c - '0' );
	}
}

void upHeap(int v, int x, int y, int a[6]) {

	++heap[0][0];
	++xucxac[0][0];

	heap[heap[0][0]][0] = v;
	heap[heap[0][0]][1] = x;
	heap[heap[0][0]][2] = y;

	xucxac[xucxac[0][0]][0] = a[0];
	xucxac[xucxac[0][0]][1] = a[1];
	xucxac[xucxac[0][0]][2] = a[2];
	xucxac[xucxac[0][0]][3] = a[3];
	xucxac[xucxac[0][0]][4] = a[4];
	xucxac[xucxac[0][0]][5] = a[5];

	int i = heap[0][0];
	int j = i >> 1;

	while(j && heap[j][0] > heap[i][0]) {

		heap[j][0] ^= heap[i][0] ^= heap[j][0] ^= heap[i][0];
		heap[j][1] ^= heap[i][1] ^= heap[j][1] ^= heap[i][1];
		heap[j][2] ^= heap[i][2] ^= heap[j][2] ^= heap[i][2];

		xucxac[j][0] ^= xucxac[i][0] ^= xucxac[j][0] ^= xucxac[i][0];
		xucxac[j][1] ^= xucxac[i][1] ^= xucxac[j][1] ^= xucxac[i][1];
		xucxac[j][2] ^= xucxac[i][2] ^= xucxac[j][2] ^= xucxac[i][2];
		xucxac[j][3] ^= xucxac[i][3] ^= xucxac[j][3] ^= xucxac[i][3];
		xucxac[j][4] ^= xucxac[i][4] ^= xucxac[j][4] ^= xucxac[i][4];
		xucxac[j][5] ^= xucxac[i][5] ^= xucxac[j][5] ^= xucxac[i][5];

		i = j;
		j = i >> 1;
	}
}

void popHeap() {

	int a[6];
	int b[3];

	int r, c;

	r = 1;

	a[0] = xucxac[xucxac[0][0]][0];
	a[1] = xucxac[xucxac[0][0]][1];
	a[2] = xucxac[xucxac[0][0]][2];
	a[3] = xucxac[xucxac[0][0]][3];
	a[4] = xucxac[xucxac[0][0]][4];
	a[5] = xucxac[xucxac[0][0]][5];

	--xucxac[0][0];

	b[0] = heap[heap[0][0]][0];
	b[1] = heap[heap[0][0]][1];
	b[2] = heap[heap[0][0]][2];

	-- heap[0][0];

	while((r << 1) <= heap[0][0]) {

		c = r << 1;

		if(c < heap[0][0] && heap[c+1][0] < heap[c][0]) { ++c; }
		if(heap[c][0] >= b[0]) { break; }

		heap[r][0] = heap[c][0];
		heap[r][1] = heap[c][1];
		heap[r][2] = heap[c][2];

		xucxac[r][0] = xucxac[c][0];
		xucxac[r][1] = xucxac[c][1];
		xucxac[r][2] = xucxac[c][2];
		xucxac[r][3] = xucxac[c][3];
		xucxac[r][4] = xucxac[c][4];
		xucxac[r][5] = xucxac[c][5];

		r = c;
	}

	heap[r][0] = b[0];
	heap[r][1] = b[1];
	heap[r][2] = b[2];

	xucxac[r][0] = a[0];
	xucxac[r][1] = a[1];
	xucxac[r][2] = a[2];
	xucxac[r][3] = a[3];
	xucxac[r][4] = a[4];
	xucxac[r][5] = a[5];
}

void input() {

	GET_INT(n);
	GET_INT(m);

	for(int i = 1; i <= n; ++i) {

		for(int j = 1; j <= m ; ++j) {

			GET_INT(matrix[i][j]);
		}
	}

	GET_INT(t1);
	GET_INT(t2);

	GET_INT(s1);
	GET_INT(s2);
}

int getIndex(int x) {
	
	switch(x) {
		
	case 126543: return 0;
	case 146352: return 1;
	case 156234: return 2;
	case 136425: return 3;
	
	case 265143: return 4;
	case 245316: return 5;
	case 215634: return 6;
	case 235461: return 7;
	
	case 354261: return 8;
	case 364125: return 9;
	case 324516: return 10;
	case 314652: return 11;
	
	case 463152: return 12;
	case 453216: return 13;
	case 413625: return 14;
	case 423561: return 15;
	
	case 562134: return 16;
	case 532416: return 17;
	case 512643: return 18;
	case 542361: return 19;
	
	case 621534: return 20;
	case 631452: return 21;
	case 651243: return 22;
	case 641325: return 23;

	default: return 0;	
	};
}

int toInt(int* a) {
	
	int t = 0;
	t += a[0]*100000;
	t += a[1]*10000;
	t += a[2]*1000;
	t += a[3]*100;
	t += a[4]*10;
	t += a[5]*1;
	
	return t;
}

void solved() {

	int a[6] = {5, 1, 2, 6, 4, 3};

	res[t1][t2][getIndex(toInt(a))][1] = 5*matrix[t1][t2];
	res[t1][t2][getIndex(toInt(a))][0] = 1;
	upHeap(5*matrix[t1][t2], t1, t2, a);

	for(; heap[0][0] != 0; popHeap()) {

		int x = heap[1][1];
		int y = heap[1][2];
		int index = getIndex(toInt(xucxac[1]));
		
		if(res[x][y][index][1] == heap[1][0]) {
			
			if(x > 1) {
				
				a[0] = xucxac[1][3];
				a[1] = xucxac[1][0];
				a[2] = xucxac[1][1];
				a[3] = xucxac[1][2];
				a[4] = xucxac[1][4];
				a[5] = xucxac[1][5];
				
				index = getIndex(toInt(a));
				int tmp = xucxac[1][3]*matrix[x-1][y] + heap[1][0];
				if(res[x-1][y][index][0] == 0 || res[x-1][y][index][1] > tmp ) {
	
					res[x-1][y][index][0] = 1;
					res[x-1][y][index][1] = tmp;
					upHeap(tmp, x-1, y, a);
				}
			}
	
			if(x < n) {
	
				a[0] = xucxac[1][1];
				a[1] = xucxac[1][2];
				a[2] = xucxac[1][3];
				a[3] = xucxac[1][0];
				a[4] = xucxac[1][4];
				a[5] = xucxac[1][5];

				index = getIndex(toInt(a));
				int tmp = xucxac[1][1]*matrix[x+1][y] + heap[1][0];
				if(res[x+1][y][index][0] == 0 || res[x+1][y][index][1] > tmp) {
	
					res[x+1][y][index][0] = 1;
					res[x+1][y][index][1] = tmp;
					upHeap(tmp, x+1, y, a);
				}
			}
	
			if(y > 1) {
	
				a[0] = xucxac[1][4];
				a[1] = xucxac[1][1];
				a[2] = xucxac[1][5];
				a[3] = xucxac[1][3];
				a[4] = xucxac[1][2];
				a[5] = xucxac[1][0];
	
				index = getIndex(toInt(a));
				int tmp = xucxac[1][4]*matrix[x][y-1] + heap[1][0];
				if( res[x][y-1][index][0] == 0 || res[x][y-1][index][1] > tmp) {
	
					res[x][y-1][index][0] = 1;
					res[x][y-1][index][1] = tmp;
					upHeap(tmp, x, y-1, a);
				}
			}
	
			if(y < m) {
	
				a[0] = xucxac[1][5];
				a[1] = xucxac[1][1];
				a[2] = xucxac[1][4];
				a[3] = xucxac[1][3];
				a[4] = xucxac[1][0];
				a[5] = xucxac[1][2];
	
				index = getIndex(toInt(a));
				int tmp = xucxac[1][5]*matrix[x][y+1] + heap[1][0];
				if(res[x][y+1][index][0] == 0 || res[x][y+1][index][1] > tmp) {
	
					res[x][y+1][index][0] = 1;
					res[x][y+1][index][1] = tmp;
					upHeap(tmp, x, y+1, a);
				}	
			}
		}
	}
}

int find() {
	
	int kq = 100000000;
	for(int i = 0; i < 24; ++i) {
		
		if(res[s1][s2][i][0] == 1 && res[s1][s2][i][1] < kq) {

			kq = res[s1][s2][i][1];
		}
	}
	
	return kq;
}

int main() {

	input();
	solved();
	printf("%d", find());
}
