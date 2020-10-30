program MatchingInGeneralGraph;
uses crt, visual;
const
  InputFile: string  = 'COVER.IN';
  OutputFile = 'COVER.OUT';
  max = 100;
var
  a: array[1..max, 1..max] of Boolean;
  match, Queue, b, T: array[1..max] of Integer;
  InQueue: array[1..max] of Boolean;
  res, n, first, last, start, finish: Integer;

  f: Text;
  ch: Char;

procedure Enter;
var
  i, m, u, v: Integer;
  f: Text;
begin
  FillChar(a, SizeOf(a), False);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a[u, v] := True;
      a[v, u] := True;
    end;
end;

procedure Init;
begin
  FillChar(match, SizeOf(match), 0);
end;

procedure InitBFS;
var
  i: Integer;
begin
  first := 1;
  last := 1;
  Queue[1] := start;
  FillChar(InQueue, SizeOf(InQueue), False);
  InQueue[start] := True;
  FillChar(T, SizeOF(T), 0);
  for i := 1 to n do b[i] := i;
  finish := 0;
end;

procedure Push(v: Integer);
begin
  Inc(last);
  Queue[last] := v;
  InQueue[v] := True;
end;

function Pop: Integer;
begin
  Pop := Queue[first];
  Inc(first);
end;

procedure BlossomShrink(p, q: Integer);
var
  i, NewBase: Integer;
  Mark: array[1..max] of Boolean;

  function FindCommonAncestor(p, q: Integer): Integer;
  var
    InPath: array[1..max] of Boolean;
  begin
    FillChar(InPath, SizeOf(Inpath), False);
    repeat
      p := b[p];
      Inpath[p] := True;
      if p = start then Break;
      p := T[match[p]];
    until False;
    repeat
      q := b[q];
      if InPath[q] then Break;
      q := T[match[q]];
    until False;
    FindCommonAncestor := q;
  end;

  procedure ResetTrace(x: Integer);
  var
    u, v: Integer;
  begin
    v := x;
    while b[v] <> NewBase do
      begin
        u := match[v];
        Mark[b[v]] := True;
        Mark[b[u]] := True;
        v := T[u];
        if b[v] <> NewBase then T[v] := u;
      end;
  end;

begin
  FillChar(Mark, SizeOf(Mark), False);
  NewBase := FindCommonAncestor(p, q);
  ResetTrace(p);
  ResetTrace(q);
  if b[p] <> NewBase then T[p] := q;
  if b[q] <> NewBase then T[q] := p;
  for i := 1 to n do
    if Mark[b[i]] then b[i] := NewBase;
  for i := 1 to n do
    if not InQueue[i] and (b[i] = NewBase) then
      Push(i);
end;

procedure FindAugmentingPath;
var
  u, v: Integer;
begin
  InitBFS;
  repeat
    u := Pop;
    for v := 1 to n do
      if (T[v] = 0) and (a[u, v]) and (b[u] <> b[v]) then
        begin
          if match[v] = 0 then
            begin
              T[v] := u;
              finish := v;
              Exit;
            end;
          if (v = start) or (T[match[v]] <> 0) then
            BlossomShrink(u, v)
          else
            begin
              T[v] := u;
              Push(match[v]);
            end;
        end;
  until first > last;
end;

procedure Enlarge;
var
  v, next: Integer;
begin
  repeat
    v := T[finish];
    next := match[v];
    match[v] := finish;
    match[finish] := v;
    finish := next;
  until finish = 0;
end;

procedure Solve;
var
  u: Integer;
begin
  for u := 1 to n do
    if match[u] = 0 then
      begin
        start := u;
        FindAugmentingPath;
        if finish <> 0 then Enlarge;
      end;
end;

procedure Result;
var
  u, v: Integer;
begin
  res := 0;
  for u := 1 to n do
    if (match[u] > u) or (match[u] = 0) then Inc(res);
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
  Caption('Bµi 137: "Phñ"');
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
  i, hsRes, u, v: Integer;
  mark: array[1..max] of Boolean;
begin
  Caption('ChÊm bµi 137: "Phñ"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsRes);
  Writeln('Sè c¹nh ®­îc chän: ');
  Writeln('  + §¸p ¸n  : ', res);
  Writeln('  + Häc sinh: ', hsres);
  if hsres > res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  FillChar(mark, SizeOf(mark), True);
  for i := 1 to hsres do
    begin
      Readln(f, u, v);
      Writeln(i:5, '. (', u, ', ', v, ')');
      if (u < 1) or (u > n) or (v < 1) or (v > n) then
        begin
          Writeln('Sai khu«n d¹ng Output!');
          Wrong;
        end;
      if not a[u, v] then
        begin
          Writeln('(', u, ', ', v, ') kh«ng ph¶i lµ c¹nh');
          Wrong;
        end;
      mark[u] := False; mark[v] := False;
    end;
  for i := 1 to n do
    if mark[i] then
      begin
        Writeln('§Ønh ', i, ' ch­a ®­îc phñ!');
        Wrong;
      end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Solve;
  Result;
  Test;
end.

10 11
1 2
1 6
2 4
2 8
3 4
3 6
5 6
5 9
5 10
7 8
7 9