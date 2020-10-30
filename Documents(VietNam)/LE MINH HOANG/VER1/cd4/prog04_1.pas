program Connectivity;
const
  max = 100;
var
  a: array[1..max, 1..max] of Boolean; 
  Free: array[1..max] of Boolean;
  k, u, v, n: Integer;
  Count: Integer;

procedure Enter;
var
  i, u, v, m: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Readln(n, m);
  for v := 1 to n do a[v, v] := True;
  for i := 1 to m do
    begin
      Readln(u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
end;

begin
  Assign(Input, 'GRAPH.INP'); Reset(Input);
  Assign(Output, 'GRAPH.OUT'); Rewrite(Output);
  Enter;
  for k := 1 to n do
    for u := 1 to n do
      for v := 1 to n do
        a[u, v] := a[u, v] or a[u, k] and a[k, v];
  Count := 0;
  FillChar(Free, n, True);
  for u := 1 to n do
    if Free[u] then
      begin
        Inc(Count);
        Writeln('Connected Component ', Count, ': ');
        for v := 1 to n do
          if a[u, v] then
            begin
              Write(v, ', ');
              Free[v] := False;
            end;
        Writeln;
      end;
  Close(Input);
  Close(Output);
end.
