#include <cstdio>

long long b, n, a, m;

long long solved() {
	
	long long res = 0ll;
	for(m = 1ll; m <= (n << 1); ++m) {
		
		long long exLeft = 2ll*b*m*n - b*m*m;
		if(exLeft >= 0ll && m != n) {
			
			if(exLeft == 0ll || exLeft % (n*n) == 0ll) {
				
				++res;
			}
		}
	}
	
	return res;
}

int main() {
	
	scanf("%lld %lld", &b, &n);
	printf("%lld", solved());
}
