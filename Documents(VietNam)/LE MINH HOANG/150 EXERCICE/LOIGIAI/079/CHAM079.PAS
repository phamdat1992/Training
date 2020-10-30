{$R-,Q-,S-,D-,I-}
program AssignmentProblemTest;
uses Crt, Visual;
const
 InputFile: String = 'ASSIGN.IN';
 OutputFile = 'ASSIGN.OUT';
 max = 200;
 maxLong = 1000000001;
type
 TLine = array[1..max] of LongInt;
var
 c: array[1..max] of ^TLine;
 Trace, Queue, matchX, matchY: array[1..max] of Integer;
 Fx, Fy: array[1..max] of Comp;
 VisitedX, VisitedY: array[1..max] of Boolean;
 First, Last, n: Integer;
 GoOut: Boolean;
 Ch: Char;
 S: Extended;
 f: Text;
 p: Integer;

procedure Enter;
var
 f: Text;
 x, y: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for x := 1 to n do New(c[x]);
 for x := 1 to n do
  for y := 1 to n do c[x]^[y] := -1;
 while not SeekEof(f) do
  begin
   Readln(f, x, y, c[x]^[y]);
  end;
 Close(f);
end;


procedure Init;
var
 i, j: Integer;
begin
 FillChar(matchX, SizeOf(matchX), 0);
 FillChar(matchY, SizeOf(matchY), 0);
 for i := 1 to n do
  begin
   Fx[i] := maxLong;
   for j := 1 to n do
    if (c[i]^[j] <> -1) and (Fx[i] > c[i]^[j]) then Fx[i] := c[i]^[j];
  end;
 for j := 1 to n do
  begin
   Fy[j] := maxLong;
   for i := 1 to n do
    if (c[i]^[j] <> -1) and (Fy[j] > c[i]^[j] - Fx[i]) then
       Fy[j] := c[i]^[j] - Fx[i];
  end;
 GoOut := False;
end;

function FindAugmentingPath(XStart: Integer): Integer;
var
 x, y, nextx: Integer;
begin
 FillChar(Trace, SizeOf(Trace), 0);
 FillChar(VisitedX, SizeOf(VisitedX), False);
 FillChar(VisitedY, SizeOf(VisitedY), False);
 Queue[1] := xStart; First := 1; Last := 1;
 VisitedX[xStart] := True;
 repeat
  x := Queue[First]; Inc(First);
  for y := 1 to n do
   if not VisitedY[y] and (c[x]^[y] <> -1)
      and (c[x]^[y] = Fx[x] + Fy[y]) and (matchX[x] <> y) then
     begin
      Trace[y] := x;
      if matchY[y] = 0 then
       begin
        FindAugmentingPath := y;
        Exit;
       end;
      VisitedY[y] := True;
      nextx := matchY[y];
      VisitedX[nextx] := True;
      Inc(Last); Queue[Last] := nextx;
     end;
 until First > Last;
 FindAugmentingPath := 0;
end;

procedure SubXAddY;
var
 i, j: Integer;
 Delta: Comp;
begin
 Delta := maxLong;
 for i := 1 to n do
  if VisitedX[i] then
   for j := 1 to n do
    if not VisitedY[j] and (c[i]^[j] <> -1)
       and (Delta > c[i]^[j] - Fx[i] - Fy[j]) then
           Delta := c[i]^[j] - Fx[i] - Fy[j];
 if Delta = maxLong then
  begin
   GoOut := True;
   Exit;
  end;
 for i := 1 to n do
  if VisitedX[i] then Fx[i] := Fx[i] + Delta;
 for j := 1 to n do
  if VisitedY[j] then Fy[j] := Fy[j] - Delta;
end;

procedure Enlarge(f: Integer);
var
 x, next: Integer;
begin
 repeat
  x := Trace[f];
  next := matchX[x];
  matchX[x] := f;
  matchY[f] := x;
  f := next;
 until f = 0;
end;

procedure Solve;
var
 i, k: Integer;
begin
 for i := 1 to n do
  begin
   repeat
    k := FindAugmentingPath(i);
    if k = 0 then SubXAddY;
    if GoOut then Exit;
   until k <> 0;
   Enlarge(k);
  end;
end;

procedure Result;
var
 f: Text;
 i: Integer;
