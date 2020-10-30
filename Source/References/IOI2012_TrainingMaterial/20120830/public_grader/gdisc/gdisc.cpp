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
using namespace std;

void remove(int u,int v);
void undo(int u,int v);
int query();
void output_bit(int x);

void solve(int N) {
  // write your code here
  remove(1,2);
  remove(1,3);
  int x = query();
  undo(1,2);
  int y = query();
  remove(2,4);
  int z = query();
  for (int i = 1; i <= N; i++)
    for (int j = 1; j <= N; j++)
      if (i == j) output_bit(0); else output_bit(1);
}
