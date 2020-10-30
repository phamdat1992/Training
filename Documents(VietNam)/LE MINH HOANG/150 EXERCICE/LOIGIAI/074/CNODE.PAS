{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
{uses ctest074;}
const
  fi = 'cnode.inp';
  fo = 'cnode.out';
var
  ke: array[1..20000] of Integer;
  c, number, w, con: array[0..1000] of Integer;
  Ok: array[1..1000] of Boolean;
  n, m, Count, sl: Integer;
  f: Text;

procedure ReadFile;
var
  i, u, v: Integer;
begin
  Assign(f, fi); Reset(f);
  Readln(f, n, m);
  FillChar(c, SizeOf(c), 0);
  for i := 1 to m do
  begin
    Readln(f, u, v);
    Inc(c[u]);
    Inc(c[v]);
  end;
  Close(f);
  for i := 1 to n do Inc(c[i], c[i - 1]);
  Move(c[0], c[1], n shl 1);
  Assign(f, fi); Reset(f);
  Readln(f);
  for i := 1 to m do
  begin
    Readln(f, u, v);
    Inc(c[u]);
    Ke[c[u]] := v;
    Inc(c[v]);
    Ke[c[v]] := u;
  end;
  Close(f);
end;

procedure Dfs(u: Integer);
var
  iv, v, Max: Integer;
begin
  Inc(Count);
  Number[u] := Count;
  w[u] := Count;
  Max := 0;
  for iv := c[u - 1] + 1 to c[u] do
  begin
    v := Ke[iv];
    if number[v] = 0 then
    begin
      Inc(Con[u]);
      Dfs(v);
      if w[u] > w[v] then w[u] := w[v];
      if Max < w[v] then Max := w[v];
    end
    else
      if w[u] > number[v] then w[u] := number[v];
  end; { tat ca chi vong vong trong cay goc u }
  if Max >= number[u] then
  begin
    Ok[u] := True;
    Inc(sl);
  end;
end;

procedure Process;
var
  i: Integer;
begin
  FillChar(number, SizeOf(number), 0);
  FillChar(con, SizeOf(con), 0);
  FillChar(Ok, SizeOf(Ok), False);
  Count := 0;
  sl := 0;
  for i := 1 to n do
    if number[i] = 0 then
    begin
      Dfs(i);
      if (Con[i] < 2) and Ok[i] then
      begin
        Ok[i] := False;
        Dec(sl);
      end;
    end;
end;

procedure WriteFile;
var
  i: Integer;
begin
  Assign(f, fo); Rewrite(f);
  Writeln(f, sl);
  for i := 1 to n do
    if Ok[i] then Write(f, i, ' ');
  Close(f);
end;

begin
  ReadFile;
  Process;
  WriteFile;
end.