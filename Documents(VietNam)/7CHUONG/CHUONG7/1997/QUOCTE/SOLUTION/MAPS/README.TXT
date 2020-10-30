Author:   Michael Nelte
Date:     24 November 1997
Language: C++
Algorithm:

* The lables are sorted in order of smallest first.
* Each lable in the above order is inserted one after the other
  if it can be in one of the 4 positions possible.
* Once all the lables that can be inserted this way have been then
  the lables that are already in get shifted arround if they can be.
  This might open gaps into which uninserted lables are placed.

There are two versions of maps (maps1 and maps2). This is because many
contestants used the sample solution in their programming directory to
determine direction, and this sample was wrong. One version corresponds to
the problem description and the other to the sample solution.
