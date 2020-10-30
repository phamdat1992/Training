const
 n = 16;
var
 x: array[1..100] of Byte;
 C: array[1..10000] of Boolean;

procedure Init;
begin
 x[1] := 1;
 FillChar(C, SizeOf(C), True);
 C[1] := False;
end;

procedure Inkq;
var
 i: Byte;
begin
 for i := 1 to n do Write(X[i],' ');
 Halt;
end;

procedure Try(i: Byte);
var
 j: Integer;
 k: Byte;
begin
 for j := X[i - 1] + 1 to 10000 do
  if C[j] then
   begin
    X[i] := j;
    if i = n then Inkq
    else
     begin
      for k := 1 to i - 1 do Cz[X[i - 1] + j] := False;
      Try(i + 1);
     end;
   end;
end;

begin
 Init;
 Try(2);
end.
