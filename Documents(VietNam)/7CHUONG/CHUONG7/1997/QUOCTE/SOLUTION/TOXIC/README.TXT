Program: Toxic
Author: Michael Nelte and Kevin Dennis
Language: C++
Algorithm:

A 3d Array is created to represent the "fruit" which the iShongololo
is going to be eating.  This array is then initialised to all being
edible.

The iShongololo starts eating at the block 1,1,1 and then moves to
the first block eaten.   It then moves in a positive lengthwise
direction eating all adjacent blocks (horizontal and vertical)
that don't violate the rules.

On reaching a side, it calculates whether the iShongololo can turn
without violateing rules and stops eating adjacent blocks.  It will
then turn and continue this process. When no further horizonatal
blocks can be eaten, the iShongololo will move downwards 4 blocks
and and continue this pattern, noting that it also eats as many
blocks upwards and downwards and horizantally as possible, again,
leaving enough uneaten block at the corners to turn.

Once there are no further edible blocks, the programme ends.

To further optimise the solutions, the solutions are run from
3 directions, alternately taking the length, width and height
as the 'top' face for the iShongololo to use.  The best of
these is then used.





