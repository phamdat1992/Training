#include <cstdio>

struct ac {
    
    int pNext;
    int pTail;
    int value;
};

struct bc {
    
    int c;
    int count;
};

int store [205][205] = {0};
char s [205];
bc a [205];

int len, na;

void init() {
    
    for(int i = 0; i < len; ++i) {
        
        if(a[na].c != s[i] - '0') {
            
            ++na;
            a[na].c = s[i] - '0';
        }
        
        ++a[na].count;
    }
}

void init(ac snum [10][205][205], ac local [10][205]) {
    
    for(int i = 0; i < 10; ++i) {
        
        for(int j = 1; j <= na; ++j) {
            
            local[i][j].pNext = 0;
            local[i][j].value = 0;
            local[i][j].pTail = 0;
            
            for(int z = 1; z <= na; ++z) {
                
                snum[i][j][z].pNext = 0;
                snum[i][j][z].value = 0;
            }
        }
    }
}

int solved(int l, int r) {
    
    if(l < r) {
        
        return 0;
    }
    else if(l == r) {
        
        return a[r].count*a[r].count;
    }
    else if(store[l][r] != 0) {
        
        return store[l][r];
    }
    else {
        
        ac snum [10][205][205];
        ac local [10][205];
        
        init(snum, local);
        
        for(int i = l; i <= r; ++i) {
            
            
            
            for(int toGo = local[a[i].c][0].pNext; toGo != 0; toGo = local[a[i].c][toGo].pNext) {
                
                for(int toNum = snum[a[i].c][toGo][0].pNext; toNum != 0; toNum = snum[a[i].c][toGo][toNum].pNext) {
                    
                    int stmp = solved(l+1, r-1) + snum[a[i].c][toGo][toNum].value - toNum;
                    store[l, i] =
                }
            }
            
            if(local[a[i].c][0].pNext == 0) {
                
                local[a[i].c][0].pNext = i;
                local[a[i].c][0].pTail = i;
            }
            else {
                
                int getTail = local[a[i].c][0].pTail;
                
                local[a[i].c][getTail].pNext = i;
                local[a[i].c][0].pTail = i;
            }
        }
    }
}

int main() {
    
    scanf("%d\n", &len);
    
    init();
    
    scanf("%s", s);
}