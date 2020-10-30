program CList;
const
  InputFile  = 'CLIST.IN0';
  OutputFile = 'CLIST.OUT';
  max = 10000;
var
  a, b: array[0..max - 1] of Integer;
  n, k, l, t, Pos0: LongInt;
  X: LongInt;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k, l);
  for i := 0 to n - 1 do Read(f, a[i]);
  Readln(f);
  Readln(f, X);
  Close(f);
end;

procedure Solve;
var
  i, Newi: Integer;
begin
  Pos0 := (X mod n) * ((k * (n - 1) + l) mod n) mod n;
  for i := 0 to n - 1 do
    begin
      Newi := (i + Pos0) mod n;
      b[Newi] := a[i];
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  for i := 0 to n - 1 do Write(f, b[i], ' ');
  Close(f);
end;

begin
  Enter;
  Solve;
  Result;
end.
