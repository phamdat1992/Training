#include <iostream>
#include <cstdio>
#include <cmath>
#include <algorithm>
#include <functional>

using namespace std;

const long long oo = 2000000000000000000ll;

struct node {
	int vnext;
	int cost;
	node* pnext;
	node* pprev;
	int ffcheck;
};

node* g[200000];
int n, k, t, source, sink;

bool visit[200000];
bool ffree[200000];

int trackUp[200000];
int trackDown[200000];

long long ccUp[200000];
long long ccDown[200000];

long long kq = oo;
int fflag = -1;

void init() {

	for (int i = 0; i <= n; ++i) {

		trackUp[i] = -1;
		trackDown[i] = -1;

		visit[i] = ffree[i] = false;

		ccUp[i] = oo;
		ccDown[i] = oo;
	}

	source = 1;
	sink = n;

	ccUp[sink] = oo;
	ccUp[source] = 0ll;

	ccDown[source] = oo;
	ccDown[sink] = 0ll;
}

void addNode(int u, int v, int c) {

	node* cur = ::g[u];
	::g[u] = new node;

	::g[u]->vnext = 0;
	::g[u]->vnext = v;
	::g[u]->cost = c;
	::g[u]->pnext = cur;
	::g[u]->pprev = ::g[u];

	if (cur != NULL) {
		cur->pprev = ::g[u];
	}
}

void rmNode(node* &cur, int u) {

	if (cur != NULL) {
		node* tm = cur;
		cur = cur->pnext;

		if (::g[u] == tm) {
			::g[u] = cur;
			if (g[u] != NULL) {
				g[u]->pprev = g[u];
			}
		}
		else {
			tm->pprev->pnext = cur;
			if (cur != NULL) {
				cur->pprev = tm->pprev;
			}
		}

		delete tm;
	}
}

void moveNodeToFirst(node* &cur, int u) {

	if (cur != NULL && cur != g[u]) {

		node* tmp = cur->pprev;
		tmp->pnext = cur->pnext;

		if (cur->pnext != NULL) {
			cur->pnext->pprev = tmp;
		}

		cur->pnext = ::g[u];
		g[u]->pprev = cur;
		cur->pprev = cur;
		g[u] = cur;
	}
}

bool reDefineGraph(int u) {

	::visit[u] = true;
	if (u == ::sink) { return true; }
	else {
		for (node* cur = g[u]; cur != NULL; cur = cur->pnext) {

			int vnext = cur->vnext;
			int cost = cur->cost;

			if (::visit[vnext] == false) {
				if (reDefineGraph(vnext) == true) {
					moveNodeToFirst(cur, u);
					return true;
				}
			}
		}
	}

	return false;
}

void input() {

	int x, y, c;
	scanf("%d%d", &n, &k);

	for (int i = 0; i < k; ++i) {

		scanf("%d%d%d", &x, &y, &c);
		addNode(x, y, c);
		addNode(y, x, c);
	}
}

void dfs(int u) {

	visit[u] = true;
	if (u != sink) {
		for (node* cur = g[u]; cur != NULL; ) {
if(cur->ffcheck != 1) {
	int vnext = cur->vnext;
			int cost = cur->cost;
			bool check = false;

			if (ccUp[vnext] > ccUp[u] + cost) {
				trackUp[vnext] = u;
				ccUp[vnext] = ccUp[u] + cost;
				check = true;
			}
			if (ccDown[vnext] > ccDown[u] + cost) {
				trackDown[vnext] = u;
				ccDown[vnext] = ccDown[u] + cost;
				check = true;
			}

			if (check == true && (visit[vnext] == false || ffree[vnext] == true)) {
				if (visit[vnext] == false || ffree[vnext] == false) {
					cur->ffcheck = 1;
					cur = cur->pnext;
				}
				
				dfs(vnext);
			}
			else {
				cur = cur->pnext;
			}

			if (trackDown[vnext] != u) {
				if (ccDown[u] > ccDown[vnext] + cost) {
					ccDown[u] = ccDown[vnext] + cost;
					trackDown[u] = vnext;
				}
			}

			if (trackUp[vnext] != u) {
				if (ccUp[u] > ccUp[vnext] + cost) {
					ccUp[u] = ccUp[vnext] + cost;
					trackUp[u] = vnext;
				}
			}
} else {
	cur = cur->pnext;
}
			
		}
	}

	ffree[u] = true;

	if (kq > ccUp[u] + ccDown[u]) {
		kq = ccUp[u] + ccDown[u];
		fflag = u;
	}
}

void getBackTrack(int u) {
	if (u != -1) {
		getBackTrack(trackUp[u]);
		cout << u << " ";
	}
}

void getNextTrack(int u) {
	for (int i = trackDown[u]; i != -1; i = trackDown[i]) {
		cout << i << " ";
	}
}

int main() {

	input();
	reDefineGraph(1);
	init();
	dfs(source);

	if (kq == oo) {
		cout << -1;
	}
	else {
		getBackTrack(trackUp[fflag]);
		cout << fflag << " ";
		getNextTrack(fflag);
	}
}