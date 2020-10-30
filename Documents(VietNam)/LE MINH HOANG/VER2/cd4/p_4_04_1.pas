program Connectivity;
const
  InputFile  = 'GRAPH.INP';
  OutputFile = 'CONNECT.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Boolean; 	
  Free: array[1..max] of Boolean;			
  k, u, v, n: Integer;
  Count: Integer;
  fo: Text;

procedure Enter;							
var
  i, u, v, m: Integer;
  fi: Text;
begin
  FillChar(a, SizeOf(a), False);
  Assign(fi, InputFile); Reset(fi);
  ReadLn(fi, n, m);
  for v := 1 to n do a[v, v] := True;	
  for i := 1 to m do
    begin
      ReadLn(fi, u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
  Close(fi);
end;

begin
  Enter;
  
  for k := 1 to n do
    for u := 1 to n do
      for v := 1 to n do
        a[u, v] := a[u, v] or a[u, k] and a[k, v];
  Assign(fo, OutputFile); Rewrite(fo);
  Count := 0;
  FillChar(Free, n, True);		
  for u := 1 to n do
    if Free[u] then		
      begin
        Inc(Count);
        WriteLn(fo, 'Connected Component ', Count, ': ');
        for v := 1 to n do	
          if a[u, v] then				
            begin
              Write(fo, v, ', ');		
              Free[v] := False;	
            end;
        WriteLn(fo);
      end;
  Close(fo);
end.
12 9
1 3
1 4
1 5
2 4
6 7
6 8
9 10
9 11
11 12