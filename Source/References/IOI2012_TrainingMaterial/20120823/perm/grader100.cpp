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
#include "perm.cpp"
#define maxn 205
#define maxQuery 1250
using namespace std;

int TesterPerm[maxn],TesterN,TesterQuery,TesterIdx;
int TesterOutput[maxn];
int pos[maxn];
FILE* fa;

void init() {
  scanf("%d", &TesterN);
  for (int i = 1; i <= TesterN; i++) scanf("%d", &TesterPerm[i]);
  TesterQuery = TesterIdx = 0;
  memset(pos,-1,sizeof(pos));
}

int query(int a,int b,int c) {
  if (a <= 0 || b <= a || c <= b || c > TesterN) {
    fprintf(fa,"Error");
    printf("Query %d %d %d is invalid\n", a, b, c);
    exit(1);
  }
  TesterQuery++;
  if (TesterQuery > maxQuery) {
    fprintf(fa,"Error");
    printf("Exceeded number of query\n");
    exit(1);
  }

  vector<int> r;
  r.push_back(TesterPerm[a]);
  r.push_back(TesterPerm[b]);
  r.push_back(TesterPerm[c]);
  sort(r.begin(),r.end());
  return r[1];
}

void answer(int x) {
  if (x <= 0 || x > TesterN) {
    fprintf(fa,"Error");
    printf("Output out of range\n");
    exit(1);
  }

  TesterIdx++;
  TesterOutput[TesterIdx] = x;
  if (TesterIdx < TesterN) return;

    for (int i = 1; i <= TesterN; i++) if (pos[TesterOutput[i]] >= 0) {
      fprintf(fa,"WA");
      printf("Incorrect answer: Not a permutation\n");
      exit(1);
    }    
    else pos[TesterOutput[i]] = i;
    
    for (int i = 1; i <= TesterN; i++) if (TesterPerm[i] == 1)
      for (int j = 1; j < i; j++) if (TesterPerm[j] == 2) swap(TesterPerm[i],TesterPerm[j]);
    
    for (int i = 1; i <= TesterN; i++) if (TesterPerm[i] == TesterN - 1)
      for (int j = 1; j < i; j++) if (TesterPerm[j] == TesterN) swap(TesterPerm[i],TesterPerm[j]);

    for (int i = 1; i <= TesterN; i++) if (TesterOutput[i] == 1)
      for (int j = 1; j < i; j++) if (TesterOutput[j] == 2) swap(TesterOutput[i],TesterOutput[j]);
    
    for (int i = 1; i <= TesterN; i++) if (TesterOutput[i] == TesterN - 1)
      for (int j = 1; j < i; j++) if (TesterOutput[j] == TesterN) swap(TesterOutput[i],TesterOutput[j]);

    for (int i = 1; i <= TesterN; i++) if (TesterPerm[i] != TesterOutput[i]) {
       fprintf(fa,"WA");
       printf("Incorrect permutation\n");
       exit(1);
    }

    fprintf(fa,"OK");
    printf("OK, %d queries\n", TesterQuery);
    exit(1);
}

int main() {
  fa = fopen("log","w");
  init();
  solve(TesterN);
}
