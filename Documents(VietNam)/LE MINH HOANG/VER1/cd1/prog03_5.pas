program n_Queens;
const
  max = 12;
var
  n: Integer;
  x: array[1..max] of Integer;
  a: array[1..max] of Boolean;
  b: array[2..2 * max] of Boolean;
  c: array[1 - max..max - 1] of Boolean;

procedure Init;
begin
  Readln(n);
  FillChar(a, SizeOf(a), True);		
  FillChar(b, SizeOf(b), True);		
  FillChar(c, SizeOf(c), True);		
end;

procedure PrintResult;
var
  i: Integer;
begin
  for i := 1 to n do Write('(', i, ', ', x[i], '); ');
  Writeln;
end;

procedure Try(i: Integer); 
var
  j: Integer;
begin
  for j := 1 to n do
    if a[j] and b[i + j] and c[i - j] then 
      begin
        x[i] := j; 				
        if i = n then PrintResult
        else
          begin
            a[j] := False; b[i + j] := False; c[i - j] := False;
            Try(i + 1);			
            a[j] := True; b[i + j] := True; c[i - j] := True;		
          end;
      end;
end;

begin
  Assign(Input, 'QUEENS.INP'); Reset(Input);
  Assign(Output, 'QUEENS.OUT'); Rewrite(Output);
  Init;
  Try(1);
  Close(Input); Close(Output);
end.

