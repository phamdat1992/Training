program BinaryStrings;
const
  InputFile  = 'BSTR.INP';
  OutputFile = 'BSTR.OUT';
  max = 30;
var
  x: array[1..max] of Integer;
  n: Integer;
  f: Text;

procedure PrintResult; 				
var
  i: Integer;
begin
  for i := 1 to n do Write(f, x[i]);
  WriteLn(f);
end;

procedure Try(i: Integer); 			
var
  j: Integer;
begin
  for j := 0 to 1 do 						
    begin 							
      x[i] := j; 							
      if i = n then PrintResult 	
      else Try(i + 1); 					
    end;
end;

begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n);
  Close(f);
  Assign(f, OutputFile); Rewrite(f);
  Try(1);				
  Close(f);
end.
