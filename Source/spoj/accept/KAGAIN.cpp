#include <cstdio>

struct ac {
	
	int height;
	int start;
	int end;
	int value;
};

int a [30001] = {0};
ac lvt [30001];
ac res;

int n, t;

void input() {
	
	scanf("%d", &n);
	for(int i = 1; i <= n; ++i) {
		
		scanf("%d", &a[i]);
	}
}

void init() {
	
	res.end = 0;
	res.start = 0;
	res.height = 0;
	res.value = 0;
}

int max(int a, int b) {
	
	return (a > b)? a : b;
}

ac doGet(int &flag, int height) {
	
	int len = lvt[flag].end;
	ac res;
	
	res.value = 0;
	for(;lvt[flag].height > height; --flag) {
		
		if(res.value <= lvt[flag].height*(len - lvt[flag].start + 1)) {
			
			res.value = lvt[flag].height*(len - lvt[flag].start + 1);
			res.height = lvt[flag].height;
			res.end = len;
			res.start = lvt[flag].start;
		}
	}
	
	if(flag == 0 || lvt[flag].height < height) {
		
		++flag;
	}
	
	return res;
}

void solved() {
	
	int flag = 0;
	for(int i = 1; i <=n; ++i) {
		
		if(a[i] == 0) {
			
				ac tmp = doGet(flag, 0);
				flag = 0;
				if(tmp.value > res.value) {
					
					res = tmp;
				}
		}
		else if(a[i] > lvt[flag].height) {
			
			++flag;
			lvt[flag].start = i;
			lvt[flag].end = i;
			lvt[flag].height = a[i];
			lvt[flag].value = a[i];
			
			if(res.value < lvt[flag].value) {
				
				res = lvt[flag];
			}
		}
		else if(lvt[flag].height > a[i]) {
			
			ac tmp = doGet(flag, a[i]);
			if(tmp.value > res.value) {
				
				res = tmp;
			}
			
			lvt[flag].end = i;
			lvt[flag].height = a[i];
			lvt[flag].value = (lvt[flag].end - lvt[flag].start + 1)*lvt[flag].height;
			
			if(res.value < lvt[flag].value) {
				
				res = lvt[flag];
			}
		}
		else {
			
			lvt[flag].end = i;
			lvt[flag].value += lvt[flag].height;
			
			if(res.value < lvt[flag].value) {
				
				res = lvt[flag];
			}
		}
	}
	
	ac tmp = doGet(flag, 0);
	if(tmp.value > res.value) {
		
		res = tmp;
	}
}

int main() {
	
	scanf("%d", &t);
	for(int i = 0; i < t; ++i) {
		
		input();
		init();
		
		if(n == 0) {
			
			printf("0 0 0\n");
		}
		else {
			
			solved();
			printf("%d %d %d\n", res.value, res.start, res.end);
		}
	}
}
