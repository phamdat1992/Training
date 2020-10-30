program Schedule;
uses crt, visual;
const
  InputFile: string  = 'SCHEDULE.IN';
  OutputFile = 'SCHEDULE.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Boolean;
  d, list, lab: array[1..max] of Integer;
  n, T, nP: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for j := 1 to n do
    begin
      repeat
        Read(f, i);
        if i = 0 then Break;
        a[i, j] := True;
      until False;
      Readln(f);
    end;
  Close(f);
end;

procedure Numbering;
var
  first, last: Integer;
  i, j: Integer;
  deg: array[1..max] of Integer;
begin
  FillChar(deg, SizeOf(deg), 0);
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] then Inc(deg[j]);
  last := 0;
  for i := 1 to n do
    if deg[i] = 0 then
      begin
        Inc(last);
        list[last] := i;
        Deg[i] := MaxInt;
      end;
  for first := 1 to n do
    begin
      i := list[first];
      for j := 1 to n do
        if a[i, j] then
          begin
            Dec(deg[j]);
            if deg[j] = 0 then
              begin
                Inc(last); List[last] := j;
                deg[j] := MaxInt;
              end;
          end;
    end;
end;

procedure FindLongestPath;
var
  i, j, u, v: Integer;
begin
  for i := 1 to n do d[i] := 1;
  for i := 1 to n do
    for j := i + 1 to n do
      begin
        u := List[i]; v := List[j];
        if a[u, v] and (d[v] < d[u] + 1) then d[v] := d[u] + 1;
      end;
  T := 0;
  for i := 1 to n do
    if d[i] > T then T := d[i];
end;

procedure SortByLongestPath;
var
  c: array[1..max] of Integer;
  i: Integer;
begin
  FillChar(c, SizeOf(c), 0);
  for i := 1 to n do Inc(c[d[i]]);
  for i := 2 to n do c[i] := c[i - 1] + c[i];
  for i := 1 to n do
    begin
      List[c[d[i]]] := i;
      Dec(c[d[i]]);
    end;
end;

function Arrange(k: Integer): Boolean;
var
  count: array[1..max] of Integer;
  i, u, v, tm: Integer;
begin
  FillChar(count, SizeOf(count), 0);
  for i := n downto 1 do
    begin
      u := List[i];
      tm := T + 1;
      for v := 1 to n do
        if a[u, v] and (Lab[v] < tm) then tm := Lab[v];
      Dec(tm);
      while (tm > 0) and (count[tm] = k) do Dec(tm);
      if tm = 0 then
        begin
          Arrange := False;
          Exit;
        end;
      Lab[u] := tm;
      Inc(count[tm]);
    end;
end;

procedure Solve;
var
  inf, sup, median: Integer;
begin
  inf := 0; sup := n;
  repeat
    median := (inf + sup) div 2;
    if Arrange(median) then sup := median
    else inf := median;
  until inf + 1 >= sup;
  nP := sup;
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

procedure WriteP(p: Real);
var
  f: file of Real;
begin
  Assign(f, 'POINT.PNT'); Rewrite(f);
  Write(f, p);
  Close(f);
end;

function ReadP: Real;
var
  f: file of Real;
  P: Real;
begin
  Assign(f, 'POINT.PNT'); Reset(f);
  Read(f, P);
  Close(f);
  ReadP := p;
end;

procedure ShowP;
var
  S: String;
begin
  Str(ReadP:5:2, S);
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

procedure Wrong(P: Real);
var
  S: String;
begin
  Visual.Color := 78;
  Str(P:5:2, S);
  MSG(20, 3, InputFile, '   B¹n cã ' + S + ' ®iÓm   '#7);
  WriteP(ReadP + P);
  ShowP;
  Halt;
end;

procedure AskTest;
var
  S: String;
  T: String[1];
begin
  Caption('Bµi 129: "LÞch häc"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
  if (ParamCount <> 0) and (ParamStr(1) <> '') then
    begin
      T := ParamStr(1);
      ch := T[1];
    end
  else
    ch := ReadKey;
  Write(ch);
  if ch = '1' then WriteP(0);
  if ch = #13 then
    begin
      Str(ReadP:5:2, S);
      MSG(40, 13, '§iÓm', 'Tæng ®iÓm cña b¹n ®ang lµ: ' + S + '/10');
      Halt;
    end;
  InputFile := InputFile + ch;
end;

procedure Test;
var
  i, j, hsT, hsNP, NP2: Integer;
  lb, count: array[1..max] of Integer;
begin
  Caption('ChÊm bµi 129: "LÞch häc"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  FillChar(count, SizeOf(count), 0);
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsT, hsNP);
  Writeln('Sè häc kú tèi thiÓu: ');
  Writeln('  + §¸p ¸n  : ', T);
  Writeln('  + Häc sinh: ', hsT);
  if hsT > T then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong(0);
    end;
  for i := 1 to n do
    begin
      Readln(f, lb[i]);
      if (lb[i] < 0) or (lb[i] > hsT) then
        begin
          Writeln('Kh«ng cã häc kú: ', lb[i]);
          Wrong(0);
        end;
      Inc(count[lb[i]]);
    end;
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] and (lb[i] >= lb[j]) then
        begin
          Writeln('M«n ', i, ' kh«ng ®­îc häc tr­íc m«n ', j);
          Wrong(0);
        end;
  NP2 := 0;
  for i := 1 to hST do
    if count[i] > NP2 then NP2 := count[i];
  Writeln('Sè m«n häc tèi ®a cña 1 häc kú:');
  Writeln('  + §¸p ¸n        : ', nP);
  Writeln('  + Häc sinh      : ', HSnP);
  Writeln('  + TÝnh theo lÞch: ', NP2);
  if NP2 <> HSnP then
    begin
      Writeln('TiÒn hËu bÊt nhÊt!');
      Wrong(0);
    end;
  if HSnP > nP + 2 then
    begin
      Writeln('KÕt qu¶ qu¸ tåi!');
      Wrong(0);
    end;
  if HSnP > nP then
    begin
      Writeln('Tåi h¬n ®¸p ¸n!');
      if HSnP = nP + 1 then Wrong(0.5)
      else Wrong(0.25);
    end;
  if HSnP < nP then
    begin
      Writeln('Tèt h¬n ®¸p ¸n!');
      Correct;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Numbering;
  FindLongestPath;
  SortByLongestPath;
  Solve;
  Test;
end.
7
0
0
1 2 0
0
2 3 4 0
5 0
4 5 0