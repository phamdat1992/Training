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

bool examine(int mx,int my);
void answer(int mx,int my);

void solve(int n,int mx,int my) {
  // write your code here
  // the following is a sample
    int m;
    int xl,xr;
    xl=1;xr=mx;
    while (xl<xr)
    {
        m=(xl+xr) / 2;
        if (examine(m,my)==true) xr=m; else xl=m+1;
    }
    int yl,yr;
    yl=1;yr=my;
    while (yl<yr)
    {
        m=(yl+yr) / 2;
        if (examine(mx,m)==true) yr=m; else yl=m+1;
    }
    mx=xr;my=yr;
    //cout<<mx<<' '<<my;
    int l,r;
    l=0;r=min(mx-1,my-1);
    while (l<=r)
    {
        m=(l+r)/2;
        if (examine(mx-m,my-m)==true) xl=mx-m,yl=my-m,l=m+1; else r=m-1;
    }

    l=0;r=min(n-mx,n-my);
    while (l<=r)
    {
        m=(l+r)/2;
        if (examine(mx+m,my+m)==true) xr=mx+m,yr=my+m,l=m+1; else r=m-1;
    }

    mx=(xl+xr)/2;my=(yl+yr)/2;
    //cout<<mx<<' '<<my<<endl;
    l=0;r=min(mx-1,n-my);
    while (l<=r)
    {
        m=(l+r)/2;
        if (examine(mx-m,my+m)==true) xl=mx-m,yl=my+m,l=m+1; else r=m-1;
    }
    //cout<<xl<<' '<<yl<<endl;
    //cout<<mx<<' '<<my<<endl;
    //cout<<examine(11,8)<<endl;
    l=0;r=min(n-mx,my-1);
    while (l<=r)
    {
        m=(l+r)/2;
        //cout<<m<<' ';
        if (examine(mx+m,my-m)==true) xr=mx+m,yr=my-m,l=m+1; else r=m-1;
    }
    //cout<<xr<<' '<<yr<<endl;

  answer((xl+xr)/2,(yl+yr)/2);
  // end code here
}
