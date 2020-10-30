program DispatchMessage;
uses crt, visual;
const
  InputFile: String  = 'MESSAGE.IN';
  OutputFile = 'MESSAGE.OUT';
  max = 100;
  maxV = 30000;
var
  n: Integer;
  S, D: Integer;
  c: array[1..max, 1..max] of Integer;
  DLabel: array[1..max] of Word;
  Trace1, Trace2: array[1..max] of Integer;
  Solution: Boolean;
  Distance1, Distance2: Word;
  res: String;
  ch: Char;
  f: Text;
  Path: array[1..max] of Integer;
  nPath: Integer;
  Sum: Integer;

procedure Enter;
var
  f: Text;
  m, i: Integer;
  u, v: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m, S, D);
  for u := 1 to n do
    for v := 1 to n do
      c[u, v] := maxV;
  for i := 1 to m do
    begin
      Readln(f, u, v, c[u, v]);
      c[v, u] := c[u, v];
    end;
  Close(f);
end;

procedure Dijkstra;
var
  Free: array[1..max] of Boolean;
  u, v: Integer;
  min: Word;
begin
  FillChar(Free, SizeOf(Free), True);
  for v := 1 to n do DLabel[v] := maxV;
  DLabel[S] := 0;
  repeat
    min := maxV; u := 0;
    for v := 1 to n do
      if Free[v] and (DLabel[v] < min) then
        begin
          min := DLabel[v];
          u := v;
        end;
    if (u = 0) or (u = D) then
      begin
        Solution := u = D;
        Exit;
      end;
    Free[u] := False;
    for v := 1 to n do
      if Free[v] and (DLabel[v] > DLabel[u] + c[u, v]) then
        begin
          DLabel[v] := DLabel[u] + c[u, v];
          Trace1[v] := u;
        end;
  until False;
end;

procedure ResetMatrix;
var
  u, v: Integer;
begin
  v := D;
  repeat
    u := Trace1[v];
    c[v, u] := - c[v, u];
    c[u, v] := maxV;
    v := u;
  until u = S;
end;

procedure FordBellman;
var
  u, v, k: Integer;
  Stop: Boolean;
begin
  for v := 1 to n do DLabel[v] := maxV;
  DLabel[S] := 0;
  for k := 1 to n do
    begin
      Stop := True;
      for u := 1 to n do
        for v := 1 to n do
          if DLabel[v] > DLabel[u] + c[u, v] then
            begin
              DLabel[v] := DLabel[u] + c[u, v];
              Trace2[v] := u;
              Stop := False;
            end;
      if Stop then Break;
    end;
  Solution := Solution and (DLabel[D] <> maxV);
end;

procedure Result;
begin
  if not Solution then Res := 'NO SOLUTION'
  else Str(Distance1 + Distance2, Res);
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
  MSG(60, 3, 'TÊng', 'TÊng Æi”m Æang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 47;
  MSG(20, 3, InputFile, '   Bπn c„ 1 Æi”m   ');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('ßÛng h’t c∏c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Visual.Color := 78;
  MSG(20, 3, InputFile, '   Bπn c„ 0 Æi”m   '#7);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String[1];
begin
  Caption('Bµi 049: "Truy“n tin tr™n mπng"');
  MSG(40, 3, 'Input?', 'Cho t™n file d˜ li÷u: ' + InputFile + '  '#8#8);
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
      MSG(40, 13, 'ßi”m', 'TÊng Æi”m cÒa bπn Æang lµ:  '#8#8);
      Write(ReadP);
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure CheckPath;
var
  i, u, v: Integer;
begin
  if (Path[1] <> S) or (Path[nPath] <> D) then
    begin
      Writeln(' Kh´ng truy“n Æ≠Óc tı m∏y ', S, ' tÌi m∏y ', D);
      Wrong;
    end;
  u := S;
  for i := 2 to nPath do
    begin
      v := Path[i];
      if c[u, v] = maxV then
        begin
          Writeln(' Truy“n Æ≠Íng rıng: ', u, '->', v);
          Wrong;
        end;
      if c[u, v] = -1 then
        begin
          Writeln(' Truy“n Æ≠Íng l∆p: ', u, '->', v);
          Wrong;
        end;
      Sum := Sum + c[u, v];
      c[u, v] := -1;
      c[v, u] := -1;
      u := v;
    end;
  Writeln(' ß≠Íng truy“n hÓp l÷!');
end;

procedure Test;
var
  hsRes: String;
  hsv: Integer;
  i: Integer;
begin
  Enter;
  Caption('Ch m bµi 049: "Truy“n tin tr™n mπng"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsRes);
  while hsRes[1] = ' ' do Delete(hsRes, 1, 1);
  Writeln('Dﬂng 1: ');
  Writeln('  + ß∏p ∏n  : ', res);
  Writeln('  + H‰c sinh: ', hsres);
  if res <> hsres then
    begin
      Writeln('K’t qu∂ sai!');
      Wrong;
    end;
  Writeln('K’t qu∂ ÆÛng!');
  if res = 'NO SOLUTION' then Correct;
  Writeln('Ki”m tra hai Æ≠Íng truy“n:');
  nPath := 0;
  while not SeekEoln(f) do
    begin
      Inc(nPath); Read(f, Path[nPath]);
    end;
  Readln(f);
  Sum := 0;
  Write('ß≠Íng truy“n 1: ');
  for i := 1 to nPath do Write(Path[i], ' '); Writeln;
  CheckPath;
  nPath := 0;
  while not SeekEoln(f) do
    begin
      Inc(nPath); Read(f, Path[nPath]);
    end;
  Readln(f);
  Write('ß≠Íng truy“n 2: ');
  for i := 1 to nPath do Write(Path[i], ' '); Writeln;
  CheckPath;
  Val(hsRes, hsV, i);
  Writeln('Chi ph› t›nh theo hai Æ≠Íng truy“n: ', Sum);
  if Sum <> hsV then
    begin
      Writeln(' Ti“n hÀu b t nh t!');
      Wrong;
    end;
  Writeln('Ch›nh x∏c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Dijkstra;
  if Solution then
    begin
      Distance1 := DLabel[D];
      ResetMatrix;
      FordBellman;
      Distance2 := DLabel[D];
    end;
  Result;
  Test;
end.
5 7 1 5
1 2 3
1 4 8
2 3 5
2 4 4
3 5 5
4 3 8
4 5 3
