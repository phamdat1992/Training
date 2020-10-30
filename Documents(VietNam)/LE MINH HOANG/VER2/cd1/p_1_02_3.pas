program Permutation;
const
  InputFile  = 'PERMUTE.INP';
  OutputFile = 'PERMUTE.OUT';
  max = 12;
var
  n, i, k, a, b: Integer;
  x: array[1..max] of Integer;
  f: Text;

procedure Swap(var X, Y: Integer);	
var
  Temp: Integer;
begin
  Temp := X; X := Y; Y := Temp;
end;

begin
  Assign(f, InputFile); Reset(f);
  ReadLn(f, n);
  Close(f);
  Assign(f, OutputFile); Rewrite(f);
  for i := 1 to n do x[i] := i; 					
  repeat
    for i := 1 to n do Write(f, x[i], ' '); 	
    WriteLn(f);
    i := n - 1;
    while (i > 0) and (x[i] > x[i + 1]) do Dec(i);
    if i > 0 then 											
      begin
        k := n; 												
        while x[k] < x[i] do Dec(k); 			
        Swap(x[k], x[i]); 								
        a := i + 1; b := n; 							
        while a < b do
          begin
            Swap(x[a], x[b]); 						
            Inc(a); 										
            Dec(b);
          end;
      end;
  until i = 0; 
  Close(f);
end.
