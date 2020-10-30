program All_of_Hamilton_Circuits;
const
  InputFile  = 'HAMILTON.INP';
  OutputFile = 'HAMILTON.OUT';
  max = 100;
var
  fo: Text;
  a: array[1..max, 1..max] of Boolean;	
  Free: array[1..max] of Boolean; 			
  X: array[1..max] of Integer; 				
  n: Integer;

procedure Enter;
var
  i, u, v, m: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), False); 
  ReadLn(f, n, m);
  for i := 1 to m do
    begin
      ReadLn(f, u, v);
      a[u, v] := True;		
      a[v, u] := True;		
    end;
  Close(f);
end;

procedure PrintResult;
var
  i: Integer;
begin
  for i := 1 to n do Write(fo, X[i], ' ');
  WriteLn(fo, X[1]);
end;

procedure Try(i: Integer);
var
  j: Integer;
begin
  for j := 1 to n do 									
    if Free[j] and a[x[i - 1], j] then	
      begin
        x[i] := j; 					
        if i < n then 				
          begin
            Free[j] := False; 	
            Try(i + 1);				
            Free[j] := True; 	
          end
        else 
          if a[j, X[1]] then PrintResult; 
      end;
end;

begin
  Enter;
  FillChar(Free, SizeOf(Free), True);
  x[1] := 1; Free[1] := False;		
  Assign(fo, OutputFile); Rewrite(fo);
  Try(2);											
  Close(fo);
end.
1 6
1 2
1 3
2 4
3 5
4 1
5 2