begin
 if GoOut then S := -1
 else
  begin
   S := 0;
   for i := 1 to n do S := S + Fx[i] + Fy[i];
  end;
end;

procedure Halt;
begin
 {$I-}
 Close(f); if IOResult = 0 then;
 {$I+}
 ReadKey;
 TextMode(C80); Textattr := 7; Clrscr;
 System.Halt;
end;

procedure WriteP(p: Integer);
var
 f: file of Integer;
begin
 Assign(f, 'POINT.TXT'); Rewrite(f);
 Write(f, p);
 Close(f);
end;

function ReadP: Integer;
var
 f: file of Integer;
 P: Integer;
begin
 Assign(f, 'POINT.TXT'); Reset(f);
 Read(f, p);
 Close(f);
 ReadP := p;
end;

procedure ShowP;
var
 S: String;
begin
 Str(ReadP, S);
 if Length(S) < 2 then S := '0' + S;
 Color := 30;
 MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
 Color := 47;
 MSG(20, 3, InputFile, 'B¹n cã 1 ®iÓm');
 WriteP(ReadP + 1);
 ShowP;
 if ReadP = 10 then
  Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
 Halt;
end;

procedure Wrong;
begin
 Color := 78;
 MSG(20, 3, InputFile, 'B¹n cã 0 ®iÓm'#7);
 ShowP;
 Halt;
end;

procedure Test;
var
 T: Extended;
 i: Integer;
begin
 if ch = '1' then WriteP(0);
 Caption('ChÊm bµi 079: "Ph©n c«ng"');
 Color := 159;
 Frame(5, 8, 75, 22, 'KiÓm tra');
 Writeln('n = ', n);
 Assign(f, OutputFile); Reset(f);
 Readln(f, T);
 Writeln('Dßng 1:');
 Writeln('  + §¸p ¸n  : ', S:0:0);
 Writeln('  + Häc sinh: ', T:0:0);
 if Int(T) <> Int(S) then
  begin
   Writeln('Lçi');
   Wrong;
  end
 else Writeln('Tèt!');
 if Int(T) = -1 then  Correct;
 Writeln('KiÓm tra bé ghÐp: ');
 FillChar(matchX, SizeOf(matchX), 0);
 FillChar(matchY, SizeOf(matchY), 0);
 for i := 1 to n do
  begin
   Readln(f, matchX[i]);
   Writeln(' + ', 'Thî ', i:3, ' ®­îc ph©n lµm viÖc ', matchX[i] : 3);
   if (matchX[i] < 1) or (matchX[i] > n) then
    begin
     Writeln('Sai khu«n d¹ng d÷ liÖu!');
     Wrong;
    end;
   if c[i]^[matchX[i]] = -1 then
    begin
     Writeln('Lçi, kh«ng cã kh¶ n¨ng thùc hiÖn!');
     Wrong;
    end;
   T := T - c[i]^[matchX[i]];
   matchY[matchX[i]] := i;
  end;
 for i := 1 to n do
  if matchY[i] = 0 then
   begin
    Writeln('ViÖc ', i:3, ' ch­a ®­îc ph©n c«ng!');
    Wrong;
   end;
 Writeln('TÊt c¶ c¸c viÖc ®· ®­îc ph©n c«ng!');
 if Int(T) <> 0 then
  begin
   Writeln('TÝnh tæng sai!');
   Wrong;
  end
 else
  begin
   Writeln('Tèt!');
   Correct;
  end;
end;

begin
 Caption('Bµi 079: Ph©n c«ng');
 Color := 30;
 Msg(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
 Ch := ReadKey;
 if ch = #13 then
  begin
   MSG(40, 13, 'Tæng ®iÓm', 'B¹n ®ang cã   /10 ®iÓm');
   Write(#8#8#8#8#8#8#8#8#8#8, ReadP);
   Halt;
  end;
 Write(Ch);
 InputFile := InputFile + ch;
 Msg(40, 13, 'Xin chê', 'Tr×nh chÊm ®ang gi¶i...');
 Enter;
 Init;
 Solve;
 Result;
 Test;
end.
4
1 1 1
1 2 2
2 1 2
2 2 5
3 2 1
2 3 1
3 3 10
4 3 10
4 4 7
