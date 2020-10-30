#include <cstdio>

struct graph{
    
    graph* nextVertext;
    int vertexV;
    int capacity;
    int idHook;
};

struct tnode {
    
    int tleft;
    int tright;
    tnode* ntomb;
};

const int nvertex = 1000;
const int nedge = 1000000;

graph* a [nvertex];
tnode* tomb [nvertex];
tnode* idGo [nvertex];
bool visit [nvertex] = {false};
bool free [nvertex] = {false};
int hook [nvertex] = {0};
int source [nvertex] = {0};

void init() {
    
    for(int i = 0; i < nedge; ++i) {
        
        hook[i] = i;
    }
    
    for(int i = 0; i < nvertex; ++i) {
        
        source[i] = 0;
    }
}

void createHook(int u) {
    
    int count = 0;
    for(graph* v = a[u]; v != NULL; v = v.nextVertext) {
        
        ++count;
        createHook(vVertext);
    }
    
    if(count == 1) {
        
        hook[a[u].nextVertext] = u;
    }
}

void input() {
    
    
}

int dfs(int u) {
    
    visit[u] = true;
    
    for(graph* v = a[u]; v != NULL; v = v.nextVertext) {
        
        int vVertext = v.vertexV;
        int vCapacity = v.capacity;
        
        //cung xuoi
        if(visit[vVertext] == false) {
            
            int r = dfs(vVertext);
        }
        //cung nguoc
        else if(free[vVertext] == false) {
            
            
        }
        //cuong cheo
        else {
            
            int vtop = hook[vVertext];
            //biet duoc khoang source.
            //moi khoang co mot id rieng?
            
        }
    }
    
    free[u] = true;
}
