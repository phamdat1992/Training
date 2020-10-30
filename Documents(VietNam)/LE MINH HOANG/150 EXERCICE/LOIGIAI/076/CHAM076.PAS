{$M 65520 0 655360}
program GuestBox;
uses crt, visual;
const
  InputFile: string[12] = 'GUEST.IN';
  OutputFile = 'GUEST.OUT';
  max = 10000;
type
  TList = array[1..max] of Integer;
  TLongList = array[1..max] of LongInt;
var
  adj, Index: TList;
  head: array[1..max + 1] of Integer;
  c, Parent, Count: ^TList;
  m: ^TLongList;
  n, Director, SelectedCount: Integer;
  res: LongInt;
  f: Text;
  ch: Char;
  PMark: Pointer;

procedure Enter;
var
  f: Text;
  i, p: Integer;
begin
  Mark(PMark);
  New(m); New(c); New(Parent); New(Count); New(c);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  FillChar(Count^, SizeOf(Count^), 0);
  for i := 1 to n do
    begin
      Read(f, Parent^[i], c^[i]);
      if Parent^[i] = 0 then Director := i
      else Inc(Count^[Parent^[i]]);
    end;
  head[1] := 1;
  for i := 2 to n + 1 do
    begin
      head[i] := head[i - 1] + Count^[i - 1];
    end;
  for i := 1 to n do
    if Parent^[i] <> 0 then
      begin
        p := Parent^[i];
        Dec(Count^[p]);
        adj[head[P] + Count^[p]] := i;
      end;
  Dispose(Count);
  Close(f);
end;

procedure Numbering;
var
  i, Last, iv, u, v: Integer;
begin
  Index[1] := Director; Last := 1;
  for i := 1 to n do {Breadth First Search}
    begin
      u := Index[i]; {Pop u}
      for iv := head[u] to head[u + 1] - 1 do
        begin
          v := adj[iv];
          Inc(Last); Index[Last] := v; {Push v}
        end;
    end;
end;

{Ham lay tong do vui tinh cac nhanh con}
function GetChildrenD(u: Integer): LongInt;
var
  S: LongInt;
  iv: Integer;
begin
  S := 0;
  for iv := head[u] to head[u + 1] - 1 do S := S + m^[adj[iv]];
  GetChildrenD := S;
end;

{Ham lay tong do vui tinh cua cac nhanh chau}
function GetGrandChildrenD(u: Integer): LongInt;
var
  S: LongInt;
  iu, iv: Integer;
begin
  S := 0;
  for iu := head[u] to head[u + 1] - 1 do {Duyet cac con adj[iu] cua u}
    for iv := head[adj[iu]] to head[adj[iu] + 1] - 1 do {Duyet con cua adj[iu]}
      S := S + m^[adj[iv]];
  GetGrandChildrenD := S;
end;

function GetMax(x, y: LongInt): LongInt;
begin
  if x > y then GetMax := x else GetMax := y;
end;

procedure Optimize;
var
  i, j, u, v, iv: Integer;
  ChildrenD, GChildrenD: LongInt;
begin
  for i := n downto 1 do
    begin
      u := Index[i];
      ChildrenD := GetChildrenD(u);
      GChildrenD := GetGrandChildrenD(u);
      if ChildrenD > c^[u] + GChildrenD then
        begin
          m^[u] := ChildrenD;
          c^[u] := -1;
        end
      else m^[u] := c^[u] + GChildrenD;
    end;
end;

procedure Trace;
var
  Last, First, iu, iv, p: Integer;
begin
  Index[1] := Director;
  First := 1; Last := 1; SelectedCount := 0;
  repeat
    p := Index[First]; Inc(First);
    if c^[p] > 0 then
      begin
        c^[p] := -2; Inc(SelectedCount);
        for iu := head[p] to head[p + 1] - 1 do
          for iv := head[adj[iu]] to head[adj[iu] + 1] - 1 do
            begin
              Inc(Last); Index[Last] := adj[iv];
            end;
      end
    else
      for iu := head[p] to head[p + 1] - 1 do
        begin
          Inc(Last); Index[Last] := adj[iu];
        end;
  until First > Last;
end;

procedure Result;
begin
  res := m^[Director];
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
  Caption('Bµi ""');
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
  c2, d2: LongInt;
  Mark: array[1..10000] of Boolean;
  i, k: Integer;
begin
  Caption('Bé test bµi "Nh÷ng ng­êi thÝch ®ïa"');
  Color := 159;
  Frame(3, 7, 77, 22, 'ChÊm bµi "Nh÷ng ng­êi thÝch ®ïa"');
  Assign(f, 'GUEST.OUT'); Reset(f);
  Readln(f, c2, d2);
  Writeln('§é vui tÝnh: ');
  Writeln('  + KÕt qu¶ ®óng : ', res);
  Writeln('  + KÕt qu¶ HS   : ', d2);
  if res > d2 then
    begin
      Writeln('YÕu råi');
      Wrong;
    end;
  Writeln('Tèt');
  Writeln('KiÓm tra lêi gi¶i: ');
  Enter;
  FillChar(Mark, SizeOf(Mark), False);
  for i := 1 to c2 do
    begin
      Readln(f, k);
      if k = 0 then
        begin
          Writeln(' + Sai khu«n d¹ng d÷ liÖu. YÕu råi!');
          Wrong;
        end;
      Mark[k] := True;
      d2 := d2 - c^[k];
      if d2 < 0 then
        begin
          Writeln(' + TÝnh tæng sai. YÕu råi!');
          Wrong;
        end;
      if (parent^[k] <> 0) and (Mark[parent^[k]]) then
        begin
          Writeln(' + SÕp cña ng­êi ', k, ' lµ ', parent^[k], ' ®· cã mÆt. MÊt vui råi!');
          Wrong;
        end;
     end;
  if d2 > 0 then
    begin
      Writeln(' + TÝnh tæng sai. YÕu råi!');
      Wrong;
    end
  else
    Writeln('Tèt');
  Correct;
end;

begin
  AskTest;
  Enter;
  Numbering;
  Optimize;
  Result;
  Release(PMark);
  Test;
end.
10
2 9
3 7
4 8
0 10
4 2
5 11
6 6
6 4
4 6
9 6
