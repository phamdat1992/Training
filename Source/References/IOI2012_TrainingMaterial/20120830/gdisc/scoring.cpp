#include <algorithm>
#include <bitset>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <deque>
#include <fstream>
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

string convert(int x) {
  stringstream w;  w << x;  return w.str();
}

fstream fin;

int main() {
  int score = 0,test = 12;
  for (int i = 1; i <= test; i++) {
    fin.open((convert(i) + ".out").c_str(),ios::in);
    if ( fin.is_open() ) {
      int x;
      fin >> x;
      score += x;
    }
    fin.close();
  }
  printf("Score: %.0lf\n", 1.0 * score/test);
}
