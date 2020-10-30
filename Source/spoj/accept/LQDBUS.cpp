#include <iostream>
#include <cstdio>
#include <algorithm>
#include <map>
#include <cmath>

using namespace std;

#define _0( x ) ( x & 0x7FF )
#define _1( x ) ( x >> 11 & 0x7FF )
#define _2( x ) ( x >> 22 )

const unsigned kHist = 2048;

struct ac {
	int value;
	int id;
};

struct unsignedAC {
	unsigned value;
	unsigned id;
};

int fhis[200101];
int ffmax[200101];
ac store[200101];
ac des[200101];
int hash[200101];

int n, m, len = 0, lenh = 0;
long long st = 0ll;



void input() {

	scanf("%d", &n);
	scanf("%d", &m);

	for (int i = 1, findex, t; i <= n; ++i) {

		scanf("%d", &t); 
		scanf("%d", &findex);
		for (; --findex >= 0; ++len) {

			scanf("%d", &store[len].value);
			store[len].value -= st;
			store[len].id = i;
		}

		st += t;
	}
}

inline unsigned FlipSign(unsigned x) {

	return x ^ 0x80000000;
}

void RadixSortValue(unsignedAC* source, unsignedAC* dest, int elements) {

	unsigned b0[kHist * 3] = { 0 };
	unsigned *b1 = b0 + kHist;
	unsigned *b2 = b1 + kHist;
	unsigned fi, tf;

	// making histograms
	for (int i = 0; i < kHist; ++i) {
		b0[i] = b1[i] = b2[i] = 0;
	}
	for (int i = 0; i < elements; ++i) {

		fi = FlipSign(source[i].value);

		++b0[_0(fi)];
		++b1[_1(fi)];
		++b2[_2(fi)];
	}

	{
		unsigned sum0 = 0, sum1 = 0, sum2 = 0;
		unsigned tsum;

		for (int i = 0; i < kHist; ++i) {

			tsum = b0[i] + sum0;
			b0[i] = sum0 - 1;
			sum0 = tsum;

			tsum = b1[i] + sum1;
			b1[i] = sum1 - 1;
			sum1 = tsum;

			tsum = b2[i] + sum2;
			b2[i] = sum2 - 1;
			sum2 = tsum;
		}
	}

	// sort for bit 0 - 10
	for (int i = 0; i < elements; ++i) {

		fi = FlipSign(source[i].value);
		tf = ++b0[_0(fi)];
		dest[tf].value = fi;
		dest[tf].id = source[i].id;
	}

	// sort for bit 11 - 21
	for (int i = 0; i < elements; ++i) {

		tf = ++b1[_1(dest[i].value)];
		source[tf] = dest[i];
	}

	// sort for bit 22 - 31
	for (int i = 0; i < elements; ++i) {

		tf = ++b2[_2(source[i].value)];
		dest[tf].value = FlipSign(source[i].value);
		dest[tf].id = source[i].id;
	}
}

void RadixSortID(unsignedAC* source, unsignedAC* dest, int elements) {

	unsigned b0[kHist * 3] = { 0 };
	unsigned *b1 = b0 + kHist;
	unsigned *b2 = b1 + kHist;
	unsigned fi, tf;

	// making histograms
	for (int i = 0; i < kHist; ++i) {
		b0[i] = b1[i] = b2[i] = 0;
	}
	for (int i = 0; i < elements; ++i) {

		fi = FlipSign(source[i].id);

		++b0[_0(fi)];
		++b1[_1(fi)];
		++b2[_2(fi)];
	}

	{
		unsigned sum0 = 0, sum1 = 0, sum2 = 0;
		unsigned tsum;

		for (int i = 0; i < kHist; ++i) {

			tsum = b0[i] + sum0;
			b0[i] = sum0 - 1;
			sum0 = tsum;

			tsum = b1[i] + sum1;
			b1[i] = sum1 - 1;
			sum1 = tsum;

			tsum = b2[i] + sum2;
			b2[i] = sum2 - 1;
			sum2 = tsum;
		}
	}

	// sort for bit 0 - 10
	for (int i = 0; i < elements; ++i) {

		fi = FlipSign(source[i].id);
		tf = ++b0[_0(fi)];
		dest[tf].id = fi;
		dest[tf].value = source[i].value;
	}

	// sort for bit 11 - 21
	for (int i = 0; i < elements; ++i) {

		tf = ++b1[_1(dest[i].id)];
		source[tf].value = dest[i].value;
		source[tf].id = dest[i].id;
	}

	// sort for bit 22 - 31
	for (int i = 0; i < elements; ++i) {

		tf = ++b2[_2(source[i].id)];
		dest[tf].id = FlipSign(source[i].id);
		dest[tf].value = source[i].value;
	}
}

void init() {
	RadixSortValue((unsignedAC*)store, (unsignedAC*)des, len);
	for (int i = 0, kq = -1; i < len; ++i) {
		if (des[i].value >= 0 && des[i].value != kq) {
			::hash[++lenh] = des[i].value;
			kq = des[i].value;
		}
	}

	RadixSortID((unsignedAC*)des, (unsignedAC*)store, len);
}

void update(int index, int value) {
	while (index <= lenh) {
		if (value > ::ffmax[index]) {
			::ffmax[index] = value;
		}
		else {
			return;
		}

		index += (index & -index);
	}
}

int get(int index) {
	int res = 0;
	while (index > 0) {
		res = max(res, ::ffmax[index]);
		index &= (index - 1);
	}

	return res;
}

int BIT(int x) {
	int l = 1, r = lenh;

	do {

		int mid = (l + r) >> 1;
		if (::hash[mid] == x) { return mid; }
		else if (::hash[mid] > x) { r = mid - 1; }
		else { l = mid + 1; }

	} while (l <= r);

	return -1;
}

long long solved() {

	long long res = 1000000000000ll;
	int kh = 0;

	for (int index = 0; index < len; ++index) {
		if (store[index].value >= 0) {
			int offset = BIT(store[index].value);
			int ff = get(offset);
			fhis[offset] = max(fhis[offset], ff) + 1;

			if (fhis[offset] > m) {
				fhis[offset] = m;
			}
			update(offset, fhis[offset]);

			if (kh < fhis[offset]) {
				kh = fhis[offset];
				res = st + store[index].value;
			}
			else if (kh == fhis[offset]) {
				res = min(res, st + (long long)store[index].value);
			}
		}
	}

	return (res == 1000000000000ll)? st : res;
}

int main() {
	input();
	init();
	cout << solved();
}