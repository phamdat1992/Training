program Euler_Circuit;
const
  InputFile  = 'EULER.INP';
  OutputFile = 'EULER.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Integer;
  n: Integer;

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

function CanGoBack(x, y: Integer): Boolean;
var
  Queue: array[1..max] of Integer;
  First, Last: Integer;
  u, v: Integer;
  Free: array[1..max] of Boolean;
begin
  Dec(a[x, y]); Dec(a[y, x]);
  FillChar(Free, n, True);
  Free[y] := False;
  First := 1; Last := 1;
  Queue[1] := y;
  repeat
    u := Queue[First]; Inc(First);
    for v := 1 to n do
      if Free[v] and (a[u, v] > 0) then
        begin
          Inc(Last);
          Queue[Last] := v;
          Free[v] := False;
          if Free[x] then Break;
        end;
  until First > Last;
  CanGoBack := not Free[x]; 
  Inc(a[x, y]); Inc(a[y, x]); 
end;

procedure FindEulerCircuit; 
var
  Current, Next, v, count: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Current := 1;
  Write(f, 1, ' '); 
  count := 1;
  repeat
    Next := 0;
    for v := 1 to n do
      if a[Current, v] > 0 then
        begin
          Next := v;
          if CanGoBack(Current, Next) then Break;
        end;
    if Next <> 0 then
      begin
        Dec(a[Current, Next]);
        Dec(a[Next, Current]);
        Write(f, Next, ' ');
        Inc(count);
        if count mod 16 = 0 then WriteLn;
        Current := Next;
      end;
  until Next = 0;
  Close(f);
end;

begin
  Enter;
  FindEulerCircuit;
end.
5
1 2 1
1 3 2
1 4 1
2 3 1
3 4 1