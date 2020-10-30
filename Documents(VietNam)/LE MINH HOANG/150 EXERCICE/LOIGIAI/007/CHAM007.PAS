program FriendShip;
uses crt, visual;
const
  InputFile: String = 'FRIEND.IN';
  OutputFile = 'FRIEND.OUT';
  max = 100;
  maxC = 1001;
  maxT = max * maxC;
type
  TLab = array[1..max] of LongInt;
  TTrace = array[1..max] of Integer;
var
  c: array[1..max, 1..max] of Integer;
  s1, f1, s2, f2, n, m: Integer;
  d, d1, d2, d3, d4: TLab;
  Trace: TTrace;
  Path: array[1..max] of Integer;
  nPath: Integer;
  TM, Time1, Time2: LongInt;
  Position: Integer;
  res: String[3];
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  Readln(f, s1, f1, s2, f2);
  for u := 1 to n do
    for v := 1 to n do c[u, v] := maxC;
  for i := 1 to m do
    begin
      Readln(f, u, v, c[u, v]);
      c[v, u] := c[u, v];
    end;
  Close(f);
end;

procedure Dijkstra(Start: Integer; var d: TLab);
var
  p, v: Integer;
  min: LongInt;
  Free: array[1..max] of Boolean;
begin
  for v := 1 to n do d[v] := maxT;
  FillChar(Free, SizeOf(Free), True);
  d[Start] := 0;
  repeat
    p := 0; min := maxT;
    for v := 1 to n do
      if Free[v] and (d[v] < min) then
        begin
          p := v;
          min := d[v];
        end;
    if p = 0 then Exit;
    Free[p] := False;
    for v := 1 to n do
      if Free[v] and (c[p, v] <> maxC) and (d[v] > d[p] + c[p, v]) then
        begin
          d[v] := d[p] + c[p, v];
          Trace[v] := p;
        end;
  until False;
end;

procedure Solve;
var
  u: Integer;
begin
  Dijkstra(s1, d1);
  Dijkstra(s2, d2);
  Dijkstra(f1, d3);
  Dijkstra(f2, d4);
  Time1 := d1[f1]; Time2 := d2[f2];
  TM := maxT; Position := 0;
  for u := 1 to n do
    if (d1[u] + d3[u] = Time1) and (d2[u] + d4[u] = Time2) and
       (d1[u] = d2[u]) and (d1[u] < TM) then
         begin
           TM := d1[u];
           Position := u;
         end;
  if Position <> 0 then Dijkstra(Position, d);
end;

procedure result;
begin
  if Position = 0 then Res := 'NO' else Res := 'YES';
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
  Caption('Bµi 007: "§«i b¹n"');
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
  HRes: String[3];
  t1, t2, HTM: LongInt;
  i, hp: Integer;
begin
  Enter;
  Caption('ChÊm bµi 007: "§«i b¹n"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, Outputfile); Reset(f);
  Readln(f, HRes);
  Writeln('Dßng 1:');
  Writeln('  + §¸p ¸n  : ', Res);
  Writeln('  + Häc sinh: ', HRes);
  if Res <> HRes then
    begin
      Writeln(' KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  if HRes = 'NO' then Correct;
  Readln(f, t1);
  Writeln('*** KiÓm tra ®­êng ®i cña TuÊn ***');
  Writeln('Thêi gian nhanh nhÊt ®Ó TuÊn tíi tr­êng:');
  Writeln('  §¸p ¸n : ', Time1, '; Häc sinh: ', t1);
  if t1 <> Time1 then
    begin
      Writeln(' KÕt qu¶ sai!');
      Wrong;
    end;
  nPath := 0;
  while not SeekEoln(f) do
    begin
      Inc(nPath);
      Read(f, Path[nPath]);
      if (Path[nPath] < 1) or (Path[nPath] > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu');
          Wrong;
        end;
    end;
  Readln(f);
  if (Path[1] <> s1) or (Path[nPath] <> f1) then
    begin
      Writeln(' TuÊn kh«ng ®i tõ nhµ tíi tr­êng!');
      Wrong;
    end;
  for i := 1 to nPath - 1 do t1 := t1 - c[Path[i], Path[i + 1]];
  if t1 <> 0 then
    begin
      Writeln('TÝnh thêi gian sai!');
      Wrong;
    end;
  Writeln('§­êng ®i ®óng!');
  Writeln;
  Writeln('*** KiÓm tra ®­êng ®i cña Mai ***');
  Readln(f, t2);
  Writeln('Thêi gian nhanh nhÊt ®Ó Mai tíi tr­êng:');
  Writeln('  §¸p ¸n : ', Time2, '; Häc sinh: ', t2);
  if t2 <> Time2 then
    begin
      Writeln(' KÕt qu¶ sai!');
      Wrong;
    end;
  nPath := 0;
  while not SeekEoln(f) do
    begin
      Inc(nPath);
      Read(f, Path[nPath]);
      if (Path[nPath] < 1) or (Path[nPath] > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu');
          Wrong;
        end;
    end;
  Readln(f);
  if (Path[1] <> s2) or (Path[nPath] <> f2) then
    begin
      Writeln(' Mai kh«ng ®i tõ nhµ tíi tr­êng!');
      Wrong;
    end;
  for i := 1 to nPath - 1 do t2 := t2 - c[Path[i], Path[i + 1]];
  if t2 <> 0 then
    begin
      Writeln('TÝnh thêi gian sai!');
      Wrong;
    end;
  
  Writeln('§­êng ®i ®óng!');
  Writeln;
  Readln(f, hp); Readln(f, HTM);
  Writeln('Thêi gian sím nhÊt ®Ó hai b¹n gÆp nhau: ');
  Writeln('  §¸p ¸n  : ', TM, '; Häc sinh: ', HTM);
  if TM <> HTM then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('§iÓm gÆp nhau: ', hp);
  if (d1[hp] + d3[hp] = Time1) and (d2[hp] + d4[hp] = Time2) and
     (d1[hp] = TM) and (d2[hp] = TM) then
       Writeln('KÕt qu¶ chÝnh x¸c!')
  else
    begin
      Writeln('§iÓm gÆp nhau kh«ng ®óng víi yªu cÇu!');
      Wrong;
    end;
  Correct;
end;

begin
  AskTest;
  Enter;
  Solve;
  Result;
  Test;
end.
6 7
1 6 2 5
1 3 10
1 4 10
2 3 5
3 4 5
3 6 15
4 5 20
4 6 15

