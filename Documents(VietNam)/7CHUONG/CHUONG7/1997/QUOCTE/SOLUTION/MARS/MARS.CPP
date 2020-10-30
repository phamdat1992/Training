

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "terrain.h"


#define EAST 1
#define NORTH 0

#define CLEAR 0
#define ROUGH 1
#define SAMPLE 2


int numberOfVehicles;
int xMax, yMax;
terrain land;


	// read the input data file and create the terrain

void readDataFile(char *fileName)
{
  FILE *file = fopen(fileName, "r");
  if (!file)
  {
    printf("can't open input file\n");
    exit(1);
  }  
  
  fscanf(file, " %d", &numberOfVehicles);
  fscanf(file, " %d %d", &xMax, &yMax);
  land.create(xMax, yMax);
  
  for (int y = 1; y <= yMax; y++)
  {  
    for (int x = 1; x <= xMax; x++)
    {
      int groundType;
      fscanf(file, " %d", &groundType);
      land.setGroundType(x, y, groundType);
    }
  }  

  fclose(file);
}


	// finds the best path from (x, y) to the base at (xMax, yMax)
	// (in terms of total number of rock samples collected)
	// counts the sample on (x, y)
	// returns -1 if no path exists

int findBestPath(int x, int y)
{
  int thisSample;

	// calculate the value of this position
	
  switch (land.getGroundType(x, y))
  {
    case CLEAR: 
      thisSample = 0;		// no sample here
    break;
    case ROUGH:
      return -1;		// no possible route
    break;
    case SAMPLE:
      thisSample = 1;		// sample here
    break;
  }
  
  	// check for terminating condition: already at base
  
  if (x == xMax && y == yMax)
  {
    return thisSample;
  }  

	// find the best route from here
	// (can either go north or east)
	
  int northValue = -1;
  int eastValue = -1;

	// consider moving north, if we can
  	
  if (y < yMax)
  {
    northValue = findBestPath(x, y + 1);
  }  

	// consider moving east, if we can

  if (x < xMax)
  {
    eastValue = findBestPath(x + 1, y);
  }  

  	// if neither is possible, return impossible for (x, y)
	
  if (northValue == -1 && eastValue == -1)
  {
    return -1;
  }  
    
  	// choose whichever is better, north or east
	// mark which one we chose for this square
	// return the total number of samples for that route 
	// plus the sample value for this spot
	
  if (eastValue > northValue)
  {
    land.setChosenDirection(x, y, EAST);
    return thisSample + eastValue;
  }
  else
  {
    land.setChosenDirection(x, y, NORTH);
    return thisSample + northValue;
  }
}    
 

	// control the vehicles and write the output file

void writeOutputFile(char *fileName)
{
  int rover;
 
  FILE *file = fopen(fileName, "w");
  if (!file)
  {
    printf("can't open output file\n");
    exit(1);
  }  
  
	// for each rover

  for (rover = 1; rover <= numberOfVehicles; rover++)
  {
  
	// find the optimal path for this rover
	// from the start to the base, given the current
	// grid situation
	// this process marks the best path in the land array
	// so that we can follow it later
	// if we can't find any path at all then we give up

    if (findBestPath(1, 1) == -1)
    {
      break;
    }  
	
  	// follow the trail marked for this rover
	// move from (1, 1) to (xMax, yMax)
	// output to the file and mark the trail as used up
	// as we go

    int x = 1;
    int y = 1;	

    while (x != xMax || y != yMax)
    {
    
    	// mark this square as used up (now clear)
    
      land.setGroundType(x, y, CLEAR);

	// find out which direction lies along the optimal path
	// found above

		if (land.getChosenDirection(x, y) == NORTH)
		{
		  fprintf(file, "%d 0 \n", rover);
		  y++;
		}
		else
		{
		  fprintf(file, "%d 1 \n", rover);
		  x++;
      }
	 }

    	// mark the final square as used up

    land.setGroundType(x, y, CLEAR);
  }

  fclose(file);
}


	// the main routine
	// reads the input file and writes the output file
	// if an input filename is passed, it is used,
	// otherwise MARS.DAT is assumed

int main(int argc, char **argv)
{
  char fileName[100];

  strcpy(fileName, "MARS.DAT");
  if (argc >= 2)
  {
	 strcpy(fileName, argv[1]);
  }

  readDataFile(fileName);
  writeOutputFile("MARS.OUT");
  printf("\n\n - - The White Knight - - \n     - Kevin Dennis -\n");
  return 0;
}

