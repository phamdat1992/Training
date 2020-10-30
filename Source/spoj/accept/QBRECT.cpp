#include <cstdio>

struct ac {
	
	int height;
	int start;
	int end;
};

bool a [1001][1001] = {0};
int bit [1001][1001];
ac stack [1001] = {0};

int n, m;

void input() {
	
	scanf("%d %d", &n, &m);
	
	for(int i = 1; i <= n; ++i) {
		
		for(int j = 1, c; j <=m; ++j) {
			
			scanf("%d", &c);
			a[i][j] = (c == 1);
		}
	}
}

int max(int a, int b) {
	
	return (a > b)? a : b;
}

int doGet(int &flag, int height) {
	
	int res = 0;
	int len = stack[flag].end;
	
	for(;stack[flag].height > height; --flag) {
		
		res = max(res, (len - stack[flag].start + 1)*stack[flag].height);
	}
	
	if(stack[flag].height < height || flag == 0) {
		
		++flag;
	}
	
	return res;
}

int solved() {
	
	int res = 0;
	
	for(int i = 1, flag = 0; i <= n; ++i) {
		
		for(int j = 1; j <= m; ++j) {
			
			if(a[i][j] == true) {
				
				bit[i][j] = bit[i-1][j] + 1;

				if(stack[flag].height < bit[i][j]) {
					
					++flag;
					stack[flag].start = j;
					stack[flag].end = j;
					stack[flag].height = bit[i][j];
					
					res = max(res, stack[flag].height);
				}
				else if(stack[flag].height > bit[i][j]) {
					
					res = max(res, doGet(flag, bit[i][j]));
					stack[flag].height = bit[i][j];
					stack[flag].end = j;
					res = max(res, (j - stack[flag].start + 1)*stack[flag].height);
				}
				else {
					
					stack[flag].end = j;
					res = max(res, (j - stack[flag].start + 1)*stack[flag].height);
				}
			}
			else {
				
				res = max(res, doGet(flag, 0));
				flag = 0;
			}
		}
		
		res = max(res, doGet(flag, 0));
		flag = 0;
	}
	
	return res;
}

int main() {
	
	input();
	printf("%d", solved());
}
