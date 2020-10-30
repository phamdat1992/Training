program Euler_Circuit;
const
  InputFile  = 'EULER.INP';
  OutputFile = 'EULER.OUT';
  max = 100;
  maxE = 20000;		
var
  a: array[1..max, 1..max] of Integer;
  stack: array[1..maxE] of Integer;
  n, last: Integer;

procedure Enter;		
var
  u, v, k: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), 0);
  ReadLn(f, n);
  while not SeekEof(f) do
    begin
      ReadLn(f, u, v, k);
      a[u, v] := k;
      a[v, u] := k;
    end;
  Close(f);
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
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
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
          Write(f, Pop, ' ');		
        end;
    end;
  Close(f);
end;

begin
  Enter;
  FindEulerCircuit;
end.
