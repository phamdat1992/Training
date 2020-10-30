program TheTours;
uses crt, Visual;
const
  InputFile: String = 'TOURS.IN';
  OutputFile = 'TOURS.OUT';
  max = 200;
type
  TBoard = array[1..max, 1..max] of Byte;
var
  c: TBoard;
  flow:^TBoard;
  Queue, Trace, Go, Back: array[1..max] of Integer;
  res, n, nGo, nBack, Start, Finish, first, last, MaxFlow: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  m, i, u, v: Integer;
begin
  FillChar(c, SizeOf(c), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m, Start, Finish);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      c[u, v] := 1;
      c[v, u] := 1;
    end;
  Close(f);
  New(Flow);
  FillChar(Flow^, SizeOf(Flow^), 0);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to n do
    begin
      c[i, Start] := 0;
      c[Finish, i] := 0;
    end;
end;

function FindPath(S, F: Integer): Boolean;
var
  u, v: Integer;
begin
  Queue[1] := S; first := 1; last := 1;
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[S] := n + 1;
  repeat
    u := Queue[first]; Inc(first);
    for v := 1 to n do
      if Trace[v] = 0 then
        begin
          if c[u, v] > flow^[u, v] then Trace[v] := u
          else
            if flow^[v, u] > 0 then Trace[v] := -u;
          if Trace[v] <> 0 then
            begin
              Inc(last); Queue[last] := v;
              if v = F then
                begin
                  FindPath := True;
                  Exit;
                end;
            end;
        end;
  until first > last;
  FindPath := False;
end;

procedure IncFlow;
var
  t, prev: Integer;
begin
  Inc(MaxFlow);
  t := Finish;
  repeat
    prev := Trace[t]; {prev -> t}
    if prev > 0 then Inc(flow^[prev, t])
    else Dec(flow^[t, -prev]);
    t := Abs(prev);
  until t = Start;
end;

procedure Refine;
var
  u, v: Integer;
begin
  for u := 1 to n do
    for v := 1 to n do
      if (flow^[u, v] <> 0) and (flow^[v, u] <> 0) then
        begin
          flow^[u, v] := 0;
          flow^[v, u] := 0;
        end;
  FillChar(c, SizeOf(c), 0);
  for u := 1 to n do
    for v := 1 to n do
      if flow^[u, v] = 1 then c[u, v] := 1;
  FillChar(flow^, SizeOf(flow^), 0);
end;

procedure FindMaxFlow;
begin
  while FindPath(Start, Finish) do IncFlow;
  res := MaxFlow div 2;
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
  MSG(20, 3, InputFile, 'B¹n cã 1 ®iÓm');
  WriteP(ReadP + 1);
  ShowP;
  if ReadP = 10 then
    Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
  Halt;
end;

procedure Wrong;
begin
  Color := 78;
  MSG(20, 3, InputFile, 'B¹n cã 0 ®iÓm'#7);
  ShowP;
  Halt;
end;

procedure AskTest;
begin
  Caption('Bµi 082: Du lÞch kiÓu óc');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: TOURS.IN  '#8#8);
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

procedure CheckTour;
var
  t, next: Integer;
  OK: Boolean;
begin
  Read(f, t);
  if t <> Start then
    begin
      Writeln('Kh«ng xuÊt ph¸t tõ ®Ønh ', Start);
      Wrong;
    end;
  while not SeekEoln(f) do
    begin
      Read(f, next);
      if c[t, next] = 0 then
        begin
          Write('Lçi! ®o¹n ', t, ' -> ', next, ' kh«ng cã hoÆc ®i lÆp');
          Wrong;
        end;
      c[t, next] := 0; c[next, t] := 0;
      t := next;
      OK := OK or (t = Finish);
    end;
  if t <> Start then
    begin
      Writeln('Kh«ng quay l¹i ®Ønh ', Start);
      Wrong;
    end;
  if not OK then
    begin
      Writeln('Kh«ng ®i ®Õn ®­îc ', Finish);
      Wrong;
    end;
  Readln(f);
end;

procedure Test;
var
  i, nTours: Integer;
begin
  Enter;
  Caption('ChÊm bµi 082: "Du lÞch kiÓu óc"');
  Visual.Color := 159;
  Frame(5, 8, 75, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, nTours);
  Writeln('Sè tua: ');
  Writeln('  + §¸p ¸n   : ', Res);
  Writeln('  + Häc sinh : ', nTours);
  if nTours < Res then Wrong;
  Writeln('  Tèt');
  for i := 1 to nTours do
    begin
      Write('Tour ', i, ': ');
      CheckTour;
      Writeln('OK');
    end;
  Writeln('  Tèt');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  FindMaxFlow;
  Test;
end.
