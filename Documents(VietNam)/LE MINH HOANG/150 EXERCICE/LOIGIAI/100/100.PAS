{$M 65520 0 655360}
program Wires;
const
  InputFile  = 'LINES.IN0';
  OutputFile = 'LINES.OUT';
  max = 5000;
var
  a, b, Length, Trace: array[0..max + 1] of Integer;
  LeftID: array[0..max + 1] of Integer;
  n, m: Integer;
  Time: LongInt absolute 0:$46C;
  Start: LongInt;

procedure Enter;
var
  f: Text;
  i: Integer;
  pos: array[0..max + 1] of Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do Read(f, a[i]);
  Readln(f);
  for i := 1 to n do Read(f, b[i]);
  Close(f);
end;

procedure Init;
var
  i: Integer;
  Pos: array[0..max + 1] of Integer;
begin
  a[0] := 0; b[0] := 0;
  a[n + 1] := n + 1; b[n + 1] := n + 1;
  for i := 0 to n + 1 do Pos[b[i]] := i;
  b := a;
  Length[0] := 1;
  for i := 0 to n + 1 do a[i] := Pos[a[i]];
  for i := 0 to n + 1 do LeftId[i] := max + max;
  LeftId[0] := 0;
  LeftId[1] := 0;
  m := 1;
end;

function Find(i, V: Integer): Integer;
var
  inf, sup, median: Integer;
begin
  inf := 0; sup := m + 1;
  repeat
    median := (inf + sup) div 2;
    if (LeftId[Median] < i) and (a[LeftId[Median]] < V) then inf := median
    else sup := median;
  until inf + 1 >= sup;
  Find := LeftId[inf];
end;

procedure Optimize;
var
  i, jmin, t: Integer;
begin
  for i := 1 to n + 1 do
    begin
      jmin := Find(i, a[i]);
      Trace[i] := jmin;
      Length[i] := Length[jmin] + 1;
      t := Length[i];
      if t > m then m := t;
      if (LeftId[t] > n) or (a[LeftId[t]] > a[i]) then
        LeftId[t] := i;
    end;
end;

procedure Result;
var
  f: Text;
  t: Integer;
  res: Integer;
  r: array[1..max] of Integer;
begin
  res := 0;
  t := Trace[n + 1];
  repeat
    Inc(res);
    r[res] := b[t];
    t := Trace[t];
  until t = 0;

  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, res);
  for t := 1 to res do Write(f, r[t], ' ');
  Close(f);
end;

begin
  Start := Time;
  Enter;
  Init;
  Optimize;
  Result;
  Writeln((Time - Start) / 18.2:1:2, ' (s)');
end.
6
2 3 1 5 6 4
3 2 5 6 1 4
