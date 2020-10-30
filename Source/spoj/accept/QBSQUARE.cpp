#include <cstdio>

struct ac{
	
	int dCh;
	int dNg;
	int dDo;
};

bool a [1001][1001] = {0};
ac bit [2][1001][1001];

int n, m;

void input() {
	
	scanf("%d %d", &n, &m);
	for(int i = 1; i <= n; ++i) {
		
		for(int j = 1, c; j <= m; ++j) {
			
			scanf("%d", &c);
			a[i][j] = (c == 1);
		}
	}
}

int min(int a, int b) {
	
	return (a < b)? a : b;
}

int max(int a, int b) {
	
	return (a > b)? a : b;
}

int solved() {
	
	int res = 0;
	
	for(int i = 1; i <= n; ++i) {
		
		for(int j = 1; j <= m; ++j) {
			
			bit[a[i][j]][i][j].dCh = bit[a[i][j]][i-1][j-1].dCh + 1;
			bit[a[i][j]][i][j].dDo = bit[a[i][j]][i-1][j].dDo + 1;
			bit[a[i][j]][i][j].dNg = bit[a[i][j]][i][j-1].dNg + 1;
			
			bit[a[i][j]][i][j].dCh = min(bit[a[i][j]][i][j].dCh, min(bit[a[i][j]][i][j].dDo, bit[a[i][j]][i][j].dNg));
			
			res = max(res, bit[a[i][j]][i][j].dCh);
		}
	}
	
	return res;
}

int main() {
	
	input();
	printf("%d", solved());
}
