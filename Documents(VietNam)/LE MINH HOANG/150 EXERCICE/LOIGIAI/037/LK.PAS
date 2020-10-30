{$R+}
program Cards_Insertion;
uses crt;
const
 InputFile  = 'CARD.INP';
 OutputFile = 'CARD.OUT';
 Limit = 1000000000;
var
 i, n, m: Word;
 Result: LongInt;
 f: Text;

procedure Enter;
var
 f: Text;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 m := n * 2;
 Close(f);
end;

function USCLN(a: LongInt; b: Word): Word;
begin
 while (a <> 0) and (b <> 0) do
  if a > b then a := a mod b
  else b := b mod a;
 USCLN := a + b;
end;

function BSCNN(a: LongInt; b: Word): LongInt;
var
 r: Real;
begin
 r := a / USCLN(a, b) * b;
 if r > Limit then BSCNN := -1
 else BSCNN := Round(r);
end;

procedure Process;
var
 i, j: Word;
 StepCount: Word;
begin
 Result := 1;
 for i := 1 to m do
  begin
   StepCount := 0;
   j := i;
   repeat
    if j <= n then j := j shl 1
    else j := (j - n) shl 1 - 1;
    Inc(StepCount);
   until j = i;
   Result := BSCNN(Result, StepCount);
   if Result = -1 then Break;
  end;
end;

procedure PrintResult;
begin
 Write(f, n:11, ' ');
 if Result = -1 then Writeln(f, '>1000000000')
 else Writeln(f, Result:11);
end;

begin
 Assign(f, OutputFile); Rewrite(f);
 Randomize;
 for i := 1 to 1000 do
  begin
   n := Random(9999) + 2;
   m := 2 * n;
   Writeln(n);
   Process;
   PrintResult;
   if keypressed then Break;
  end;
 Close(f);
end.
9875
999
