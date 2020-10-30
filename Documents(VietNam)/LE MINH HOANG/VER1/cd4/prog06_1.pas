program Euler_Circuit;
const
  max = 100;
var
  a: array[1..max, 1..max] of Integer;
  n: Integer;

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
begin
  Current := 1;
  Write(1:5);
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
        Write(Next:5);
        Inc(count);
        if count mod 16 = 0 then Writeln;
        Current := Next;
      end;
  until Next = 0;
  Writeln;
end;

begin
  Assign(Input, 'EULER.INP'); Reset(Input);
  Assign(Output, 'EULER.OUT'); Rewrite(Output);
  Enter;
  FindEulerCircuit;
  Close(Input);
  Close(Output);
end.
