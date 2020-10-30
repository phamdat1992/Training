program B6;
const
  InputFile  = 'TOURS.INP';
  OutputFile = 'TOURS.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Byte;
  Free: array[1..max] of Boolean;
  Trace: array[1..max] of Word;
  n: Integer;
  count: LongInt;

procedure Enter;
var
  f: Text;
  i, m, x, y: Word;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), 0);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, x, y);
      a[x, y] := 1;
      a[y, x] := 1;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Free, n, True);
  FillChar(Trace, SizeOf(Trace), 0);
  count := 0;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Free[u] := False;
  for v := 1 to n do
    if a[u, v] = 1 then
      begin
        a[v, u] := 0;
        if Free[v] then
          begin
            Trace[v] := u;
            Visit(v);
          end
        else a[u, v] := 2;
      end;
end;

procedure Solve;
var
  u, v: Integer;
begin
  for u := 1 to n do
    if Free[u] then Visit(u);
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] = 2 then Inc(Count);
end;

procedure Result;
var
  f: Text;
  u, v, x, y, nexty, c: Integer;

  procedure PrintCircuit(Start, Finish: Integer);
  var
    t, c: Integer;
  begin
    t := Start; c := 1;
    repeat
      Inc(c);
      t := Trace[t];
    until t = Finish;
    Write(f, c, ' ');
    t := Start;
    repeat
      Write(f, t, ' ');
      t := Trace[t];
    until t = Finish;
    Writeln(f, Finish);
  end;

begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Count);
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] = 2 then PrintCircuit(u, v);
  Close(f);
end;

begin
  Enter;
  Init;
  Solve;
  Result;
end.
