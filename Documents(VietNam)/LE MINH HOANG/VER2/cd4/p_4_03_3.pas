program Breadth_First_Search_1;
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'PATH.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  Free: array[1..max] of Boolean;		
  Trace: array[1..max] of Integer;
  Queue: array[1..max] of Integer;
  n, S, F, First, Last: Integer;
  fo: Text;

procedure Enter;		
var
  i, u, v, m: Integer;
  fi: Text;
begin
  Assign(fi, InputFile); Reset(fi);
  FillChar(a, SizeOf(a), False);
  ReadLn(fi, n, m, S, F);
  for i := 1 to m do
    begin
      ReadLn(fi, u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
  Close(fi);
end;

procedure Init;		
begin
  FillChar(Free, n, True);		
  Free[S] := False;				
  Queue[1] := S;						
  Last := 1;
  First := 1;
end;

procedure Push(V: Integer);	
begin
  Inc(Last);
  Queue[Last] := V;
end;

function Pop: Integer;			
begin
  Pop := Queue[First];
  Inc(First);
end;

procedure BFS;		
var
  u, v: Integer;
begin
  repeat
    u := Pop;							
    Write(fo, u, ', ');			
    for v := 1 to n do
      if Free[v] and a[u, v] then		
        begin
          Push(v);							
          Free[v] := False;			
          Trace[v] := u;				
        end;
  until First > Last;			
end;

procedure Result;			
begin
  WriteLn(fo);					
  WriteLn(fo, 'Path from ', S, ' to ', F, ': ');
  if Free[F] then			
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
  Init;
  BFS;
  Result;
  Close(fo);
end.
8 7 1 5
1 2
1 3
2 3
2 4
3 5
4 6
7 8