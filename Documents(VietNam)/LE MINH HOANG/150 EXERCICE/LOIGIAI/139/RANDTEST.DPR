{$A+,B-,C+,D+,E-,F-,G+,H+,I-,J+,K-,L+,M-,N+,O+,P+,Q+,R+,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE CONSOLE}
program randtest;
var
  p, q, n, m, i, j, x, y: Integer;
  a: array[1..200, 1..200] of Char;
  f: Text;
begin
  Randomize;
  FillChar(a, SizeOf(a), '.');
  Write('p, q, n, m = '); Readln(p, q, n, m);
  for i := 1 to n do
    begin
      repeat
        x := Random(p) + 1;
        y := Random(q) + 1;
      until a[x, y] = '.';
      a[x, y] := '&';
      repeat
        x := Random(p) + 1;
        y := Random(q) + 1;
      until a[x, y] = '.';
      a[x, y] := '*';
    end;
  for i := 1 to m do
    begin
      repeat
        x := Random(p) + 1;
        y := Random(q) + 1;
      until a[x, y] = '.';
      a[x, y] := '@';
    end;
  for x := 1 to p do
    for y := 1 to q do
      if (a[x, y] = '.') and (Random(2) = 1) then a[x, y] := '%';
  Assign(f, 'HORSEMAN.IN3); Rewrite(f);
  Writeln(f, p, ' ', q);
  for i := 1 to p do
    begin
      for j := 1 to q do Write(f, a[i, j]);
      if i <> p then Writeln(f);
    end;
  Close(f);
end.

10 10
&%.%.%.%.%
&%%%%%%%%%
%.%.%.%.%@
.........@
.%%%%%%%%%
.........*
%%%%%%%%%*
*%%%%.%%%%
.%%.%%%%%%
.....@&%%%

