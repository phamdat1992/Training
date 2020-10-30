program Depth_First_Search_3;
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'GRAPH.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Trace: array[1..max] of Integer;
  m, n, S, F: Integer;
  fo: Text;

procedure Enter;
var
  i, u, v, m: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  FillChar(a, SizeOf(a), False);
  Readln(fi, n, m, S, F);
  for i := 1 to m do
    begin
      Readln(fi, u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
  Close(fi);
end;

function FindNext(u: Integer): Integer;
var
  v: Integer;
begin
  repeat
    for v := 1 to n do
      if a[u, v] and (Trace[v] = 0) then
        begin
          Trace[v] := u;
          FindNext := v;
          Exit;
        end;
    u := Trace[u];
  until u = n + 1;
  FindNext := 0;
end;

procedure DFS;
var
  u: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[S] := n + 1;
  u := S;
  repeat
    Write(fo, u, ', ');
    u := FindNext(u);
  until u = 0;
end;

procedure Result;
begin
  WriteLn(fo);
  WriteLn(fo, 'Path from ', S, ' to ', F, ': ');
  if Trace[F] = 0 then
    WriteLn(fo,'not found')
  else
    begin
      while F <> S do
        begin
          Write(fo, F, '<-');
          F := Trace[F];
        end;
      WriteLn(fo, S);
    end;
end;

begin
  Enter;
  Assign(fo, OutputFile); Rewrite(fo);
  Writeln(fo, 'From ', S, ' you can visit: ');
  DFS;
  Result;
  Close(fo);
end.
