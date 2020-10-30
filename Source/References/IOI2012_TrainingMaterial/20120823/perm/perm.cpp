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
using namespace std;

int query(int a,int b,int c);
void answer(int x);

const int maxN=200+10;
typedef pair<int,int> II;
#define MP make_pair
#define PB push_back
#define fs first
#define sd second

int n,nq;
II a[maxN];
int b[maxN];

int send(int a,int b,int c){	
	if (b<a) swap(a,b);
	if (c<a) swap(a,c);
	if (c<b) swap(b,c);	
	nq++;
	//printf("Query %d:%d,%d,%d\n",nq,a,b,c);
	return query(a,b,c);
}

void partl(int lo,int hi){
	if (lo>=hi) return;
	swap(a[lo],a[lo+rand()%(hi-lo+1)]);		
	for (int i=lo+1;i<=hi;i++) a[i].fs=send(a[lo].sd,1,a[i].sd)*2;
	int p=a[lo].sd;
	a[lo].fs=a[lo+1].fs+1;
	sort(a+lo,a+hi+1);
	for (int i=lo;i<=hi;i++) if (a[i].sd==p){
		partl(i+1,hi); break;
	}
}
void partr(int lo,int hi){
	if (lo>=hi) return;
	swap(a[lo],a[lo+rand()%(hi-lo+1)]);		
	for (int i=lo+1;i<=hi;i++) a[i].fs=send(a[lo].sd,1,a[i].sd)*2+1;
	int p=a[lo].sd;
	a[lo].fs=a[lo+1].fs-1;
	sort(a+lo,a+hi+1);
	for (int i=lo;i<=hi;i++) if (a[i].sd==p){
		partl(lo,i-1); break;
	}
}

void solve(int N) {
	srand(1024);
	n=N; nq=0;
	if (n<=2){
		for (int i=1;i<=n;i++) answer(i);
		return;
	}
	for (int i=1;i<=n;i++) a[i]=MP(0,i);
	a[0].fs=a[n+1].fs=-1;
	int p1,p2,l,r;
	
	for (int i=2;i<=n-1;i++)
		a[i].fs=send(1,a[i].sd,n)*3+1;
	sort(a+2,a+n);
	a[1].fs=a[2].fs+1;
	a[n].fs=a[n-1].fs-1;
	sort(a+1,a+n+1);
	for (int i=1;i<=n;i++){
		if (a[i].sd==1) p1=i;
		if (a[i].sd==n) p2=i;
	}
	
	if (p1<p2){
		if (p1>1){
			l=a[p1-1].sd;
			if (p1+1<p2) r=a[p1+1].sd;
			else r=a[p2+1].sd;
			if (send(l,a[p1].sd,r)!=a[1].fs/3) swap(a[p1],a[p2]);
		}
		else{
			l=a[p1+1].sd;
			r=a[p2+1].sd;
			if (send(l,a[p2].sd,r)!=a[n].fs/3) swap(a[p1],a[p2]);
		}
		partr(1,p1-1);
		partl(p2+1,n);		
	}
	else{
		if (a[2].fs/3==2){
			swap(a[p1],a[2]);
			partl(3,n);
		}
		else{
			swap(a[p2],a[n-1]);
			partr(1,n-2);
		}
	}
	//answer
	for (int i=1;i<=n;i++) b[a[i].sd]=i;
	//for (int i=1;i<=n;i++) printf("%d,",b[i]); printf("\n");
	printf("nq=%d\n",nq);
	for (int i=1;i<=n;i++) answer(b[i]);
}
