// CPP, Michael Nelte

#include <iostream.h>
#include <conio.h>
#include "hexcpp.h"

int max;


void display(void)
{
	int row, col, l;
	gotoxy (1, 1);
	for (row=1; row<=max; row++)
	{
		for (col=1; col<row; col++)
			cprintf (" ");
		for (col=1; col<=max; col++)
		 { l = LookAtBoard (max+1-row, col);
			textcolor (l == 0 ? 15 : l*3-2);
			cprintf ("%d ",l);
		 }
		textcolor (WHITE);
		cprintf ("\r\n");
	}
}

int x, y;

int mayuse(int x, int y)
{
  if (x < 1) return 5;
  if (y < 1) return 5;
  if (y > max) return 5;
  if (x > max) return 5;
  return LookAtBoard (x+1, y+1);
}

int connected(int x,int y)
{
  if (LookAtBoard(x, y) != 0) return 0;
  if (LookAtBoard(x+1, y+1) == 1) return 1;
  if (LookAtBoard(x+1, y) == 1) return 1;
  if (LookAtBoard(x, y+1) == 1) return 1;
  if (LookAtBoard(x-1, y) == 1) return 1;
  if (LookAtBoard(x, y-1) == 1) return 1;
  if (LookAtBoard(x-1, y-1) == 1) return 1;
  return 0;
}


PickBlock()
{
  int row, col, l;
  for(row=1;row <=max;row++)
  {
     int spot;
     if (spot%2==0)
       spot = max/2 + row/2;
     else
       spot = max/2 - row/2;

     spot = max/2+row;
     if (spot > max)
     {
       spot = max -row+1;
     }
     if (LookAtBoard(spot, spot) == 0)
     {
       x = spot;
       y = spot;
       return 0;
     }
  }

  l = connected(x+1, y+1);
  if (l)
  {
    x++;
    y++;
    return 0;
  }
  for (row=1; row<=max; row++)
  {
    for (col=1; col<=max; col++)
    { l = LookAtBoard (row, col);
      if (l == 0)
      {
	x = row;
	y = col;
	if (connected(x+1, y+1))
	{
	  x++;
	  y++;
	  return 0;
	}
      }
    }
  }

  for (row=1; row<=max; row++)
  {
    for (col=1; col<=max; col++)
    { l = LookAtBoard (row, col);
      if (l == 0)
      {
	x = row;
	y = col;
	return 0;
      }
    }
  }
  return 0;
}

int main (void)
{
  clrscr ();
  max = GetMax ();
  x=0;y=0;
  int r, c, g;
  display ();
//  getval();
  while(!GameIsOver())
  {
	 display();
	 PickBlock();
	 PutHex(x, y);
	 MakeLibMove();
  }
  display();

  return 0;
}
