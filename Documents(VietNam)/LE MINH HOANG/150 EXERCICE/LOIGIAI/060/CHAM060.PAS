program DecimalTEST;
uses crt;
const
 InputFile: String = 'DECIMAL.IN';
 OutputFile = 'DECIMAL.STD';
 YourFile   = 'DECIMAL.OUT';
 ReportFile = 'BIENBAN.TXT';
var
 a, b, c: LongInt;
 fi, fo, f: Text;
 Count, p, p1: Integer;
 ch: Char;

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

procedure TestLine;
var
 c1, c2: Char;
begin
 while not SeekEoln(fo) do
  begin
   if SeekEoln(f) then
    begin
     p1 := 0; Exit;
    end;
   Read(fo, c1);
   Read(f, c2);
   if c1 <> c2 then
    begin
     p1 := 0; Exit;
    end;
  end;
 if not SeekEoln(fo) then p1 := 0
 else p1 := 1;
end;

begin
 TextAttr := 30; Clrscr;
 Writeln('                              CHAM BAI DECIMAL');
 Writeln('                              ßßßßßßßßßßßßßßßß');
 Write('                              CHAM TEST DECIMAL.IN');
 ch := Readkey; Writeln(ch);
 Writeln;
 InputFile := InputFile + ch;
 Write('Preparing...');
 Enter;
 while not Eof(fi) do
  begin
   Init;
   if a <> 0 then Solve;
   Writeln(fo);
  end;
 Close(fi);
 Close(fo);
 Writeln('Done');
 Assign(fo, OutputFile); Reset(fo);
 Assign(f, YourFile); Reset(f);
 Count := 0; p := 0;
 while not SeekEof(fo) do
  begin
   Inc(Count);
   Write('    þ Test ', Count:3, '...');
   TestLine;
   if p1 = 1 then Writeln('Correct')
   else Writeln('Wrong');
   Readln(fo);
   Readln(f);
   p := p + p1;
  end;
 Close(fo);
 Close(f);
 Writeln;
 TextAttr := 78;
 Writeln('Diem = ', p / Count:1:2);
 Assign(f, ReportFile);
 if ch = '1' then Rewrite(f) else Append(f);
 Writeln(f, 'Diem cho Test DECIMAL.IN', ch, ': ', p/Count:5:2);
 Close(f);
 if Readkey = #0 then;
 TextAttr := 7;
 Clrscr;
end.
