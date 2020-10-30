program ViterbiAlgorithm;
const
  InputFile  = 'VITERBI.IN0';
  OutputFile = 'VITERBI.OUT';
  max = 200;
type
  TBoard = array[1..max, 1..max] of Byte;
var
  a, b: ^TBoard;
  Trace: TBoard;
  Line: array[1..2, 1..max] of Word;
  Min: Word;
  ArgMin, n, m, T: Integer;
  O: array[1..max] of Integer;

procedure Enter;
var
  f: Text;
  i, j, v, k: Integer;
begin
  New(a); New(b);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m, T);
  for k := 1 to T do Read(f, O[k]);
  Readln(f);
  for i := 1 to n do
    begin
      for j := 1 to n do Read(f, a^[i, j]);
      Readln(f);
    end;
  for i := 1 to n do
    begin
      for v := 1 to m do Read(f, b^[i, v]);
      Readln(f);
    end;
  Close(f);
end;

procedure Optimize;
var
  k, i, j, x, y: Integer;
begin
  for i := 1 to n do Line[1, i] := b^[i, O[1]];  {Init}
  x := 1; y := 2;
  for k := 2 to T do {Dynamic Optimization}
    begin
      for j := 1 to n do
        begin
          Line[y, j] := $FFFF;
          for i := 1 to n do
            if Line[y, j] > Line[x, i] + a^[i, j] + b^[j, O[k]] then
              begin
                Line[y, j] := Line[x, i] + a^[i, j] + b^[j, O[k]];
                Trace[k, j] := i;
              end;
        end;
      x := 3 - x; y := 3 - y;
    end;
  Min := $FFFF;
  for i := 1 to n do
    if Line[x, i] < Min then
      begin
        Min := Line[x, i];
        ArgMin := i;
      end;
end;

procedure Result;
var
  f: Text;
  q: array[1..max] of Integer;
  k: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Min);
  q[T] := ArgMin;
  for k := T - 1 downto 1 do q[k] := Trace[k + 1, q[k + 1]];
  for k := 1 to T do Write(f, q[k], ' ');
  Close(f);
end;

begin
  Enter;
  Optimize;
  Result;
end.

3 4 8
1 2 3 4 1 2 3 4
0 9 1
1 0 9
9 1 0
8 8 1 5
8 1 8 8
1 8 8 8
