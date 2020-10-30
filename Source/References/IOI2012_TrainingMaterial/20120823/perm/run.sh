#!/bin/bash
g++ grader50.cpp -g -o grader50
ok=50;
for ((c = 1; c <= 40; c++)) do
  echo Test $c:
  timeout 5s ./grader50 < $c.in
  if diff -w log OK50 > /dev/null; then ok=$ok; else ok=0; fi
  rm -rf log
done
echo "Subtask 1: $ok"
rm -rf grader50
sleep 2

g++ grader100.cpp -g -o grader100
ok=50;
for ((c = 1; c <= 40; c++)) do
  echo Test $c:
  timeout 5s ./grader100 < $c.in
  if diff -w log OK100 > /dev/null; then ok=$ok; else ok=0; fi
  rm -rf log
done
echo "Subtask 2: $ok"
rm -rf grader100
