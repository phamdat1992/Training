{$N+}
{$IFDEF CPU87} {$E-}
{$ELSE} {$E+}
{$ENDIF}
program LStreet;
const
 InputFile  = 'STREET.INP';
 OutputFile = 'STREET.OUT';
 max = 4000;
 maxNum = 1E18;
type
 TNumber = Comp;
var
 LNum: array[0..max + 1] of TNumber;
 Start: LongInt;
 Time: LongInt absolute 0:$46C;

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

procedure Print;
var
 i: Integer;
begin
 for i := 1 to max do Write(LNum[i]:20:0);
end;

procedure Solve;
var
 f, g: Text;
 a, b, c: Integer;
 V: TNumber;
begin
 Assign(f, InputFile); Reset(f);
 Assign(g, OutputFile); Rewrite(g);
 repeat
  Readln(f, V);
  a := 0; b := max + 1;
  repeat
   c := (a + b) shr 1;
   if LNum[c] = V then Break;
   if LNum[c] < V then a := c
   else b := c;
  until a + 1 >= b;
  if LNum[c] <> V then Writeln(g, 'N')
  else
   if Odd(c) then Writeln(g, 'L') else Writeln(g, 'R');
 until SeekEof(f);
 Close(f);
 Close(g);
end;

begin
 Start := Time;
 Generate;
 Solve;
 Writeln('Time = ', (Time- Start)/18.2:1:2, ' (s)');
end.
