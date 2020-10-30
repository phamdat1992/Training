Var
 m,n,i,j,i1,j1:integer;
 f:Text;
 a,b:array[0..121,0..121] of byte;
Begin
 Writeln('Random Test');
 randomize;
{ write('M,n = ');readln(m,n);}
 m := 6; n := 5;
 fillchar(a,sizeof(a),0);
 for i:=1 to m do
  for j:=1 to n do
   begin
    a[i,j]:=random(2);
    if (i = 1) and (random(3) <> 1) then a[i, j] := 1;
   end;
 for i:=1 to m do
  for j:=1 to n do
   Begin
     b[i,j]:=0;
     for i1:=i-1 to i+1 do
      for j1:=j-1 to j+1 do
       if (i1<>i) or (j1<>j) then b[i,j]:=b[i,j]+A[i1,j1];
   end;
 Assign(f,'MINE.INP');rewrite(f);
 writeln(f,m,' ',n);
 for i:=1 to m do
  begin
   for j:=1 to n do write(f,b[i,j],' ');
   writeln(f);
  end;
 writeln(f);
 for i:=1 to m do
  begin
   for j:=1 to n do write(f,a[i,j],' ');
   writeln(f);
  end;
 Close(F);
End.
