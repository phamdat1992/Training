#include <iostream>
#include <cstdio>
#include <cstring>
#include <vector>
#include <list>
#include <stack>
#include <ctime>
#include <cstdlib>

using namespace std;

struct lItem {
	
	int dx;
	int dy;
};

struct tree {
	
	int vertexA;
	int vertexB;
	int cost;
};

struct npath {
	
	int vertexA;
	int vertexB;
	int nedg;
};

struct node {
	
	int nedge;
	int cost;
};

const int nrow = 30;
const int ncolumn = 25;
const int oo = 1000000000;

int inventory [100][100] = 
///////////1-------------7------------13------------19------------25
{
 /*00*/ {2,2, 2,2,2,2,2, 2, 2,2,2,2,2, 2, 2,2,2,2,2, 2, 2,2,2,2,2, 2},
 /*01*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*02*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*03*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*04*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*05*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*06*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*07*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*08*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*09*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*10*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*11*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,1,0, 2, 0,0,0,0,0, 2},
 /*12*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*13*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*14*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*15*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*16*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*17*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*18*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*19*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*20*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*21*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*22*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*23*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*24*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*25*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*26*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*27*/ {2,2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2, 0,0,0,0,0, 2},
 /*28*/ {2,2, 2,2,2,2,2, 2, 2,2,2,2,2, 2, 2,2,2,2,2, 2, 2,2,2,2,2, 2},
 /*29*/ {2,2, 2,2,2,2,2, 2, 2,2,2,2,2, 2, 2,2,2,2,2, 2, 2,2,2,2,2, 2},
 /*30*/ {2,2, 2,2,2,2,2, 2, 2,2,2,2,2, 1, 2,2,2,2,2, 2, 2,2,2,2,2, 2}
};

int visit [100] = {0};
int flag [100] = {0};

lItem listIt [100] = {0};
npath fpath [100] = {0};
tree heap [100] = {0};

node euler [100][100] = {0};

int fcount = 0;
int nfpath = 0;
int nItem = 0;
int fmin = 0;

int min(int a, int b) {
	
	return (a < b)? a : b;
}

void swap(int &a, int &b) {
	
	a ^= b ^= a ^= b;
}

void upHeap(int vertexA, int vertexB, int cost) {
	
	++heap[0].cost;
	
	heap[heap[0].cost].vertexA = vertexA;
	heap[heap[0].cost].vertexB = vertexB;
	heap[heap[0].cost].cost = cost;
	
	int i = heap[0].cost;
	int j = i >> 1;
	
	while(j && heap[j].cost > heap[i].cost) {
		
		swap(heap[j].vertexA, heap[i].vertexA);
		swap(heap[j].vertexB, heap[i].vertexB);
		swap(heap[j].cost, heap[i].cost);
		
		i = j;
		j = i >> 1;
	}
}

void popHeap() {
	
	int r = 1, c;
	tree v = heap[heap[0].cost--];
	
	while((r << 1) <= heap[0].cost) {
		
		c = r << 1;
		if(c < heap[0].cost && heap[c+1].cost < heap[c].cost) {
			
			++c;
		}
		if(heap[c].cost >= v.cost) {
			
			break;
		}
		
		heap[r].vertexA = heap[c].vertexA;
		heap[r].vertexB = heap[c].vertexB;
		heap[r].cost = heap[c].cost;
		
		r = c;
	}
	
	heap[r].vertexA = v.vertexA;
	heap[r].vertexB = v.vertexB;
	heap[r].cost = v.cost;
}

void createData() {
	
	srand(time(NULL));
	
	for(int i = 1; i <= 10; ++i) {
		
		int rx = rand()%27 + 1;
		int ry = rand()%25 + 1;
		
		if(inventory[rx][ry] == 0) {
		
			++nItem;	
			inventory[rx][ry] = -nItem;
			listIt[nItem].dx = rx;
			listIt[nItem].dy = ry;
		}
	}

	++nItem;	
	inventory[30][13] = -nItem;
	listIt[nItem].dx = 30;
	listIt[nItem].dy = 13;
}

