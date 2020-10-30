#include <fstream.h>
#include <iostream.h>
#include <string.h>
#include <stdlib.h>

#define EMPTY 0
#define FOOD  1
#define BODY  2
#define TOXIC 3

#define EAST  0
#define WEST  1
#define SOUTH 2
#define NORTH 3
#define DOWN  4
#define UP    5


class Toxic {
  private:
    char*** block;
    int sizex, sizey, sizez;
    int Tsizex, Tsizey, Tsizez;
    int Tstartx, Tstarty, Tstartz;

    ofstream out;
    int posx, posy, posz;
    int order[6];
    int d;
    int majordir;
    int count;
    int axisorder;
  public:
    Toxic(char* t, int);
    ~Toxic();
    int run();
    void Eat();
    int Move(int dir);
    void OppositeDir(int dir);
    void Mark();
    int Free() {return block[posx][posy][posz] == FOOD;}
    void Out();
    int ShouldEat();
    int InGood();


};

typedef char** charss;
typedef char* chars;

Toxic::Toxic(char* t, int i)
:axisorder(i)
{
  char name[50];
  char fred[100];
  itoa(i, fred, 10);
  strcpy(name, "toxic.");
  strcat(name, fred);
  ifstream in(t);
  out.open(name);
  switch (i)
  {
    case 0: in >> sizex >> sizey >> sizez; break;
    case 1: in >> sizex >> sizez >> sizey; break;
    case 2: in >> sizey >> sizex >> sizez; break;
    case 3: in >> sizey >> sizez >> sizex; break;
    case 4: in >> sizez >> sizey >> sizex; break;
    case 5: in >> sizez >> sizex >> sizey; break;
    default: return;
  }
  Tstartx = 1;
  Tstarty = 1;
  Tstartz = 1;
  Tsizex  = sizex;
  Tsizey  = ((sizey-1)/3)*3+1;
  Tsizez  = sizez;
  count = 1;


  block = new charss[sizex+2];
  for(i=0;i<sizex+2;i++)
  {
    block[i] = new chars[sizey+2];
    for(int j = 0; j < sizey+2; j++)
    {
      block[i][j] = new char [sizez+2];
      for (int k = 0; k < sizez+2; k++)
	block[i][j][k] = EMPTY;
    }
  }
  for (i = 1; i <= sizex; i++)
    for(int j = 1; j <= sizey; j++)
      for(int k = 1; k <= sizez; k++)
	block[i][j][k] = FOOD;
  for(i=0;i<6;i++)
   order[i] = i;
}

Toxic::~Toxic()
{
  for(int i=0;i<sizex+2;i++)
  {
    for(int j = 0; j < sizey+2; j++)
      delete[] block[i][j];
    delete[] block[i];
  }
  delete[] block;

}

void Toxic::Out()
{
  switch (axisorder)
  {
    case 0: out << posx << " " << posy << " " << posz; break;
    case 1: out << posx << " " << posz << " " << posy; break;
    case 2: out << posy << " " << posx << " " << posz; break;
    case 3: out << posy << " " << posz << " " << posx; break;
    case 4: out << posz << " " << posy << " " << posx; break;
    case 5: out << posz << " " << posx << " " << posy; break;
    default: return;
  }


}

void Toxic::Eat()
{
  Out();
  Mark();
  for (int d=EAST; d <= UP; d++)
  {
    if (Move(d))
    {
      if (Free())
	Mark();
    }
    OppositeDir(d);
  }
}

void Toxic::Mark()
{
  block[posx][posy][posz] = TOXIC;
}

int Toxic::Move(int dir)
{
  dir = order[dir];
  switch(dir) {
    case EAST : posx++; break;
    case SOUTH: posy++; break;
    case WEST : posx--; break;
    case NORTH: posy--; break;
    case DOWN : posz++; break;
    case UP   : posz--; break;
  };
  if (posx > sizex || posx < 1 ||
      posy > sizey || posy < 1 ||
      posz > sizez || posz < 1)
      return 0;     // Bad Move
  return 1;
}

void Toxic::OppositeDir(int dir)
{
  dir = order[dir];
  switch(dir) {
    case EAST : posx--; break;
    case SOUTH: posy--; break;
    case WEST : posx++; break;
    case NORTH: posy++; break;
    case DOWN : posz--; break;
    case UP   : posz++; break;
  };
}

