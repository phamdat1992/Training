Var
   f : text;
   n, i, j : integer;
   a : array [1..200, 1..200] of byte;

Begin
{ assign(f, 'treemax2.in8'); rewrite(f);
  n := 200;
  writeln(f, n);
  fillchar(a, sizeof(a), 0);
  randomize;

  for i := 1 to n do
      for j := i + 1 to n do
          begin
            a[i, j] := random(200);
            a[j, i] := a[i, j];
          end;

  for i := 1 to n do
      begin
        for j := 1 to n do write(f, a[i, j],' ');
        writeln(f);
      end;

  Close(f);}
  assign(f, 'Treemax2.in9'); rewrite(f);
  writeln(f, 200);
  fillchar(a, sizeof(a), 0);
  for i := 1 to 200 do
      begin
        a[1, i] := 250;
        a[i, 1] := 250;
      end;
  a[2, 3] := 249;
  a[3, 2] := 249;

  for i := 1 to 200 do
      begin
        for j := 1 to 200 do write(f, a[i, j],' ');
        writeln(f);
      end;

  Close(f);
End.