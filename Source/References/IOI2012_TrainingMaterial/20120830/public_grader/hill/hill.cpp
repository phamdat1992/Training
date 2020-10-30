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

int examine(int x,int y);
void land(int x,int y);

void solve(int M,int N) {
  // write your code here
  int x = examine(0,0);
  int y = examine(2,4);
  int z = examine(M - 1,N - 1);
  land(M - 1,0);
}
