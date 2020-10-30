program PermuteStr;
const
  InputFile  = 'PERMUTE.INP';
  OutputFile = 'PERMUTE.OUT';
type
  Str10 = String[11];
var
  x: Str10;
  n: Integer;
  fout: Text;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, x);
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
  V: Char;
  Count, C: array['A'..'Z'] of Integer;
  y: Str10;
  S: LongInt;
begin
  n := Length(x);
  FillChar(Count, SizeOf(Count), 0);
  for i := 1 to n do Inc(Count[x[i]]);
  C := Count;
  for V := 'B' to 'Z' do Count[V] := Count[Pred(V)] + Count[V];
  y[0] := x[0];
  for i := 1 to n do
    begin
      V := x[i];
      y[Count[V]] := x[i];
      Dec(Count[V]);
    end;
  x := y;
  Assign(fout, OutputFile); Rewrite(fout);
  S := 1;
  for i := 1 to n do S := S * i;
  for V := 'A' to 'Z' do
    for j := 2 to C[V] do S := S div j;
  Writeln(fout, S);
end;

procedure Solve;
var
  i, j, l, h: Integer;
  temp: Char;
begin
  repeat
    Writeln(fout, x);
    i := n - 1;
    while (i > 0) and (x[i] >= x[i + 1]) do Dec(i);
    if i > 0 then
      begin
        j := n;
        while x[j] <= x[i] do Dec(j);
        temp := x[i]; x[i] := x[j]; x[j] := temp;
        l := i + 1; h := n;
        while l <= h do
          begin
            temp := x[l]; x[l] := x[h]; x[h] := temp;
            Inc(l); Dec(h);
          end;
      end;
  until i = 0;
end;

begin
  Enter;
  Init;
  Solve;
  Close(fout);
end.
A
ENTER
BOOK
ABCABCABC
GGGGGGGGG
ASDFASDF
ABCDEFGHI
MISSWORLD
HGJGHJGHJ
MADAM
