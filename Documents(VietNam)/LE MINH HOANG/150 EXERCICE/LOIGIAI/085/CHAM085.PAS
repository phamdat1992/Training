{$R-,S-,D-,I-,Q-}    {Cham cho nhanh}
{$M 65520,0,655360}
program Tiger;
uses crt, visual;
const
  InputFile: String  = 'TIGER.IN';
  TestFile = 'TIGER.OUT';
  max = 100;
type
  TTrace = array[1..max] of Integer;
var
  a, b: array[1..max, 1..max] of Integer;
  Trace: TTrace;
  CutS, CutF: set of Byte;
  p1, q1, p2, q2, Flow, Start, Finish, n: Integer;
  f: Text;
  ch: Char;
  Solution: String;

procedure Enter;
var
  finp: Text;
  u, v: Integer;
begin
  Assign(finp, InputFile); Reset(finp);
  Readln(finp, n);
  FillChar(a, SizeOf(a), False);
  while not SeekEof(finp) do
    begin
      Readln(finp, u, v);
      a[u, v] := 1; a[v, u] := 1;
    end;
  Close(finp);
  b := a;
end;

function Check: Boolean;
begin
  if a[1, n] <> 0 then Solution := 'NO'
  else Solution := 'YES';
  Check := a[1, n] = 0;
end;

procedure CreateMultiGraph;
var
  v: Integer;
begin
  for v := 1 to n do
    begin
      a[v, Start] := 0; a[Finish, v] := 0;
      if a[Start, v] <> 0 then a[Start, v] := 2 * max;
    end;
end;

function FindPath: Boolean;
var
  Q: array[1..max] of Integer;
  u, v, first, last: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[Start] := 1; {<>0}
  Q[1] := Start; first := 1; last := 1;
  repeat
    u := Q[first]; Inc(first);
    for v := 1 to n do
      if (Trace[v] = 0) and (a[u, v] <> 0) then
        begin
          Trace[v] := u;
          if v = Finish then
            begin
              FindPath := True; Exit;
            end;
          Inc(last); Q[last] := v;
        end;
  until first > last;
  FindPath := False;
end;

procedure IncFlow;
var
  t, prev: Integer;
begin
  t := Finish;
  repeat
    prev := Trace[t]; {prev -> t}
    Dec(a[prev, t]); Inc(a[t, prev]);
    t := prev;
  until t = Start;
end;

procedure GetMaxFlow;
var
  v: Integer;
begin
  Flow := 0;
  repeat
    if not FindPath then Break;
    IncFlow;
    Inc(Flow);
  until False;
end;

procedure GetCut; {Lay lat cat sat dinh thu nhat}

  procedure Visit(u: Integer);
  var
    v: Integer;
  begin
    CutS := CutS - [u]; CutF := CutF + [u];
    for v := 1 to n do
      if (v in CutS) and (a[v, u] <> 0) then Visit(v);
  end;

begin
  CutS := [1..n]; CutF := [];
  Visit(Finish);
end;

procedure Refine;
var
  u, v: Integer;
begin
  {Them nhung canh tu lat cat phat toi thang dinh thu}
  for u := 1 to n do
    for v := 1 to n do
      if (b[u, v] <> 0) and (u in CutS) and (v in CutF) then
        begin
          b[u, Finish] := 1; b[Finish, u] := 1;
        end;
  {loai bo cac doan duong phia sau ho,
  chi xet nhung doan nam phia truoc ho + nhung doan moi them vao}
  CutS := CutS + [Finish];
  FillChar(a, SizeOf(a), 0);
  for u := 1 to n do
    for v := 1 to n do
      if (u in CutS) and (v in CutS) then a[u, v] := b[u, v];
end;

procedure Solve;
begin
  CreateMultiGraph;
  GetMaxFlow;
  GetCut;
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
  Caption('Bµi 085: "MÌo óc"');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: TIGER.IN  '#8#8);
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

procedure CheckAccept;
var
  i, u, v: Integer;
