{$R-,Q-,I-,D-,S-}
{$M 65520, 0, 655360}
program Houses;
uses crt, Visual;
const
 InputFile: String  = 'HOUSE.IN';
 OutputFile: String = 'HOUSE.OU';
 testFile = 'HOUSE.OUT';
 dx: array[1..4] of Integer = (1, 0, 0, -1);
 dy: array[1..4] of Integer = (0, 1, -1, 0);
 max = 100;
type
 TMap = array[0..max + 1, 0..max + 1] of Integer;
 TList = record
  x, y, Head: array[1..max * max + 1] of Integer;
 end;
var
 a: TMap;
 Rotated: array[1..3] of ^TMap;
 List: array[0..3] of ^TList;
 TraceG: array[0..max * max div 2] of Integer;
 n, first, last, nG: Integer;
 nRobush: Integer;
 ch: Char;
 PMark: Pointer;

procedure Enter;
var
 i, j: Integer;
 f: Text;
begin
 FillChar(a, SizeOf(a), 0);
 Assign(f, InputFile); Reset(f);
 Readln(f, n);
 for i := 1 to n do
  begin
   for j := 1 to n do Read(f, a[i, j]);
   Readln(f);
  end;
 Close(f);
end;

procedure BFSFrom(i, j: Integer; Lab: Integer);
var
 Qx, Qy: array[1..max * max] of Integer;
 x, y, newx, newy, d: Integer;
begin
 first := 1; last := 1;
 Qx[1] := i; Qy[1] := j;
 a[i, j] := Lab;
 repeat
  x := Qx[first]; y := Qy[first];
  Inc(first);
  for d := 1 to 4 do
   begin
    newx := x + dx[d]; newy := y + dy[d];
    if a[newx, newy] = 1 then
     begin
      a[newx, newy] := Lab;
      Inc(last);
      Qx[last] := newx; Qy[last] := newy;
     end;
   end;
 until first > last;
end;

procedure GetConnectedComponents;
var
 i, j: Integer;
begin
 nG := 0;
 for i := 1 to n do
  for j := 1 to n do
   if a[i, j] = 1 then
    begin
     Inc(nG);
     BFSFrom(i, j, -nG);
    end;
 for i := 1 to n do
   for j := 1 to n do a[i, j] := -a[i, j];
end;

procedure Rotate(var a, b: TMap);
var
 i, j: Integer;
begin
 for i := 1 to n do
  for j := 1 to n do b[n + 1 - j, i] := a[i, j];
end;

procedure Convert(var map:TMap; var List: TList);
var
 minx, miny, nCell: array[1..max * max div 2] of Integer;
 i, j, k: Integer;
begin
 for k := 1 to nG do
  begin
   minX[k] := maxInt; minY[k] := maxInt;
  end;
 FillChar(nCell, SizeOf(nCell), 0);
 for i := 1 to n do
  for j := 1 to n do
   if map[i, j] <> 0 then
    begin
     k := map[i, j];
     if MinX[k] > i then MinX[k] := i;
     if MinY[k] > j then MinY[k] := j;
     Inc(nCell[k]);
    end;
 with List do
  begin
   Head[1] := 1;
   for k := 2 to nG + 1 do Head[k] := Head[k - 1] + nCell[k - 1];
  end;
 FillChar(nCell, SizeOf(nCell), 0);
 for i := 1 to n do
  for j := 1 to n do
   if map[i, j] <> 0 then
    begin
     k := map[i, j];
     with List do
      begin
       x[Head[k] + nCell[k]] := i - MinX[k] + 1;
       y[Head[k] + nCell[k]] := j - MinY[k] + 1;
       Inc(nCell[k]);
      end;
    end;
end;

procedure Init;
var
 i: Integer;
begin
 for i := 1 to 3 do  New(Rotated[i]);
 Rotate(a, Rotated[1]^);
 Rotate(Rotated[1]^, Rotated[2]^);
 Rotate(Rotated[2]^, Rotated[3]^);
 for i := 0 to 3 do
  begin
   New(List[i]);
   FillChar(List[i]^, SizeOf(List[i]^), 0);
   if i = 0 then Convert(a, List[0]^)
   else
    begin
     Convert(Rotated[i]^, List[i]^);
     Dispose(Rotated[i]);
    end;
  end;
