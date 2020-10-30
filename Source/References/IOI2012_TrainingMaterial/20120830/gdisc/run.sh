#!/bin/bash
g++ grader.cpp -g -o grader
for ((c = 1; c <= 12; c++)) do
  echo Test $c:
  timeout 5s ./grader < $c.in > $c.out
done

g++ scoring.cpp -g -o scoring
./scoring
rm -rf grader

for ((c = 1; c <= 12; c++)) do
rm -rf $c.out
done
