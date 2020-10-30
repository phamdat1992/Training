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
#define foru(i,a,b) for(int i=a;i<=b;i++)
#define nmax 1010
int examine(int x,int y);
void land(int x,int y);
int n,m,h[nmax][nmax];
bool used[nmax][nmax];
bool kq;
int dx1[] = {0,1,0,-1};
int dy1[] = {1,0,-1,0};
int get(int x,int y)
{
   // cout << "get" << " " << x << " " << y<< endl;
    if (0<=x && x< n && 0<=y && y< m)
      {
         if (used[x][y]) return h[x][y];
         used[x][y] = true;
         h[x][y] = examine(x,y);
         return h[x][y];
      } else return 0;
}
void DFS(int u,int v,int y)
{
   // cout << "enter" << " " << u << " " << v << endl;
    if (kq) return;
    int vt[5];
    foru(k,0,3) vt[k]=k;
    foru(i,1,10) swap(vt[rand()%4],vt[rand() % 4]);
    foru(k,0,3)
      {
          int i = u+dx1[k];
          int j = v+dy1[k];
          int x = get(i,j);
          if (x>y) DFS(i,j,x);
          if (kq) return;
      }
    if (kq) return;
    kq = true;
    land(u,v);
}
void solve(int M,int N) {
    n  =  M;
    m  =  N;
    int bdx = rand() % n;
    int bdy = rand() % m;
    int x = get(bdx,bdy);
    kq  = false;
    DFS(bdx,bdy,x);
}
