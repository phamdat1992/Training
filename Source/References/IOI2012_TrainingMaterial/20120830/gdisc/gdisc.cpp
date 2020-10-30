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

const int maxN=45;

int res[maxN][maxN],n;
int li[maxN][maxN],nlist,ct[maxN];
bool st[maxN][maxN];

void Remove(int u,int v){
	if (!st[u][v]) return;
	st[u][v]=false;
	//printf("..\n");
	remove(u,v);
}

void Undo(int u,int v){
	if (st[u][v]) return;
	st[u][v]=true;
	//printf("..\n");
	undo(u,v);
}

int check(int mid,int *l,int nl,int u){
	//printf("u=%d\n",u);
	for (int i=0;i<mid;i++) Undo(u,l[i]);
	int res=query();	
	//printf("QUERY(%d,%d)=%d\n",mid,nl,res);
	for (int i=0;i<mid;i++) Remove(u,l[i]);
	return res;
}

void find(int *l,int nl){
	//printf("\tFind: "); for (int i=0;i<nl;i++) printf("%d ",l[i]); printf("\n");
	if (nl<=1) return;
	int u=l[nl-1]; nl--;
	int nb=nlist,lo,hi,mid,nx=nl,bb=nb; ct[nb]=0;
	for (int i=0;i<nl;i++) if (res[u][l[i]]!=0){
		//printf("%d.\n",res[u][l[i]]);
		 Remove(u,l[i]);
	 }
	while (true){
		lo=0; hi=nx+1;
		while (lo<hi){
			mid=(lo+hi)/2;
			if (check(mid,l,nx,u)) hi=mid; else lo=mid+1;
		}
		//printf("lo=%d\n",lo);
		if (lo==nx+1){ //Always not connected			
			for (int i=0;i<ct[nb];i++)				
				Undo(u,li[nb][i]);			
			nb++; ct[nb]=0;
			//printf("end\n");
		}
		else if (lo==0){ //Always connected => all (u,l[i]) = 0 (i<nx)
			nlist=nb;
			//printf("nx=%d\n",nx);
			for (int i=0;i<nx;i++){
				res[u][l[i]]=res[l[i]][u]=0;
				//printf("add.. %d\n",l[i]);
				for (int ib=bb;ib<nb;ib++) li[ib][ct[ib]++]=l[i];
			}
			break;
		} else{ // Edge (u,l[lo-1])
			//printf("add %d-%d(%d,nx=%d)\n",u,l[lo-1],nb,nx);
			res[u][l[lo-1]]=res[l[lo-1]][u]=1;
			li[nb][ct[nb]++]=l[lo-1];
			nx--; swap(l[lo-1],l[nx]);
		}
	}
	//printf("..%d\n",nb-bb);
	for (int ib=bb;ib<nb;ib++){
		for (int i=0;i<ct[ib];i++) if (res[u][li[ib][i]]==1) Remove(u,li[ib][i]);
		if (res[u][li[ib][0]]==1) Undo(u,li[ib][0]);		
		find(li[ib],ct[ib]);
	}	
}

void solve(int N) {	
	n=N;
	memset(res,-1,sizeof res);
	memset(st,true,sizeof st);
	for (int i=1;i<=n;i++) res[i][i]=0;
	nlist=1;
	for (int i=1;i<=n;i++) li[0][i-1]=i; ct[0]=n;	
	find(li[0],n);
	for (int i=1;i<=n;i++)
		for (int j=1;j<=n;j++){
			//printf("%d,%d=%d\n",i,j,res[i][j]);
			output_bit(res[i][j]==1);
		}
}
