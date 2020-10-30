program RandomTest;
type
  TLine = array[1..500] of Byte;
  PLine = ^TLine;
var
  f: Text;
  u, v, n, m, i: Integer;
  a: array[1..500] of PLine;
begin
  Randomize;
  for i := 1 to 500 do
    begin
      New(a[i]);
      FillChar(a[i]^, SizeOf(a[i]^), 0);
    end;
  Write('n = '); Readln(n);
  for u := 2 to n do {Dung cay khung loai 1}
    begin
      v := Random(u - 1) + 1;
      a[u]^[v] := 1;
      a[v]^[u] := a[u]^[v];
    end;
  m := n - 1;
  for u := 2 to n do {Dung cay khung loai 2}
    begin
      v := Random(u - 1) + 1;
      a[u]^[v] := a[u]^[v] + 2;
      a[v]^[u] := a[u]^[v];
      if a[u]^[v] = 2 then Inc(m);
    end;
  for i := 1 to 17 * n do {Them nhung canh linh tinh de loai bo}
    begin
      u := Random(n) + 1;
      v := Random(n) + 1;
      if (u <> v) and (a[u]^[v] = 0) then
        begin
          a[u]^[v] := Random(2) + 1;
          a[v]^[u] := a[u]^[v];
          Inc(m);
          if m = 10000 then Break;
        end;
    end;
  Assign(f, 'NREDUCE.IN9'); Rewrite(f);
  Writeln(f, n, ' ', m);
  for u := 1 to n do
    for v := u + 1 to n do
      if a[u]^[v] <> 0 then Writeln(f, u, ' ', v, ' ', a[u]^[v]);
  Close(f);
end.