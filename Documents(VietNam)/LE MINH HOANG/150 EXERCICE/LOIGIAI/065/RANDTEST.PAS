{$A+,B-,D+,F-,G+,I-,L+,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 16384,0,655360}

{$IFDEF CPU87} {$E-}
{$ELSE} {$E+}
{$ENDIF}
program LStreetRandtest;
const
 InputFile  = 'STREET.INP';
 max = 4000;
 maxNum = 1E18;
type
 TNumber = Comp;
var
 LNum: array[0..max + 1] of TNumber;
 n: LongInt;

procedure Generate;
var
 i, j, a, b, c: Integer;
begin
 LNum[0] := 0; LNum[1] := 3; LNum[2] := 5; LNum[3] := 7;
 for i := 3 to max - 1 do
  begin
   LNum[i + 1] := maxNum;
   for j := 1 to i do
    begin
     if Sqr(LNum[j]) >= LNum[i + 1] then Break;
     a := 0; b := i;
     repeat
      c := (a + b) shr 1;
      if  LNum[j] * LNum[c] <= LNum[i] then a := c
      else b := c;
     until a + 1 >= b;
     if LNum[i + 1] > LNum[j] * LNum[b] then
      LNum[i + 1] := LNum[j] * LNum[b];
    end;
  end;
end;

procedure CreateFile;
var
 f: Text;
 i, j: LongInt;
 X: Comp;
begin
 Assign(f, 'STREET.INP'); Rewrite(f);
 for i := 1 to n do
  begin
   if Random(3) = 1 then
    begin
     X := 0;
     for j := 1 to 18 do X := X * 10 + Random(10);
    end
   else
    X := LNum[Random(max) + 1];
   Writeln(f, X:1:0);
  end;
 Close(f);
end;

begin
 Generate;
 Write('n = '); Readln(n);
 CreateFile;
end.