int Toxic::ShouldEat()
{
  if (order[0] == EAST && posx == Tsizex-1 && order[d] == majordir) return 0;
  if (order[0] == WEST && posx == Tstartx+1 && order[d] == majordir) return 0;
  if (order[d] == DOWN && posx == Tstartx+1 && posy == Tsizey && majordir == SOUTH) return 0;
  if (order[d] == DOWN && posx == Tsizex-1 && posy == Tsizey && majordir == SOUTH) return 0;
  if (order[d] == DOWN && posx == Tstartx+1 && posy == 1 && majordir == NORTH) return 0;
  if (order[d] == DOWN && posx == Tsizex-1 && posy == 1 && majordir == NORTH) return 0;
  return 1;
}

int Toxic::InGood()
{
  if (posx > Tsizex || posx < Tstartx ||
      posy > Tsizey || posy < Tstarty ||
      posz > Tsizez || posz < Tstartz)
      return 0;     // Bad Move
  return 1;
}

int Toxic::run()
{
  majordir = SOUTH;
  int dir;
  posx = 1;
  posy = 1;
  posz = 1;
  int lastdir = 0;
  out << "E 1 1 1\nM 1 1 1";
  Mark();
  int eat=0;
  int southcount = 0;
  do
  {
    dir = -1;
    for (d=EAST; d <= UP; d++)
    {
      if (Move(d))
      {
	if (Free())
	{
	  if (dir == -1 && InGood()) dir = d;
	  else
	  {
	    if (ShouldEat())
	    {
	      if (!eat || !(order[d] == EAST || order[d] == WEST))
	      {
		out << "\nE ";
		Eat();
		count++;
	      }
	    }
	    else
	      eat = 1;
	  }
	}
      }
      OppositeDir(d);
    }
    if (dir == -1) break;
    else
    {
      for (d=EAST; d <= UP; d++)
      {
	if (Move(d))
	{
	  if (Free())
	    Mark();
	}
	OppositeDir(d);
      }
      Move(dir);
      Mark();
      count++;
      out << "\nE ";
      Out();
      out << "\nM ";
      Out();

      if (((posy == sizey && order[dir] == SOUTH) ||
	  (posy == 1 && order[dir] == NORTH))
	  &&
	  sizey%3==0 && (posx == 1 || posx == sizex))
      {
	eat = 1;
	if (order[0] != DOWN)
	{
	  int t;
	  t = order[0];
	  order[0] = order[1];
	  order[1] = t;
	  t = order[0];
	  order[0] = order[4];
	  order[4] = t;
	}
	southcount = 0;
      }
      else
      if (order[dir] == majordir)
      {
	eat = 1;
	if (order[0] != majordir)
	{
	  int t = order[0];
	  order[0] = order[1];
	  order[1] = order[2];
	  order[2] = t;
	}
	southcount++;
	if (southcount >= 3)
	{
	  int t = order[0];
	  order[0] = order[2];
	  order[2] = t;
	  eat = 0;
	  southcount = 0;
	}
      }

      if (order[dir] == DOWN)
      {
	eat = 1;
	if (order[0] != DOWN)
	{
	  int t;
	  t = order[0];
	  order[0] = order[1];
	  order[1] = t;
	  t = order[0];
	  order[0] = order[4];
	  order[4] = t;
	}
	southcount++;
	if (southcount > 3)
	{
	  int t = order[0];
	  order[0] = order[4];
	  order[4] = t;
	  eat = 0;
	  southcount = 0;
	}
      }


      if (order[dir] == DOWN && lastdir != dir)
      {
	int t = order[2];
	order[2] = order[3];
	order[3] = t;
	majordir = order[2];
      }
      lastdir = dir;
    }
  }while(1);
//  out << "\n";
  cout << "\n\nBlocks eaten: " << count  << endl;
  out.close();
  return count;
}


int main(void)
{
  int count=0;
  int maxcount=0;
  int run=0;
  int i=0;
  for(;i<6;i++)
  {
    Toxic t("toxic.dat", i);
    count = t.run();
    if (count > maxcount)
    {
      maxcount = count;
      run = i;
    }
  }
  char name[100];

  char fred[100];
  itoa(run, fred, 10);
  strcpy(name, "copy toxic.");
  strcat(name, fred);
  strcat(name, " toxic.out");
  system(name);
//  cout << name << endl;

  cout << "Best count: " << maxcount << endl;

  cout << "\n\n - - The White Knight - - & - -     Fred!     - -\n     - Kevin Dennis -         - Michael Nelte -\n";
  return 0;
}