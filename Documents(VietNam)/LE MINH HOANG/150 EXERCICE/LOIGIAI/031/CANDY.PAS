program Candy;
const
 InputFile  = 'CANDY.INP';
 OutputFile = 'CANDY.OUT';
 max = 200;
var
 A: array[1..max] of Byte;
 B: array[0..max * max div 2] of Byte;
 n: Byte;
 Sum, HalfSum: Word;

procedure Enter;
var
 f: Text;
 i: Byte;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do Readln(f, A[i]);
 Close(f);
end;

procedure Init;
var
 i: Integer;
begin
 Sum := 0;
 for i := 1 to n do Sum := Sum + A[i];
 HalfSum := Sum div 2;
 B[0] := 0;
 FillChar(B[1], HalfSum, $FF);
end;

procedure Process;
var
 i: Byte;
 t: Word;
begin
 for t := 1 to HalfSum do
  for i := 1 to n do
   if (A[i] <= t) and (B[t - A[i]] < i) then
    begin
     B[t] := i;
     Break;
    end;
end;

procedure Result;
var
 t, c1: Word;
 m1, i: Byte;
 f: Text;
begin
 c1 := HalfSum;
 while B[c1] = $FF do Dec(c1);
 m1 := 0;
 t := c1;
 while t <> 0 do
  begin
   Inc(m1);
   i := B[t];
   t := t - A[i];
   A[i] := 0;
  end;
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, m1, ' ', c1);
 for i := 1 to n do
  if A[i] = 0 then Writeln(f, i);
 Writeln(f, n - m1, ' ', Sum - c1);
 for i := 1 to n do
  if A[i] <> 0 then Writeln(f, i);
 Close(f);
end;

begin
 Enter;
 Init;
 Process;
 Result;
end.
