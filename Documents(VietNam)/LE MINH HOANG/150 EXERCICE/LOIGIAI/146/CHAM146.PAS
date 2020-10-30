program Minimal_Spanning_Tree_by_Kruskal;
uses crt, visual;
const
  InputFile: string = 'MST.IN';
  OutputFile = 'MST.OUT';
  maxV = 10000;
  maxE = 15000;
type
  TEdge = record
    u, v, c, id: Integer;
  end;
  PEdge = ^TEdge;
  TLab = array[1..maxV] of Integer;
var
  e: array[1..maxE] of PEdge;
  Lab: ^TLab;
  n, m: Integer;
  W: LongInt;
  PMark: Pointer;
  f: Text;
  ch: Char;

procedure InitMem;
var
  i: Integer;
begin
  Mark(PMark);
  for i := 1 to maxE do New(e[i]);
  New(Lab);
end;

procedure LoadGraph;
var
  i: Integer;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, e[i]^.u, e[i]^.v, e[i]^.c);
      e[i]^.id := i;
    end;
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to n do Lab^[i] := -1;
end;

function GetRoot(v: Integer): Integer;
begin
  while Lab^[v] > 0 do v := Lab^[v];
  GetRoot := v;
end;

procedure Union(r1, r2: Integer);
var
  x: Integer;
begin
  x := Lab^[r1] + Lab^[r2];
  if Lab^[r1] > Lab^[r2] then
    begin
      Lab^[r1] := r2;
      Lab^[r2] := x;
    end
  else
    begin
      Lab^[r1] := x;
      Lab^[r2] := r1;
    end;
end;

procedure AdjustHeap(root, last: Integer);
var
  Key: PEdge;
  child: Integer;
begin
  Key := e[root];
  while root * 2 <= Last do
    begin
      child := root * 2;
      if (child < Last) and (e[child + 1]^.c < e[child]^.c)
        then Inc(child);
      if Key^.c <= e[child]^.c then Break;
      e[root] := e[child];
      root := child;
    end;
  e[root] := Key;
end;

procedure Kruskal;
var
  i, r1, r2, Count: Integer;
  tmp: PEdge;
begin
  W := 0;
  Count := 0;
  for i := m div 2 downto 1 do AdjustHeap(i, m);
  for i := m - 1 downto 0 do
    begin
      tmp := e[1]; e[1] := e[i + 1]; e[i + 1] := tmp;
      AdjustHeap(1, i);
      r1 := GetRoot(e[i + 1]^.u); r2 := GetRoot(e[i + 1]^.v);
      if r1 <> r2 then
        begin
          e[i + 1]^.id := -e[i + 1]^.id;
          W := W + e[i + 1]^.c;
          Inc(Count);
          if Count = n - 1 then Exit;
          Union(r1, r2);
        end;
    end;
end;

procedure PrintResult;
var
  i: Integer;
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, W);
  for i := 1 to m do
    if e[i]^.id < 0 then Writeln(f, - e[i]^.Id);
  Close(f);
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
  {$I-}
  Assign(f, 'POINT.PNT'); Reset(f);
  if IOResult <> 0 then
    begin
      WriteP(0);
      Reset(f);
    end;
  {$I+}
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
var
  S: String[1];
begin
  Caption('Bµi 146: "C©y bao trïm tèi tiÓu"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      S := ParamStr(1);
      ch := S[1];
    end
  else  ch := ReadKey;
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

procedure Test;
var
  HSW, W1: LongInt;
  i, j: Integer;
begin
  Caption('ChÊm bµi 146: "C©y bao trïm tèi tiÓu"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f,  HSW);
  Writeln('Träng sè c©y khung: ');
  Writeln('  + §¸p ¸n   : ', W);
  Writeln('  + Häc sinh : ', HSW);
  if HSW > W then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  LoadGraph;
  W1 := 0;
  for i := 1 to n - 1 do
    begin
      Readln(f, j);
      if (j < 1) or (j > m) then
        begin
          Writeln('Kh«ng cã chØ sè ', j);
          Wrong;
        end;
      W1 := W1 + e[j]^.c;
      e[j]^.c := -1;
    end;
  Writeln('Tæng träng sè c¸c c¹nh trªn c©y khung: ', W1);
  if W1 <> HSW then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong;
    end;
  Init;
  Kruskal;
  if W <> -(n - 1) then
    begin
      Writeln('Output kh«ng ph¶i lµ c©y!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  Asktest;
  InitMem;
  LoadGraph;
  Init;
  Kruskal;
  PrintResult;
  Test;
end.
6 9
1 2 1
1 3 1
2 4 1
2 3 2
2 5 1
3 5 1
3 6 1
4 5 2
5 6 2
