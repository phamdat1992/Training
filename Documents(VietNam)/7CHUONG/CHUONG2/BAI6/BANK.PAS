program bank; { 3.4, BOI'97 }
  var f : text; { input/output file }
      p : array [1..10000] of integer; { permutation }
      n,        { number of divisions }
      l,        { number of days }
      i : integer;
begin
  { read in the permutation }
  assign (f, 'nh4.dat');
  reset (f);
  readln (f, n);
  for i := 1 to n do
    readln (f, p[i]);
  close (f);
  { assume that no transfer is needed }
  l := 0;
  for i := 1 to n do
    if p[i] <> i then
       { transfer is needed - check the length of the cycle }
       if (p[p[i]] = i) and (l <> 2)
          then l := 1
          else l := 2;
  { write out the result }
  assign (f, 'BOC.OUT');
  rewrite (f);
  writeln (f, l);
  close (f)
end.

