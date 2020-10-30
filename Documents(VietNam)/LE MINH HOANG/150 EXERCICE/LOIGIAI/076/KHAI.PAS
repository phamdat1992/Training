{$A+,B-,D+,E+,F+,G-,I+,L+,N+,O+,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program Test;
const
   InputFile = 'GUEST.INP';
   n = 1000;
var
   Boss : array[1..n] of Integer;
   Free : array[1..n] of Boolean;

 procedure Init;
 var
   i,j1,j2,k : Integer;
 begin
   FillChar(Boss , SizeOf(Boss) , 0);
   FillChar(Free , SizeOf(Free) , True);
   k := Random(n-2)+3;
   Free[k] := False;
   for i := 1 to n-1 do
    begin
      k := Random(n-i) + 1;
      j1 := 0;
      repeat
        Inc(j1);
        while not Free[j1] do Inc(j1);
        Dec(k);
      until k = 0;
      k := Random(i)+1;
      j2 := 0;
      repeat
        Inc(j2);
        while Free[j2] do Inc(j2);
        Dec(k);
      until k = 0;
      Boss[j1] := j2;
      Free[j1] := False;
    end;
 end;

var
  f : Text;
  i : Integer;

begin
  Init;
  Assign(f , InputFile);
  Rewrite(f);
  Writeln(f , n);
  for i := 1 to n do
   Writeln(f , Boss[i] ,  ' ' , Random(1000)+1);
  Close(f);
end.