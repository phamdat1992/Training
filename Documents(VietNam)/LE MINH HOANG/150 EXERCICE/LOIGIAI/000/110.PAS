program Cover;
const
  InputFile  = 'COVER.INP';
  OutputFile = 'COVER.OUT';
  minV = -5000;
  maxV = 5000;
type
  TArray = array[minV..maxV] of LongInt;
var
  finp: Text;
  Left, Right: ^TArray;
  Index: TArray;
  res, a, b: Integer;
  n: LongInt;

procedure Init;
var
  i: Integer;
begin
  Assign(finp, InputFile); Reset(finp);
  Readln(finp, n, a, b);
  New(Left); New(Right);
  for i := minV to maxV do
    begin
      Left^[i] := i;
      Right^[i] := i;
    end;
  FillChar(Index, SizeOf(Index), 0);
end;

procedure Solve;
var
  x, y, t: Integer;
  count: LongInt;
begin
  for count := 1 to n do
    begin
      Readln(finp, x, y);
      if Left^[y] > x then Index[y] := count;
      for t := x to y do
        begin
          if Left^[t] > x then Left^[t] := x;
          if Right^[t] < y then Right^[y] := y;
        end;
    end;
end;

procedure Result;
var
  t, r, next: Integer;
  Found: Boolean;
  f: Text;
begin
  t := a;
  res := 0;
  while t < b do
    begin
      r := t; next := 0;
      while (r <= maxV) and (Left^[r] <= t) do
        begin
          next := r; Inc(r);
        end;
      if next = 0 then
        begin
          Res := -1;
          Break;
        end;
      t := Next;
      Inc(res);
    end;
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, res);
  if res <> -1 then
    begin
      t := a;
      while t < b do
        begin
          r := t; next := 0;
          while (r <= maxV) and (Left^[r] <= t) do
            begin
              next := r; Inc(r);
            end;
          t := Next;
          Writeln(f, Index[t]);
        end;
    end;
  Close(f);
end;

begin
  Init;
  Solve;
  Close(finp);
  Result;
end.
5 1 10
1 2
3 5
1 4
7 8
5 10