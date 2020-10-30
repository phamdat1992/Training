program Network;
uses crt, visual;
const
  InputFile: string = 'NREDUCE.IN';
  OutputFile = 'NREDUCE.OUT';
  max = 500;
  maxm = 10000;
type
  TEdge = record
    u, v: Integer;
    w: ShortInt;
  end;
var
  n, m, nE, SavenE: Integer;
  Lab, SaveLab: array[1..max] of Integer;
  EList: array[1..maxm] of TEdge;
  solution: Boolean;
  res: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    with EList[i] do Readln(f, u, v, w);
  Close(f);
end;

procedure InitForest;
var
  i: Integer;
begin
  for i := 1 to n do Lab[i] := -1;
end;

function GetRoot(u: Integer): Integer;
begin
  while Lab[u] >= 0 do u := Lab[u];
  GetRoot := u;
end;

procedure Union(r1, r2: Integer);
var
  x: Integer;
begin
  x := Lab[r1] + Lab[r2];
  if Lab[r1] > Lab[r2] then
    begin
      Lab[r1] := r2;
      Lab[r2] := x;
    end
  else
    begin
      Lab[r2] := r1;
      Lab[r1] := x;
    end;
end;

{Tim rung khung doi voi cac kenh loai code}
function Kruskal(code: Integer): Boolean;
var
  i: Integer;
  r1, r2: Integer;
begin
  for i := 1 to m do
    with EList[i] do
      if w = code then
        begin
          r1 := GetRoot(u); r2 := GetRoot(v);
          if r1 <> r2 then
            begin
              w := -w;  {Mark}
              Inc(nE);
              if nE = n - 1 then
                begin
                  Kruskal := True;
                  Exit;
                end;
              Union(r1, r2);
            end;
        end;
  Kruskal := False;
end;

procedure Solve;
begin
  nE := 0;
  Solution := Kruskal(3); {Dung rung khung loai 3}
  if not Solution then {Neu rung chua phai la cay khung}
    begin
      SavenE := nE; SaveLab := Lab;  {Save}
      {Chap them cac kenh loai 1 de duoc rung khung loai 1&3}
      Solution := Kruskal(1);
      nE := SavenE; Lab := SaveLab;  {Restore}
      {Sau khi phuc hoi lai rung khung loai 3,
       Chap them cac kenh loai 2 de duoc rung khung loai 2&3}
      Solution := Solution and Kruskal(2);
    end;
end;

procedure Result;
var
  i: Integer;
begin
  if not Solution then res := -1
  else res := m - (n + n - 2 - SavenE);
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
  Caption('Bµi 114: "M¹ng rót gän"');
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
  hres, i, k: Integer;
  f: Text;
begin
  Caption('ChÊm bµi 114: "M¹ng rót gän"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hres);
  Writeln('Sè kªnh lo¹i bá: ');
  Writeln('  + §¸p ¸n  : ', res);
  Writeln('  + Häc sinh: ', hres);
  if res > hres then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  if (res = -1) then
    if hres = -1 then
      begin
        Writeln('KÕt qu¶ ®óng!');
        Correct;
      end
    else
      begin
        Writeln('KÕt qu¶ sai!');
        Correct;
      end;
  for i := 1 to hres do
    begin
      Readln(f, k);
      if (k < 1) or (k > m) then
        begin
          Writeln('Sai khu«n d¹ng Output!');
          Wrong;
        end;
      Elist[k].w := 127;
    end;
  for i := m downto 1 do
    if EList[i].w = 127 then
      begin
        EList[i] := EList[m];
        Dec(m);
      end;
  for i := 1 to m do Elist[i].w := Abs(EList[i].w);
  InitForest;
  Solve;
  Result;
  if res = -1 then
    begin
      Writeln('M¹ng cßn l¹i kh«ng tho¶ m·n yªu cÇu!');
      Wrong;
    end;
  if res > 0 then Writeln('Cßn bá tiÕp ®­îc n÷a!');
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  InitForest;
  Solve;
  Result;
  Test;
end.
5 7
1 2 3
2 3 3
3 4 3
5 3 2
5 4 1
5 2 2
1 5 1