end;

function Check(var L1: TList; k1: Integer;
               var L2: TList; k2: Integer): Boolean;
var
 n1, n2, i: Integer;
begin
 n1 := L1.Head[k1 + 1] - L1.Head[k1];
 n2 := L2.Head[k2 + 1] - L2.Head[k2];
 if n1 <> n2 then
  begin
    Check := False;
    Exit;
   end;
 for i := 0 to n1 - 1 do
  if (L1.X[L1.Head[k1] + i] <> L2.X[L2.Head[k2] + i])
     or (L1.Y[L1.Head[k1] + i] <> L2.Y[L2.Head[k2] + i]) then
   begin
    Check := False;
    Exit;
   end;
 Check := True;
end;

function Same(k1, k2: Integer): Boolean;
var
 i: Integer;
begin
 for i := 0 to 3 do
  if Check(List[0]^, k1, List[i]^, k2) then
   begin
    Same := True;
    Exit;
   end;
 Same := False;
end;

procedure Solve;
var
 k, i, j: Integer;
begin
 nRobush := 0;
 for k := 0 to nG do TraceG[k] := k;
 for i := 1 to nG do
  if TraceG[i] = i then
   begin
    Inc(nRobush);
    for j := i + 1 to nG do
     if (TraceG[j] = j) and Same(i, j) then TraceG[j] := i;
   end;
end;

procedure Result;
var
 i, j, count: Integer;
 f: Text;
begin
 count := 0;
 for i := 1 to nG do
  if TraceG[i] = i then
   begin
    Inc(Count);
    for j := i to nG do
     if TraceG[j] = i then TraceG[j] := Count;
   end;
 Assign(f, OutputFile); Rewrite(f);
 Writeln(f, nRobush);
 for i := 1 to n do
  begin
   for j := 1 to n do Write(f, TraceG[a[i, j]], ' ');
   Writeln(f);
  end;
 Close(f);
end;

procedure Halt;
begin
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
 MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
 WriteP(ReadP + 1);
 ShowP;
 if ReadP = 10 then
  Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
 Halt;
end;

procedure Wrong;
begin
 Color := 78;
 MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
 ShowP;
 Halt;
end;

procedure AskTest;
begin
 Caption('Bµi 087: R« bèt x©y nhµ');
 MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: HOUSE.IN  '#8#8);
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
 OutputFile := OutputFile + ch;
end;

procedure Test;
var
 nR, i, j: Integer;
 m1, m2: ^TMap;
 f, g: Text;
 Permute: array[0..max * max div 2] of Integer;
begin
 Caption('ChÊm bµi 087: "R« bèt x©y nhµ"');
 Visual.Color := 159;
 Frame(5, 8, 75, 23, 'KiÓm tra');
 Assign(f, OutputFile); Reset(f);
 Readln(f, nRobush);
 Assign(g, TestFile); Reset(g);
 Readln(g, nR);
 New(m1); New(m2);
 FillChar(Permute, SizeOf(Permute), 0);
 for i := 1 to n do
  begin
   for j := 1 to n do
    begin
     Read(f, m1^[i, j]);
     Read(g, m2^[i, j]);
     Permute[m1^[i, j]] := m2^[i, j];
    end;
   Readln(f); Readln(g);
  end;
 Close(f); Close(g);
 Writeln('Sè con r« bèt: ');
 Writeln('  + §¸p ¸n:   ', nRobush);
 Writeln('  + Häc sinh: ', nR);
 if nR > nRobush then
  begin
   Writeln('KÕt qu¶ sai!');
   Wrong;
  end
 else
  if nR < nRobush then Writeln('Tèt h¬n ®¸p ¸n!')
  else Writeln('Tåi nh­ ®¸p ¸n!');
 Writeln;
 for i := 1 to n do
  for j := 1 to n do
   if Permute[m1^[i, j]] <> m2^[i, j] then
    begin
     Writeln('G¸n nh·n sai!');
     Wrong;
    end;
 Writeln('PhÐp g¸n nh·n ®óng ®¾n!');
 Correct;
end;

begin
 AskTest;
 Mark(PMark);
 Enter;
 GetConnectedComponents;
 Init;
 Solve;
 Result;
 Release(PMark);
 Test;
end.
