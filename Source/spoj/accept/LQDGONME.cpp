#include <cstdio>

int d = 0;

int check [2000] = {0};
int a [2000][2000] = {0};
int b [2000] = {0};

int n, m;

void input() {
	
	scanf("%d %d", &m, &n);
	for(int i = 1; i <= n; ++i) {
		
		for(int j = 1; j <= m; ++j) {
			
			scanf("%d", &a[i][j]);
		}
	}
}

int max(int a, int b) {
	
	return (a > b)? a : b;
}

int solved() {
	
	int res = 1;
	
	for(int i = 1; i <= m; ++i) {
		
		b[i] = max(b[i], 1);
		res = max(res, b[i]);
		++d;
		
		for(int j = 1; j <=n; ++j) {
			
			for(int z = 1; z <= m; ++z) {
				
				if(a[j][z] != a[1][i]) {
					
					check[a[j][z]] = d;
				}
				else {
					
					break;
				}
			}
		}
		
		for(int j = i + 1; j <= m; ++j) {
			
			if(check[a[1][j]] != d) {
				
				b[j] = max(b[j], b[i] + 1);
				res = max(res, b[j]);
			}
		}
	}
	
	return res;
}

int main() {
	
	input();
	printf("%d", solved());
}
