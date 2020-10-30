program Decimal;
const
 InputFile  = 'DECIMAL.INP';
 OutputFile = 'DECIMAL.OUT';
var
 a, b, c: LongInt;
 fi, fo: Text;

function GetDivisor(a, b: LongInt): LongInt; {USCLN (a, b)}
var
 r: LongInt;
begin
 while b <> 0 do
  begin
   r := a mod b;
   a := b; b := r;
  end;
 GetDivisor := a;
end;

procedure Enter;
begin
 Assign(fi, InputFile); Reset(fi);
 Assign(fo, OutputFile); Rewrite(fo);
end;

procedure Init;
var
 d: LongInt;
 ch: Char;
begin
 Readln(fi, a, b);
 if a / b < 0 then Write(fo, '-');
 a := Abs(a); b := Abs(b);
 Write(fo, a div b);
 d := GetDivisor(a, b);
 a := a div d; b := b div d;
 a := a mod b;
 c := 0;
end;

procedure Solve;
var
 i, P5, P2, PMax: LongInt;
 Saveb, StartT: LongInt;
begin
 Write(fo, '.');
 P5 := 0; P2 := 0;
 Saveb := b;
 while b mod 5 = 0 do
  begin
   b := b div 5; Inc(P5);
  end;
 while b mod 2 = 0 do
  begin
   b := b div 2; Inc(P2);
  end;
 if P5 > P2 then PMax := P5 else PMax := P2;
 b := Saveb;
 for i := 1 to PMax do
  begin
   a := a * 10;
   Write(fo, a div b);
   a := a mod b;
  end;
 if a = 0 then Exit;
 Write(fo, '(');
 StartT := a;
 repeat
  a := a * 10;
  Write(fo, a div b);
  a := a mod b;
  c := c + 1;
 until a = StartT;
 Write(fo, ')');
end;

begin
 Enter;
 while not Eof(fi) do
  begin
   Init;
   if a <> 0 then Solve;
   Writeln(fo);
  end;
 Close(fi);
 Close(fo);
end.
