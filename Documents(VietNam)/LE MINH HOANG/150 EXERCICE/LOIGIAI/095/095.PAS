program MinimalSpending;
const
  InputFile  = 'BUY.IN0';
  OutputFile = 'BUY.OUT';
  max = 10000;
var
  a, b, Index: array[1..max] of Integer;
  n: Integer;
  m, Spending: LongInt;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 1 to n do
    begin
      Readln(f, a[i], b[i]);
      Index[i] := i;
    end;
  Close(f);
  Spending := 0;
end;

procedure Adjust(root, EndNode: Integer);
var
  k, c: Integer;
begin
  k := Index[root];
  while Root * 2 <= EndNode do
    begin
      c := Root * 2;
      if (c < EndNode) and (b[Index[c]] > b[Index[c + 1]]) then Inc(c);
      if b[Index[c]] >= b[k] then Break;
      Index[Root] := Index[c]; Root := c;
    end;
  Index[root] := k;
end;

procedure Select(var m: LongInt; shop: Integer);
var
  q: LongInt;
begin
  if m > a[shop] then q := a[shop]
  else q := m;
  a[shop] := q;
  m := m - q;
  Spending := Spending + q * b[shop];
end;

procedure HeapSort;
var
  i, j, t: Integer;
begin
  for i := n div 2 downto 1 do Adjust(i, n);
  for i := n - 1 downto 1 do
    begin
      t := Index[1]; Index[1] := Index[i + 1]; Index[i + 1] := t;
      Select(m, t);
      if m = 0 then Break;
      Adjust(1, i);
    end;
  if m <> 0 then Select(m, Index[1])
  else
    for j := 1 to i do a[Index[j]] := 0;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Spending);
  for i := 1 to n do Writeln(f, a[i]);
  Close(f);
end;

begin
  Enter;
  HeapSort;
  Result;
end.
