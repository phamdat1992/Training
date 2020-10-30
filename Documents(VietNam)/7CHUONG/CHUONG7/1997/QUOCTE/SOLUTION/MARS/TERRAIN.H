

	// a structure representing a single square of land

struct spot
{
  int type;				// the terrain type
  int chosenDirection;			// the direction moved from here
};  
  


	// a class representing the entire terrain
	// a grid of square spots

class terrain
{
  int xSize, ySize;
  spot *ground;
  
public:

	// create the ground grid of a certain size

  void create(int x, int y)
  {
    xSize = x;
    ySize = y;
    ground = new spot[xSize * ySize];
  }
    
  	// set the type of a particular ground square
  
  void setGroundType(int x, int y, int type)
  {
    ground[xSize * (y - 1) + (x - 1)].type = type;
  }
  
  	// get the type of a ground square

  int getGroundType(int x, int y)
  {
    return ground[xSize * (y - 1) + (x - 1)].type;
  }  
  
  	// set the chosen direction of a sqaure
  
  void setChosenDirection(int x, int y, int direction)
  {
    ground[xSize * (y - 1) + (x - 1)].chosenDirection = direction;
  }
  
  	// get the chosen direction of a sqaure
  
  int getChosenDirection(int x, int y)
  {
    return ground[xSize * (y - 1) + (x - 1)].chosenDirection;
  }
};

