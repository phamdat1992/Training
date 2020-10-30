#include <algorithm>
#include <bitset>
#include <cmath>
#include <ctime>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <deque>
#include <fstream>
#include <functional>
#include <iostream>
#include <map>
#include <set>
#include <sstream>
#include <stack>
#include <queue>
#include <vector>
#include <utility>
#include "gdisc.cpp"
#define maxQuery 5000
#define maxn 42
using namespace std;

bool graph[maxn][maxn],active[maxn][maxn];
int N,num = 0,cntX = 1,cntY = 0;

void init() {
  scanf("%d", &N);
  for (int i = 1; i <= N; i++)
    for (int j = 1; j <= N; j++) scanf("%d", &graph[i][j]);
  memset(active,true,sizeof(active));
}

bool inrange(int x) {
  return (x > 0 && x <= N);
}

void remove(int u,int v) {
  if (!inrange(u) || !inrange(v) || u == v || !active[u][v]) {
    fprintf(stderr,"Invalid removal");
    printf("0");
    exit(1);
  }
  active[u][v] = active[v][u] = false;
}

void undo(int u,int v) {
  if (!inrange(u) || !inrange(v) || u == v || active[u][v]) {
    fprintf(stderr,"Invalid undo");
    printf("0");
    exit(1);
  }
  active[u][v] = active[v][u] = true;
}

int query() {
  num++;
  if (num > maxQuery) {
    fprintf(stderr,"Exceeded number of queries\n");
    printf("0");
    exit(1);
  }
  bool vis[maxn];
  memset(vis,false,sizeof(vis));
  vis[1] = true;
  queue<int> q;
  q.push(1);
  while (!q.empty()) {
    int u = q.front();  q.pop();
    for (int v = 1; v <= N; v++)
      if (!vis[v] && active[u][v] && graph[u][v]) {
        vis[v] = true;
	q.push(v);
      }
  }
  for (int i = 1; i <= N; i++) if (!vis[i]) return 0;
  return 1;
}

void output_bit(int x) {  
  cntY++;
  if (cntY > N) {
    cntX++;
    cntY = 1;
  }
  if (graph[cntX][cntY] != x) {
    fprintf(stderr,"Incorrect answer: Element %d %d expected %d, found %d\n", cntX, cntY, graph[cntX][cntY], x);
    printf("0");
    exit(1);
  }
  if (cntX == N && cntY == N) {
    fprintf(stderr,"OK, %d queries\n", num);
    if (num <= 900) printf("100"); else printf("%.0lf", trunc(20 + 80 * 900.0/num + 1e-7));
    exit(1);
  }
}

int main() {
  init();
  solve(N);
}
