program Cards;
uses crt;
const
 InputFile  = 'CARD.INP';
 OutputFile = 'CARD.OUT';
 max = 10000;
var
 n: Integer;
 Counted: array[1..2 * max] of Boolean;
 Count: LongInt;

procedure Enter;
var
 f: Text;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 Close(f);
end;

procedure Init;
begin
 FillChar(Counted, n * SizeOf(Counted[1]), False);
end;

function USCLN(a: LongInt; b: Word): Word;
begin
 while (a <> 0) and (b <> 0) do
  if a > b then a := a mod b
  else b := b mod a;
 USCLN := a + b;
end;

procedure Calculation;
var
 i, j, c: Integer;
begin
 Count := 1;
 for i := 1 to n do
  if not Counted[i] then
   begin
    c := 0; j := i;
    repeat
     Inc(c);
     Counted[j] := True;
     if j <= n then j := j shl 1
     else j := Pred((j - n) shl 1);
    until j = i;
    Count := Count * c div USCLN(Count, c);
   end;
end;

procedure PrintResult;
var
 f: Text;
begin
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, Count);
 Close(f);
end;

begin
 Enter;
 Init;
 Calculation;
 PrintResult;
end.
