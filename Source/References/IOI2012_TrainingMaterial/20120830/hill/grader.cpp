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
#include "hill.cpp"
#define maxQuery 3050
#define maxn 1000
using namespace std;

int M,N;
int hill[maxn][maxn];
int numQuery = 0;
int dx[4] = {-1,0,1,0};
int dy[4] = {0,1,0,-1};

void init() {
  scanf("%d %d", &M, &N);
  for (int i = 0; i < M; i++)
    for (int j = 0; j < N; j++) scanf("%d", &hill[i][j]);
}

bool inrange(int x,int range) {
  return (x >= 0 && x < range);
}

int examine(int x,int y) {
  if (!inrange(x,M) || !inrange(y,N)) {
    fprintf(stderr,"Examine invalid\n");
    printf("0");
    exit(1);
  }
  numQuery++;
  if (numQuery > maxQuery) {
    fprintf(stderr,"Number of query exceeded\n");
    printf("0");
    exit(1);
  }
  return hill[x][y];
}

void land(int x,int y) {
  if (!inrange(x,M) || !inrange(y,N)) {
    fprintf(stderr,"Invalid position\n");
    printf("0");
    exit(1);   
  }
  for (int i = 0; i < 4; i++) {
    int z = x + dx[i],t = y + dy[i];
    if (inrange(z,M) && inrange(t,N) && hill[x][y] < hill[z][t]) {
      fprintf(stderr,"Wrong answer: Not a peak\n");
      printf("0");
      exit(1);
    }
  }  
  fprintf(stderr,"OK, %d queries\n", numQuery);
  printf("100");
  exit(1);
}

int main() {
  init();
  solve(M,N);
}
