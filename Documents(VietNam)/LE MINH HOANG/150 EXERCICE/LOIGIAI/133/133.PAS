program Sequence;
const
  InputFile  = 'SZERO.INP';
  OutputFile = 'SZERO.OUT';
  max = 10000;
var
  t: array[0..max] of LongInt;
  id: array[0..max] of Integer;
  n, resL, resR, res: Integer;

procedure Enter;
var
  f: Text;
  i, a: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  t[0] := 0; id[0] := 0;
  for i := 1 to n do
    begin
      Read(f, a);
      t[i] := t[i - 1] + a;
      id[i] := i;
    end;
  Close(f);
end;

function Lower(id1, id2: Integer): Boolean;
begin
  Lower := (t[id1] < t[id2]) or
           (t[id1] = t[id2]) and (id1 < id2);
end;

procedure HeapSort;
var
  i, temp: Integer;

  procedure Adjust(root, endnode: Integer);
  var
    c, k: Integer;
  begin
    k := id[root];
    while (root shl 1 + 1) <= endnode do
      begin
        c := (root shl 1 + 1);
        if (c < endnode) and Lower(id[c], id[c + 1]) then Inc(c);
        if Lower(id[c], k) then Break;
        id[root] := id[c];
        root := c;
      end;
    id[root] := k;
  end;

begin
  for i := n div 2 downto 0 do Adjust(i, n);
  for i := n - 1 downto 0 do
    begin
      temp := id[0]; id[0] := id[i + 1]; id[i + 1] := temp;
      Adjust(0, i);
    end;
end;

procedure Solve;
var
  i, j: Integer;
begin
  res := 0;
  i := 0;
  repeat
    j := i;
    while (j < n) and (t[id[j + 1]] = t[id[i]]) do Inc(j);
    if id[j] - id[i] > res then
      begin
        resL := id[i]; resR := id[j]; res := id[j] - id[i];
      end;
    i := j + 1;
  until i > n;
  Inc(resL);
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, resL, ' ', resR);
  Close(f);
end;

begin
  Enter;
  HeapSort;
  Solve;
  Result;
end.
9
2 7 5 -3 -2 4 -9 -2 -1

7
0 0 0 0 0 0 0 0