#include <iostream>
#include <cmath>

using namespace std;

int main() {
	long long n;
	long long k;
	
	cin >> n;
	k = (long long)floor(sqrt((double)n));
	if (k*(k + 1) < n) {
		++k;
	}
	else if (k * (k-1) >= n) {
		--k;
	}

	cout << k + n;
	return 0;
}