void createPath(int it) {
	
	int fa [100][100];
	bool fcheck [100][100];
	tree lqueue [1000];
	
	for(int i = 1; i <= nrow; ++i) {
		
		for(int j = 1; j <= ncolumn; ++j) {
			
			fa[i][j] = oo;
			fcheck[i][j] = false;
		}
	}
	
	lqueue[1].vertexA = listIt[it].dx;
	lqueue[1].vertexB = listIt[it].dy;
	lqueue[1].cost = 0;
	for(int nl = 1, nq = 1; nq >= nl; ++nl) {
		
		int x = lqueue[nl].vertexA;
		int y = lqueue[nl].vertexB;
		
		if(inventory[x][y] <= 2) {
			
			if(y > 1 && fcheck[x][y-1] == false) {
				
				++nq;
				lqueue[nq].vertexA = x;
				lqueue[nq].vertexB = y - 1;

				fa[x][y-1] = min(fa[x][y-1], lqueue[nl].cost + 1);
				lqueue[nq].cost = fa[x][y-1];
				fcheck[x][y-1] = true;
			}
			if(y < ncolumn && fcheck[x][y+1] == false) {
				
				++nq;
				lqueue[nq].vertexA = x;
				lqueue[nq].vertexB = y + 1;

				fa[x][y+1] = min(fa[x][y+1], lqueue[nl].cost + 1);
				lqueue[nq].cost = fa[x][y+1];
				fcheck[x][y+1] = true;
			}
		}

		if(inventory[x][y] == 2) {

			if(x > 1 && fcheck[x-1][y] == false) {
				
				++nq;
				lqueue[nq].vertexA = x - 1;
				lqueue[nq].vertexB = y;

				fa[x-1][y] = min(fa[x-1][y], lqueue[nl].cost + 1);
				lqueue[nq].cost = fa[x-1][y];
				fcheck[x-1][y] = true;
			}
			if(x < nrow && fcheck[x+1][y] == false) {
				
				++nq;
				lqueue[nq].vertexA = x + 1;
				lqueue[nq].vertexB = y;

				fa[x+1][y] = min(fa[x+1][y], lqueue[nl].cost + 1);
				lqueue[nq].cost = fa[x+1][y];
				fcheck[x+1][y] = true;
			}
		}
			
		if(inventory[x][y] < 0 && -inventory[x][y] != it) {
			
			upHeap(-inventory[x][y], it, fa[x][y]);
		}
	}
}

void buildGraph() {
	
	for(int i = 1; i <= nItem; ++i) {
		
		createPath(i);
	}
}

void init() {
	
	for(int i = 1; i <= nItem; ++i) {
		
		flag[i] = i;
	}
}

int getFlag(int x) {
	
	if(x != flag[x]) {
		
		flag[x] = getFlag(flag[x]);
	}
	
	return flag[x];
}

void updateFlag(int x, int i) {
	
	if(x != flag[x]) {
		
		updateFlag(flag[x], i);
	}
	
	flag[x] = i;
}

bool findPath(int u, int v, int cost) {
	
	bool fcheck = false;
	::visit[u] = fcount;

	if(u != v) {
		
		for(int i = 1; i <= nItem; ++i) {
		
			if(i != u && ::visit[i] != ::fcount && euler[u][i].nedge != 0) {
				
				++nfpath;
				fpath[nfpath].vertexA = u;
				fpath[nfpath].vertexB = i;
				
				if(euler[u][i].nedge > 1) {
					
					fpath[nfpath].nedg = euler[u][i].nedge - 1;
					fcheck = findPath(i, v, cost - euler[u][i].cost);
				}
				else if(euler[u][i].nedge == 1) {
					
					fpath[nfpath].nedg = euler[u][i].nedge + 1;
					fcheck = findPath(i, v, cost + euler[u][i].cost);
				}
				
				--nfpath;
			}
		}
	}
	else if(cost < fmin) {
	
		fmin = cost;
		for(int i = 1; i <= nfpath; ++i) {
			
			int vertexA = fpath[i].vertexA;
			int vertexB = fpath[i].vertexB;
			int nedg = fpath[i].nedg;
			
			euler[vertexA][vertexB].nedge = nedg;
			euler[vertexB][vertexA].nedge = nedg;
		}
		
		fcheck = true;
	}
	
	return fcheck;
}

void buildTree() {
	
	for(;::heap[0].cost > 0; popHeap()) {
		
		int vertexA = ::heap[1].vertexA;
		int vertexB = ::heap[1].vertexB;
		int cost = ::heap[1].cost;
		
		int fdA = getFlag(vertexA);
		int fdB = getFlag(vertexB);
		
		if(fdA != fdB) {
			
			int fdm = min(fdA, fdB);
			
			updateFlag(vertexA, fdm);
			updateFlag(vertexB, fdm);
			
			::euler[vertexA][vertexB].nedge = 2;
			::euler[vertexB][vertexA].nedge = 2;
			
			::euler[vertexA][vertexB].cost = cost;
			::euler[vertexB][vertexA].cost = cost;
		}
		else {
			
			::nfpath = 0;
			::fmin = 0;
			++::fcount;
			if(findPath(vertexA, vertexB, cost) == true) {
				
				euler[vertexA][vertexB].nedge = 1;
				euler[vertexB][vertexA].cost = cost;
			}
		}
	}
}

void printfEuler() {

	for(int i = 1; i <= nItem; ++i) {

		for(int j = i+1; j <= nItem; ++j) {

			if(euler[i][j].nedge != 0) {

				printf("vertex: %d, vertex: %d, nedge: %d\n", i, j, euler[i][j].nedge);
			}
		}
	}
}

void printfInventory() {

	for(int i = 1; i <= nrow; ++i) {

			for(int j = 1; j <= ncolumn; ++j) {

				printf("%2d", inventory[i][j]);
			}

			printf("\n");
	}
}

int main() {
	
	createData();
	printfInventory();
	init();
	buildGraph();
	buildTree();
	printfEuler();
}
