#include <iostream.h>
#include <fstream.h>
#include <string.h>
#include <stdlib.h>

//#define DEBUG

class city {
  public:
    int x, y, divx, divy;
    int posx, posy;
    int pos;
    long order;
    int position;
    city(){}
    void set(char* n, int p, int X, int Y, int sizeX, int sizeY);
};

void city::set(char* n, int p, int X, int Y, int sizeX, int sizeY)
{
  order = (long)X + Y + (sizeX* sizeY)*1000l;
//  order = random(1000);
  pos = p;
  posx = -1;
  posy = -1;
  x = X;
  y = Y;
  divx = (strlen(n)+1)*sizeX;
  divy = sizeY;
//  order += (long)divx*divy*1000000;
//  order = random(100000);
}


class map {
  private:
    char* filename;
    ifstream in;
    int num;
    city* fred;
    public : int count;

  public:
    map(char* name);
    ~map();
    void run();
    void sortorder();
    void sort();
    int used(int which, int x1, int y1, int x2, int y2);
    void insert(int i);
    void move(int i);
};

map::map(char* t)
//:filename(t), count(-0)
{
  filename = t;
  char name[100];
  strcpy(name, filename);
  strcat(name, ".dat");
  in.open(name);
  in >> num;
  fred = new city[num];
  int i;
  for(i =0 ; i< num; i++)
  {
    int x, y, sizex, sizey;
    char name[300];
    in >> x >> y>> sizex>> sizey>>name;
    fred[i].set(name, i, x, y, sizex, sizey);
  }
}

map::~map()
{
  char name[100];
  strcpy(name, filename);
  strcat(name, ".out");
  ofstream out(name);
  for (int i = 0; i < num; i++)
     out << fred[i].posx << " " << fred[i].posy << endl;
  delete[] fred;
}

void map::sort()
{

  int pos;
  for (int i = 0; i < num; i++)
  {
    pos = i;
    for (int j = i+1; j < num; j++)
       if (fred[j].order < fred[pos].order) pos = j;
    if (j != i)
    {
      city t;
      t = fred[i];
      fred[i] = fred[pos];
      fred[pos] = t;
    }
  }

}

int map::used(int which, int x1, int y1, int x2, int y2)
{
  if (x1 < 0) return 1;
  if (x2 > 1000) return 1;
  if (y1 < 0) return 1;
  if (y2 > 1000) return 1;

  int i;
  for (i = 0; i < num; i++)
  {
    if (i == which) continue;            // may use own space
    if (fred[i].x < x2 && fred[i].x >= x1
      && fred[i].y < y2 && fred[i].y >= y1)
	return 3;  // covers city
    if (fred[i].posx != -1)
    if (y1 < fred[i].posy + fred[i].divy
	    && y2 > fred[i].posy
	    && x1 < fred[i].posx + fred[i].divx
	    && x2 > fred[i].posx)
	    return 2;        // covers a lable
  }
  return 0;
}

void map::insert(int i)
{
  if (!used(i, fred[i].x-fred[i].divx,     // bottomleft
	fred[i].y+1,
	fred[i].x,
	fred[i].y+fred[i].divy+1))
  {
    fred[i].posx = fred[i].x-fred[i].divx;
    fred[i].posy = fred[i].y+1;
    count++;
    fred[i].position = 2;
  }
  else
  if (!used(i, fred[i].x+1,               // bottomright
	fred[i].y+1,
	fred[i].x+fred[i].divx+1,
	fred[i].y+fred[i].divy+1))
  {
    fred[i].posx = fred[i].x+1;
    fred[i].posy = fred[i].y+1;
    count++;
    fred[i].position = 4;
  }
  else
  if (!used(i, fred[i].x-fred[i].divx,       // topleft
	fred[i].y-fred[i].divy,
	fred[i].x,
	fred[i].y))
  {
    fred[i].posx = fred[i].x-fred[i].divx;
    fred[i].posy = fred[i].y-fred[i].divy;
    count++;
    fred[i].position = 1;
  }
  else
  if (!used(i, fred[i].x+1,                    // topright
	fred[i].y-fred[i].divy,
	fred[i].x + fred[i].divx+1,
	fred[i].y))
  {
    fred[i].posx = fred[i].x+1;
    fred[i].posy = fred[i].y-fred[i].divy;
    count++;
    fred[i].position = 3;
  }
}

void map::move(int i)
{
  int loop = 0;

  switch (fred[i].position)
  {
  case 4:
start:
    if (!used(i, fred[i].x-fred[i].divx,       // topleft
	fred[i].y-fred[i].divy,
	fred[i].x,
	fred[i].y))
    {
      fred[i].posx = fred[i].x-fred[i].divx;
      fred[i].posy = fred[i].y-fred[i].divy;
      fred[i].position = 1;
      break;
    }
  case 1:
    if (!used(i, fred[i].x-fred[i].divx,     // bottomleft
	fred[i].y+1,
	fred[i].x,
	fred[i].y+fred[i].divy+1))
    {
      fred[i].posx = fred[i].x-fred[i].divx;
      fred[i].posy = fred[i].y+1;
      fred[i].position = 2;
      break;
     }
  case 2:
    if (!used(i, fred[i].x+1,                    // topright
	fred[i].y-fred[i].divy,
	fred[i].x + fred[i].divx+1,
	fred[i].y))
    {
      fred[i].posx = fred[i].x+1;
      fred[i].posy = fred[i].y-fred[i].divy;
      fred[i].position = 3;
      break;
    }
  case 3:
    if (!used(i, fred[i].x+1,               // bottomright
	fred[i].y+1,
	fred[i].x+fred[i].divx+1,
	fred[i].y+fred[i].divy+1))
    {
      fred[i].posx = fred[i].x+1;
      fred[i].posy = fred[i].y+1;
      fred[i].position = 4;
      break;
    }
    if (loop == 0)
    {
      loop++;
      goto start;
    }
  }

}

void map::run()
{
  if (count == num) return;
 // cout << "\n Running \n";
  for (int i = 0 ; i < num; i++)
  {
    if (fred[i].posx == -1)
      insert(i);
    else
      move(i);
  }
}

void map::sortorder()  // sort back to correct order
{

  int i;
  city* t = new city[num];

  for(i = 0; i < num; i++)
    t[fred[i].pos] = fred[i];

  delete[] fred;
  fred = t;

}

int main()
{
  randomize();
  cout << "\nStart Michael Nelte's Map Labelling\n\n";
  map themap("maps");

  themap.sort();                         // use secret order for insertion
  themap.count = 0;
  for (int i=0;i<20;i++)    // set the 5 to a larger number for better aprox
    themap.run();
  themap.sortorder();                    // return to orig order
  cout << "\n\n";
  return 0;
}