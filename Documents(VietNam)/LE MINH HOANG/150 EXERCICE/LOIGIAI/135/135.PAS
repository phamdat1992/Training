program Segment;
const
  InputFile  = 'SEGMENT.INP';
  OutputFile = 'SEGMENT.OUT';
type
  TLine = array[0..1023] of LongInt;
  TWLine = array[0..1023] of Word;
var
  t: array[0..59] of ^TLine;
  min: array[0..59] of ^TWLine;
  n: Word;
  L, H: Word;

procedure Sett(i: Word; Value: LongInt);
begin
  t[i shr 10]^[i and 1023] := Value;
end;

function Gett(i: Word): LongInt;
begin
  Gett := t[i shr 10]^[i and 1023];
end;

procedure Setmin(i: Word; Value: Word);
begin
  min[i shr 10]^[i and 1023] := Value;
end;

function Getmin(i: Word): Word;
begin
  Getmin := min[i shr 10]^[i and 1023];
end;

procedure Enter;
var
  f: Text;
  i, imin: Word;
  a: Integer;
  v, m: LongInt;
begin
  for i := 0 to 59 do
    begin
      new(t[i]);
      new(min[i]);
    end;
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  Sett(0, 0); Setmin(0, 0);
  m := 0; imin := 0;
  for i := 1 to n do
    begin
      Read(f, a);
      v := Gett(i - 1) + a;
      Sett(i, v);
      if v < m then
        begin
          m := v; imin := i;
        end;
      Setmin(i, imin);
    end;
  Close(f);
end;

procedure Solve;
var
  i, j: Word;
begin
  L := 0; H := 0;
  i := Getmin(n); j := n;
  repeat
    while (j > i) and (j - i > H - L) and (gett(j) <= gett(i)) do
      Dec(j);
    if j - i > H - L then
      begin
        L := i; H := j;
      end;
    if i = 0 then Break;
    i := Getmin(i - 1);
  until False;
  Inc(L);
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, L, ' ', H);
  Close(f);
end;

begin
  Enter;
  Solve;
  Result;
end.
10
-5 -2 -3 4 -6 7 -8 9 -1 -20