#include <bits/stdc++.h>

#define REP(i, a, b) for (int i = (a), _end_ = (b); i < _end_; ++i)
#define UNP(i, a, b) for (int i = (a), _begin_ = (b); i >= _begin_; --i)
#define debug(...) fprintf(stderr, __VA_ARGS__)
#define mp make_pair
#define x first
#define y second
#define pb push_back
#define SZ(x) (int((x).size()))
#define ALL(x) (x).begin(), (x).end()

using namespace std;

typedef long long LL;

const int oo = 0x3f3f3f3f;

int n, k = 0;
int top = -1;
int st1 [2000001];
int st2 [2000001];

int solved(int in, int i) {

    int ii = i;
    if(top >= 0) {
        while(top >= 0 && st1[top] >= in) {
            k = max(k, (st1[top] <= i - st2[top])? st1[top]: 0);
            ii = st2[top];
            --top;
        }
    }

    return ii;
}

int main()
{
    std::ios_base::sync_with_stdio (false);
    cin>>n;
    REP(i, 0, n) {
        int in;
        cin>>in;
        int tmp = solved(in, i);
        ++top;
        st1[top] = in;
        st2[top] = tmp;
    }

    solved(0, n);
    cout<<k;
}