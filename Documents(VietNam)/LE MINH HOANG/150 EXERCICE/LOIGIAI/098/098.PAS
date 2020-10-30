program Sequence;
const
  InputFile  = 'SEQ.INP';
  OutputFile = 'SEQ.OUT';
  max = 100;
  maxV = 100;
  maxF = max * maxV + 1;
var
  a: array[1..max] of Integer;
  b, t: array[1..max, 1..maxV] of Integer;
  n: Integer;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Read(f, a[i]);
  Close(f);
end;

procedure Init;
var
  i, v: Integer;
begin
  for v := 1 to maxV do
    begin
      b[1, v] := Abs(v - a[1]);
      t[1, v] := 0;
    end;
end;

procedure Optimize;
var
  i, v, min, vmin, j: Integer;
begin
  for i := 2 to n do
    for v := 1 to maxV - n + i do
      begin
        min := maxF;
        for j := i - 1 to v - 1 do
          if b[i - 1, j] < min then
            begin
              min := b[i - 1, j];
              vmin := j;
            end;
         b[i, v] := min + Abs(v - a[i]);
         t[i, v] := vmin;
      end;
end;

procedure Trace;
var
  min, v, vmin, i, j: Integer;
  cf: Char;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  min := maxF;
  for v := 1 to maxV do
    if b[n, v] < min then
      begin
        min := b[n, v];
        vmin := v;
      end;
  Writeln(f, min);
  i := n;
  repeat
    if vmin < a[i] then cf := '-' else cf := '+';
    for j := 1 to Abs(a[i] - vmin) do Writeln(f, cf, i);
    vmin := t[i, vmin];
    Dec(i);
  until i = 0;
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  Trace;
end.
