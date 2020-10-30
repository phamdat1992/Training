program DQ;
var
 n, m: Integer;
 x: array[1..40] of Byte;
 t: array[0..40] of Word;
 v: array[1..40] of Word;
 Count: LongInt;

procedure Init;
var
 i: Integer;
begin
 for i := 1 to 20 do v[i] := Sqr(i);
 t[0] := 0;
 Count := 0;
end;

procedure Inkq;
var
 i: Byte;
begin
 Inc(Count);
{ write(Count:4,':');
 for i := 1 to 20 do
  if x[i] <> 0 then Write(X[i], 'x', V[i], ' + ');
 Writeln;}
end;

procedure Try(i: Byte);
var
 j: Byte;
begin
 for j := 0 to (n - T[i - 1]) div v[i] do
  begin
   T[i] := T[i - 1] + j * v[i];
   x[i] := j;
   if i < m then Try(i + 1)
   else
     if T[i] = n then Inkq;
  end;
end;

begin
 m := 20;
 n := 222;
 init;
 Try(1);
 Writeln(Count);
end.
