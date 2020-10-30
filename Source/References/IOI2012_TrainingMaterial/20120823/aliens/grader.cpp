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
#include "aliens.cpp"
#define maxQuery 300
using namespace std;

int Tn,M,Tx,Ty,Rx,Ry,Hx,Hy,numQuery = 0;
int dx[3] = {0,2,4};
int dy[3] = {1,3,5};
int dz[2] = {1,3};
int dt[2] = {2,4};
FILE* fa;

bool inside(int xa, int xb, int ya, int yb, int xc, int yc) {
  return (xa <= xc && xc <= xb && ya <= yc && yc <= yb);
}

bool examine(int Qx,int Qy) {
  if (Qx <= 0 || Qx > Tn || Qy <= 0 || Qy > Tn) {
    fprintf(fa,"Error");
    printf("Queries out of range\n");
    exit(1);
  }
  numQuery++;
  if (numQuery > maxQuery) {
    fprintf(fa,"Error");
    printf("Number of query exceeded\n");
    exit(1);
  }
  for (int i = 0; i < 3; i++)
    for (int j = 0; j < 3; j++)
      if (inside(Rx + dx[i] * M,Rx + dy[i] * M - 1,Ry + dx[j] * M,Ry + dy[j] * M - 1,Qx,Qy)) return true;
  for (int i = 0; i < 2; i++)
    for (int j = 0; j < 2; j++)
      if (inside(Rx + dz[i] * M,Rx + dt[i] * M - 1,Ry + dz[j] * M,Ry + dt[j] * M - 1,Qx,Qy)) return true;
  return false;
}

void answer(int Ox,int Oy) {
  if (Hx != Ox || Hy != Oy) {
    fprintf(fa,"WA");
    printf("Incorrect answer\n");
  }
  else {
    printf("OK, %d queries\n", numQuery);
    fprintf(fa,"OK");
  }
  exit(1);
}

int main() {
  fa = fopen("log","w");
  scanf("%d %d %d %d %d %d", &Tn, &M, &Tx, &Ty, &Hx, &Hy);
  Rx = Hx - (2 * M + M/2);
  Ry = Hy - (2 * M + M/2);
  solve(Tn,Tx,Ty);
}
