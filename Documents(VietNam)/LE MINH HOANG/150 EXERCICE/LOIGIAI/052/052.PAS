program Bai1;
const
  InputFile  = 'NUMBER.INP';
  OutputFile = 'NUMBER.OUT';
  max = 32;
var
  res, n, k: LongInt;
  c, b: array[-1..max + 1, -1..max + 1] of LongInt;
  x: array[1..max] of LongInt;
  nd: LongInt;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, k);
  Close(f);
end;

procedure Initc;
var
  i, j: LongInt;
begin
  FillChar(c, SizeOf(c), 0);
  c[0, 0] := 1;
  for i := 1 to max do
    for j := 0 to max do
       c[i, j] := c[i - 1, j] + c[i - 1, j - 1];
end;

procedure Initb;
var
  i, j: LongInt;
begin
  FillChar(b, SizeOf(b), 0);
  b[0, 0] := 1;
  b[1, 0] := 1; b[1, 1] := 1;
  for i := 1 to max do
    for j := 0 to max do
      if b[i, j] = 0 then
        b[i, j] := b[i - 1, j] + c[i - 1, j];
end;

procedure InterChange;
var
  m, i: LongInt;
begin
  i := 0;
  m := n;
  repeat
    Inc(i);
    x[i] := m and 1;
    m := m shr 1;
  until m = 0;
  nd := i;
end;

procedure Solve;
var
  i, e, t: LongInt;
begin
  if (k > nd) or (k < 0) then
    begin
      res := 0; Exit;
    end;
  res := b[nd - 1, k];
  e := k;
  for i := nd - 1 downto 1 do
    begin
      if x[i] = 1 then res := res + c[i - 1, e - 1]
      else Dec(e);
      if e < 0 then Break;
    end;
end;

procedure Refine;
var
  c: LongInt;
begin
  c := 0;
  repeat
    if not odd(n) then Inc(c);
    n := n shr 1;
  until n = 0;
  if c = k then Inc(Res);
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Res);
  Close(f);
end;

begin
  Enter;
  InitC;
  InitB;
  InterChange;
  Solve;
  Refine;
  Result;
end.