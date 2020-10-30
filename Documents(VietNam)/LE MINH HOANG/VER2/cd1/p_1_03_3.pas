program Arrangement;
const
  InputFile  = 'ARRANGES.INP';
  OutputFile = 'ARRANGES.OUT';
  max = 20;
var
  x: array[1..max] of Integer;
  c: array[1..max] of Boolean;
  n, k: Integer;
  f: Text;

procedure PrintResult;		
var
  i: Integer;
begin
  for i := 1 to k do Write(f, x[i],' ');
  WriteLn(f);
end;

procedure Try(i: Integer); 
var
  j: Integer;
begin
  for j := 1 to n do
    if c[j] then 	
      begin
        x[i] := j;
        if i = k then PrintResult 
        else
          begin
            c[j] := False; 	
            Try(i + 1); 		
            c[j] := True; 		
          end;
      end;
end;

begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n, k);
  Assign(f, OutputFile); Rewrite(f);
  FillChar(c, SizeOf(c), True);	
  Try(1);											
  Close(f);
end.
