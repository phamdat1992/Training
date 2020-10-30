JJ Combrink

Image solution algorithm

PROCEDURE Compare
{
 LOOP font from character 1 thru 27
 {
  LOOP through all possible ommitions or duplications of character (41)
  {
   compare the mutated character to the data at position on screen and
   count the number of differences
  }
 CHAR=character with least number of difference
}

{
 Set screen offset to zero
 RUN Compare
 OUTPUT CHAR

 LOOP until end of screen
 {
  Increment screen offset by 19
  LOOP from 1 to 3
  {
   RUN Compare
   Increment screen offset by 1
   OUTPUT the CHAR with least number of differences
  }
 }
}
