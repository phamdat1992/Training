program Network;
uses crt, visual;
const
  InputFile: string = 'NET.IN';
  OutputFile = 'NET.OUT';
  max = 100;
  dx: array[1..4] of Integer = (1, 0, 0, -1);
  dy: array[1..4] of Integer = (0, -1, 1, 0);
type
  TAdj = set of 1..4;
var
  map: array[0..max, 0..max] of TAdj;
  Count, res, m, n, nV: Integer;
  Lab: array[0..(max + 1) * (max + 1) - 1] of Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  x1, y1, x2, y2, d: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  FillChar(map, SizeOf(map), 0);
  while not SeekEof(f) do
    begin
      Readln(f, x1, y1, x2, y2);
      for d := 1 to 4 do
        if (x1 + dx[d] = x2) and (y1 + dy[d] = y2) then Break;
      Include(map[x1, y1], d);
      Include(map[x2, y2], 5 - d);
    end;
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  nV := n * (m + 1) + m;
  for i := 0 to nV do Lab[i] := -1;
end;

function Encode(x, y: Integer): Integer;
begin
  Encode := y * (m + 1) + x;
end;

procedure Decode(v: Integer; var x, y: Integer);
begin
  x := v mod (m + 1);
  y := v div (m + 1);
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
  if Lab[r1] < Lab[r2] then
    begin
      Lab[r2] := r1;
      Lab[r1] := x;
    end
  else
    begin
      Lab[r1] := r2;
      Lab[r2] := x;
    end;
end;

procedure Kruskal;
label Done1;
var
  x1, y1, x2, y2, d: Integer;
  u, v, r1, r2: Integer;
begin
  Count := 0;
  for x1 := 0 to m do
    for y1 := 0 to n do
      for d := 1 to 4 do
        if d in map[x1, y1] then
          begin
            x2 := x1 + dx[d]; y2 := y1 + dy[d];
            u := Encode(x1, y1); v := Encode(x2, y2);
            r1 := GetRoot(u); r2 := GetRoot(v);
            if r1 <> r2 then
              begin
                Inc(count);
                if Count = nV then Goto Done1;
                Union(r1, r2);
              end;
          end;
Done1:
  res := nV - Count;
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
  Caption('Bµi 147: "NETWORK"');
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

function Inside(x, y: Integer): Boolean;
begin
  Inside := (x >= 0) and (x <= m) and (y >= 0) and (y <= n);
end;

procedure Test;
var
  i,
  hsRes, x1, y1, x2, y2, u, v, r1, r2: Integer;
begin
  Caption('ChÊm bµi 147: "NETWORK"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsRes);
  Writeln('Sè c¸p m¹ng nèi thªm: ');
  Writeln('  + §¸p ¸n  : ', res);
  Writeln('  + Häc sinh: ', HSres);
  if HSRes > res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  for i := 1 to hsres do
    begin
      Readln(f, x1, y1, x2, y2);
      if (Abs(x1 - x2) + Abs(y1 - y2) <> 1) or not Inside(x1, y1) or
         not Inside(x2, y2) then
        begin
          Writeln('C¸p nèi kh«ng hîp lÖ: (', x1, ', ', y1, ')-(',
                       x2, ', ', y2, ')');
          Wrong;
        end;
      u := Encode(x1, y1); v := Encode(x2, y2);
      r1 := GetRoot(u); r2 := GetRoot(v);
      if r1 <> r2 then
        begin
          Inc(count);
          Union(r1, r2);
        end;
    end;
  if count <> nV then
    begin
      Writeln('Sau khi nèi, m¹ng vÉn kh«ng liªn th«ng!');
      Wrong;
    end;
  Writeln('Toµn m¹ng liªn th«ng!');
  Writeln('kÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Kruskal;
  Test;
end.
2 3
0 0 0 1
1 0 2 0
1 0 1 1
2 0 2 1
0 1 1 1
1 1 2 1
1 2 2 2
0 3 1 3