program InternationalWomenDayTest;
uses crt, visual;
const
 InputFile: String  = 'FLOWERS.IN';
 OutputFile = 'FLOWERS.OUT';
 max = 200;
var
 a: array[1..max, 1..max] of Boolean;
 Numbering, Low, cCount: array[1..max] of Integer;
 n, count, nFlowers, FoundHead: Integer;
 f: Text;
 ch: Char;

procedure Enter;
var
 f: Text;
 u, v: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 FillChar(a, SizeOf(a), False);
 while not SeekEof(f) do
  begin
   Readln(f, u, v);
   a[u, v] := True;
  end;
 Close(f);
end;

procedure Init;
begin
 FillChar(Numbering, SizeOf(Numbering), 0);
 count := 0;
end;

function Min(a, b: Integer): Integer;
begin
 if a < b then Min := a else Min := b;
end;

procedure Visit(u: Integer);
var
 v: Integer;
begin
 Inc(Count);
 Numbering[u] := Count; Low[u] := Numbering[u];
 CCount[u] := 1;
 for v := 1 to n do
  if a[u, v] then
   if Numbering[v] <> 0 then Low[u] := Min(Low[u], Numbering[v])
   else
    begin
     Visit(v);
     Low[u] := Min(Low[u], Low[v]);
     CCount[u] := CCount[u] + CCount[v];
    end;
end;

procedure Solve;
var
 u : Integer;
begin
 for u := 1 to n do
  if Numbering[u] = 0 then Visit(u);
 nFlowers := maxInt;
 for u := 1 to n do
  if (Low[u] = Numbering[u]) and (CCount[u] < nFlowers) then
   begin
    nFlowers := CCount[u];
    FoundHead := u;
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
 Assign(f, 'POINT.PNT'); Rewrite(f);
 Write(f, p);
 Close(f);
end;

function ReadP: Integer;
var
 f: file of Integer;
 P: Integer;
begin
 Assign(f, 'POINT.PNT'); Reset(f);
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
 Visual.Color := 30;
 MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
 Visual.Color := 47;
 MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
 WriteP(ReadP + 1);
 ShowP;
 if ReadP = 10 then
  Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
 Halt;
end;

procedure Wrong;
begin
 Visual.Color := 78;
 MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
 ShowP;
 Halt;
end;

procedure AskTest;
begin
 Caption('Bµi 089: "International women''s day"');
 MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: FLOWERS.IN  '#8#8);
 ch := ReadKey;
 Write(ch);
 if ch = '1' then WriteP(0);
 if ch = #13 then
  begin
   MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ:  '#8#8);
   Write(ReadP);
   Halt;
  end;
 InputFile := InputFile + ch;
end;

procedure DFS(u: Integer);
var
 v: Integer;
begin
 Numbering[u] := 1;
 for v := 1 to n do
  if (Numbering[v] = 0) and a[u, v] then DFS(v);
end;

procedure Test;
var
 i, S, j: Integer;
 Selected: set of Byte;
begin
 Caption('ChÊm bµi: "International women''s day"');
 Visual.Color := 159;
 FlatFrame(3, 7, 78, 23, 'KiÓm tra');
 Assign(f, OutputFile); Reset(f);
 Readln(f, S);
 Writeln('. Dßng 1: ');
 Writeln('   + §¸p ¸n  : ', nFlowers);
 Writeln('   + Häc sinh: ', S);
 if S > nFlowers then
  begin
   Writeln('KÕt qu¶ sai!');
   Wrong;
  end
 else
  if S < nFlowers then Writeln('Tèt h¬n ®¸p ¸n!')
  else Writeln('Tåi nh­ ®¸p ¸n!');
 Write('. C¸c lo¹i hoa ®­îc chän: ');
 Selected := [];
 for i := 1 to S do
  begin
   Read(f, j); Write(j, ', ');
   if (j < 1) or (j > n) then
    begin
     Writeln;
     Writeln('Sai khu«n d¹ng d÷ liÖu');
     Wrong;
    end;
   Include(Selected, (j));
  end;
 Writeln;
 FillChar(Numbering, SizeOf(Numbering), 0);
 for i := 1 to n do
  if (i in Selected) and (Numbering[i] = 0) then DFS(i);
 for i := 1 to n do
  if (Numbering[i] <> 0) and not (i in Selected) then
   begin
    Writeln('Lçi!, ph¶i chän thªm lo¹i hoa ', i);
    Wrong;
   end;
 Writeln('KÕt qu¶ ®óng ®¾n');
 Correct;
end;

begin
 AskTest;
 Enter;
 Init;
 Solve;
 Test;
end.
12
1 2
1 3
1 4
2 10
3 8
3 10
4 5
5 6
6 7
7 4
8 9
9 3
10 11
11 12
12 2
12 10
