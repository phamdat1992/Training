program MileStones;
const
  InputFile  = 'MSTONE.INP';
  OutputFile = 'MSTONE.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Boolean;
  Free: array[1..max] of Boolean;
  n: Integer;
  fOut: Text;

procedure Enter;
var
  f: Text;
  i, u, v, m: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a[u, v] := True; a[v, u] := True;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Free, SizeOf(Free), True);
  Assign(fOut, OutputFile); Rewrite(FOut);
  Write(fOut, '1 ');
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Free[u] := False;
  for v := 1 to n do
    if a[u, v] then
      begin
        a[v, u] := False;
        Write(fOut, v, ' ');
        if Free[v] then Visit(v);
        Write(fOut, u, ' ');
      end;
end;

begin
  Enter;
  Init;
  Visit(1);
  Close(fOut);
end.