begin
  TextAttr := 158;
  Writeln('            * KiÓm tra tÝnh hîp lÖ cña ph­¬ng ¸n:');
  TextAttr := 159;
  Enter;
  Assign(f, TestFile); Reset(f); Readln(f);
  Readln(f, p1);
  Writeln('Sè hè: ', p1);
  for i := 1 to p1 do
    begin
      Readln(f, u, v);
      Writeln(i:5, ') ', u, ' - ', v);
      if (u < 1) or (u > n) or (v < 1) or (v > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      if a[u, v] = 0 then
        begin
          Writeln('Kh«ng cã ®­êng ', u, ' - ', v);
          Wrong;
        end;
      a[u, v] := 2; a[v, u] := 2;
    end;
  Readln(f, q1);
  Writeln('Sè bia: ', q1);
  for i := 1 to q1 do
    begin
      Readln(f, u, v);
      Writeln(i:5, ') ', u, ' - ', v);
      if (u < 1) or (u > n) or (v < 1) or (v > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      if a[u, v] = 0 then
        begin
          Writeln('Kh«ng cã ®­êng ', u, ' - ', v);
          Wrong;
        end;
      if a[u, v] = 2 then
        begin
          Writeln('§­êng ', u, ' - ', v, ' ®· ®µo hè!');
          Wrong;
        end;
      a[u, v] := 3; a[v, u] := 3;
    end;
  Writeln('Ph­¬ng ¸n hîp lÖ!');
  b := a;
end;

procedure DFS(u, Disable: Integer);
var
  v: Integer;
begin
  for v := 1 to n do
    if (Trace[v] = 0) and not (a[u, v] in [0, Disable]) then
      begin
        Trace[v] := u;
        DFS(v, Disable);
      end;
end;

procedure CheckCorrect;
var
  P, T1, Tn: TTrace;
  u, v, np: Integer;
begin
  TextAttr := 158;
  Writeln('            * KiÓm tra tÝnh ®óng ®¾n cña ph­¬ng ¸n:');
  TextAttr := 159;
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[1] := 1;
  DFS(1, 3); {Liet ke nhung dinh den duoc tu 1 khong di qua beer}
  T1 := Trace;
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[n] := 1;
  DFS(n, 2); {Liet ke nhung dinh den duoc tu n khong di qua hole}
  Tn := Trace;
  for u := 1 to n do
    if (T1[u] <> 0) and (Tn[u] <> 0) then
      begin
        Writeln('VÉn tån t¹i ®­êng ®i an toµn: ');
        np := 0;
        v := u;
        repeat
          Inc(np);
          P[np] := v;
          if v = 1 then Break else v := T1[v];
        until False;
        for v := np downto 2 do Write(p[v], ' -> ');
        v := u;
        repeat
          if v = n then Break;
          Write(v, ' -> ');
          v := Tn[v];
        until False;
        Writeln(n);
        Wrong;
      end;
  Writeln('§óng ®¾n! Mäi con ®­êng ®Òu ®· bÞ phong to¶!');
end;

procedure CheckOptimized;
var
  i: Integer;
  C1, C2: LongInt;
begin
  TextAttr := 158;
  Writeln('            * KiÓm tra tÝnh tèi ­u cña ph­¬ng ¸n:');
  TextAttr := 159;
  Writeln('  + §¸p ¸n  : ', p2, ' hè + ', q2, ' bia');
  Writeln('  + Häc sinh: ', p1, ' hè + ', q1, ' bia');
  C2 := LongInt(p2) * (max + 1) + q2;
  C1 := LongInt(p1) * (max + 1) + q1;
  if C1 < C2 then
      Writeln('Tèt h¬n ®¸p ¸n! ThÇy Hoµng sai råi!!! ')
  else
      if C1 > C2 then
        begin
          Writeln('Kh«ng tèi ­u!');
          Wrong;
        end
      else
        begin
          Writeln('Tåi nh­ ®¸p ¸n!');
          Correct;
        end;
end;

procedure Test;
var
  S: String;
begin
  Caption('ChÊm bµi: "MÌo óc"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, TestFile); Reset(f);
  Readln(f, S);
  Close(f);
  Writeln('Dßng 1: ');
  Writeln('  + §¸p ¸n  : ', Solution);
  Writeln('  + Häc sinh: ', S);
  if S <> Solution then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end
  else
    begin
      Writeln('Tèt!');
      if Solution = 'NO' then Correct;
    end;
  CheckAccept;
  CheckCorrect;
  CheckOptimized;
  Correct;
end;

begin
  AskTest;
  Enter;
  if Check then
    begin
      Start := 1; Finish := n;
      Solve; {Holes}
      p2 := Flow;
      Refine;
      Start := n; Finish := 1;
      Solve; {Beers}
      q2 := Flow;
    end;
  Test;
end.
9
1 2
1 3
1 4
1 5
2 4
3 5
4 5
4 6
5 7
6 8
6 9
7 8
7 9
8 9

9
1 2
1 3
1 4
2 5
3 6
3 7
4 8
5 9
6 9
7 9
8 9

7
1 2
1 3
2 4
2 5
4 6
4 7
5 7
6 7

10
1 2
1 3
2 4
2 5
2 8
3 6
3 7
3 9
4 8
5 6
5 8
6 9
7 9
8 10
9 10
