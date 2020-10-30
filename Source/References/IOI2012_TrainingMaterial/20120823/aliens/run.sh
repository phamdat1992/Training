#!/bin/bash
g++ grader.cpp -g -o grader
ok=0;
for ((c = 1; c <= 24; c++)) do
  echo Test $c:
  timeout 5s ./grader < $c.in
  if diff -w log grader.expect > /dev/null; then let "ok = ok + 1";
  else let "ok = ok + 0";  fi
  rm -rf log
done
echo "Correct tests: $ok/24"
