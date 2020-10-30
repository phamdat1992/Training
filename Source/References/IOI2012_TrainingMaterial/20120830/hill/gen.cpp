#include <algorithm>
#include <bitset>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <deque>
#include <functional>
#include <iomanip>
#include <iostream>
#include <list>
#include <map>
#include <numeric>
#include <queue>
#include <set>
#include <sstream>
#include <stack>
#include <utility>
#include <vector>
#include <cstring>
#define maxn 1000
#define maxs maxn * maxn
using namespace std;

int perm[maxs];
int board[maxn][maxn];

int get(int i) {
  double slope = 1.0 * rand()/RAND_MAX;
  return slope * i;
}

string convert(int x) {
  stringstream w;  w << x;  return w.str();
}

int main() {
  long long g = 100003;
  for (int it = 1; it <= 20; it++) {
    srand(g);    
    g *= g;
    for (int i = 0; i < maxs; i++) perm[i] = i + 1;
    for (int i = 0; i < 500; i++) {
      int u = get(maxs),v = get(maxs);
      swap(perm[u],perm[v]);
    }
    for (int i = 0; i < maxn; i++)
      for (int j = 0; j < maxn; j++) board[i][j] = perm[i * maxn + j];

    FILE* fa = fopen((convert(it) + ".in").c_str(),"w");
    fprintf(fa,"1000 1000\n");
    for (int i = 0; i < maxn; i++)
      for (int j = 0; j < maxn; j++) {
        fprintf(fa,"%d ", board[i][j]);
	if (j == maxn - 1) fprintf(fa,"\n");
      }
  }
}
