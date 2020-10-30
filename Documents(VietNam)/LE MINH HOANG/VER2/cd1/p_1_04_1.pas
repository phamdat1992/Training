program TravellingSalesman;
const
  InputFile  = 'TOURISM.INP';
  OutputFile = 'TOURISM.OUT';
  max = 20;
  maxC = 20 * 100 + 1;		
var
  C: array[1..max, 1..max] of Integer; 			
  X, BestWay: array[1..max + 1] of Integer;	
  T: array[1..max + 1] of Integer; 					
  Free: array[1..max] of Boolean; 					
  m, n: Integer;
  MinSpending: Integer; 									

procedure Enter;
var
  i, j, k: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n, m);
  for i := 1 to n do 									
    for j := 1 to n do
      if i = j then C[i, j] := 0 else C[i, j] := maxC;
  for k := 1 to m do
    begin
      ReadLn(f, i, j, C[i, j]);
      C[j, i] := C[i, j]; 			
    end;
  Close(f);
end;

procedure Init; 
begin
  FillChar(Free, n, True);
  Free[1] := False; 			
  X[1] := 1; 						
  T[1] := 0; 						
  MinSpending := maxC; 		
end;

procedure Try(i: Integer); 
var
  j: Integer;
begin
  for j := 2 to n do 		
    if Free[j] then 		
      begin
        X[i] := j; 			
        T[i] := T[i - 1] + C[x[i - 1], j]; 	
        if T[i] < MinSpending then 					
          if i < n then 
            begin
              Free[j] := False; 	
              Try(i + 1); 				
              Free[j] := True; 	
            end
          else
            if T[n] + C[x[n], 1] < MinSpending then 
              begin 
                BestWay := X; 
                MinSpending := T[n] + C[x[n], 1];
              end;
      end;
end;

procedure PrintResult;
var
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  if MinSpending = maxC then WriteLn(f, 'NO SOLUTION')
  else
    for i := 1 to n do Write(f, BestWay[i], '->');
  WriteLn(f, 1);
  WriteLn(f, 'Cost: ', MinSpending);
  Close(f);
end;

begin
  Enter;
  Init;
  Try(2);
  PrintResult;
end.
