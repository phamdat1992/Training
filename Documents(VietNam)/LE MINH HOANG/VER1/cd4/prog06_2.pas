program Euler_Circuit;
const
  max = 100;
  maxE = 20000;
var
  a: array[1..max, 1..max] of Integer;
  stack: array[1..maxE] of Integer;
  n, last: Integer;

procedure Enter;
var
  u, v, k: Integer;
begin
  FillChar(a, SizeOf(a), 0);
  Readln(n);
  while not SeekEof do
    begin
      Readln(u, v, k);
      a[u, v] := k;
      a[v, u] := k;
    end;
end;

procedure Push(v: Integer);
begin
  Inc(last);
  Stack[last] := v;
end;

function Pop: Integer;
begin
  Pop := Stack[last];
  Dec(last);
end;

function Get: Integer;
begin
  Get := Stack[last];
end;

procedure FindEulerCircuit;
var
  u, v, count: Integer;
begin
  Stack[1] := 1;
  last := 1;
  count := 0;
  while last <> 0 do
    begin
      u := Get;
      for v := 1 to n do
        if a[u, v] > 0 then
          begin
            Dec(a[u, v]); Dec(a[v, u]);
            Push(v);
            Break;
          end;
      if u = Get then
        begin
          Inc(count);
          Write(Pop:5, ' ');
          if count mod 16 = 0 then Writeln;
        end;
    end;
end;

begin
  Assign(Input, 'EULER.INP'); Reset(Input);
  Assign(Output, 'EULER.OUT'); Rewrite(Output);
  Enter;
  FindEulerCircuit;
  Close(Input);
  Close(Output);
end.
