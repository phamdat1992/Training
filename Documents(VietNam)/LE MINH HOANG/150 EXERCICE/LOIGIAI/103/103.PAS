program Tourism;
const
  InputFile  = 'CIRCUIT.INP';
  OutputFile = 'CIRCUIT.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Boolean;
  Trace: array[1..max] of Integer;
  n, Start, Finish: Integer;

procedure Enter;
var
  f: Text;
  u, v: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, Start);
  while not SeekEof(f) do
    begin
      Readln(f, u, v);
      a[u, v] := True; a[v, u] := True;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[Start] := -1;
  Finish := 0;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  for v := 1 to n do
    if a[u, v] then
      begin
        a[v, u] := False;
        if Trace[v] = 0 then
          begin
            Trace[v] := u;
            Visit(v);
          end
        else
          if v = Start then Finish := u;
        if Finish <> 0 then Exit;
      end;
end;

procedure Result;
var
  f: Text;
  t: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  if Finish = 0 then Writeln(f, 'NO')
  else
    begin
      Writeln(f, 'YES');
      Write(f, Start, ' ');
      t := Finish;
      repeat
        Write(f, t, ' ');
        t := Trace[t];
      until t = -1;
    end;
  Close(f);
end;

begin
  Enter;
  Init;
  Visit(Start);
  Result;
end.
7 1
1 2
2 3
3 4
1 5
5 6
6 7
