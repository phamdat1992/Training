{$R-,S-,Q-,D-}
program AnimalMoving;
uses crt, visual;
const
  InputFile: String = 'MOVE.IN';
  OutputFile = 'MOVE.OUT';
  max = 200;
  maxT = 20000;
var
  a: array[1..max, 1..max] of Boolean;
  t: array[1..max] of Integer;
  Queue, Trace: array[1..max] of Integer;
  n, Start, Finish, First, Last: Integer;
  Res: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, u, v: Integer;
begin
  FillChar(a, SizeOf(a), False);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, Start, Finish);
  for i := 1 to n do Read(f, t[i]);
  Readln(f);
  while not SeekEof(f) do
    begin
      Readln(f, u, v);
      a[u, v] := True; a[v, u] := True;
    end;
  Close(f);
end;

procedure InitBFS;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[Finish] := n + 1; {<> 0}
  Queue[1] := Finish;
  First := 1; Last := 1;
end;

procedure Push(V: Integer);
begin
  Inc(Last); Queue[Last] := V;
end;

function Pop: Integer;
begin
  Pop := Queue[First]; Inc(First);
end;

function GetPath(Threshold: Integer): Boolean;
var
  u, v: Integer;
begin
  InitBFS;
  repeat
    u := Pop;
    for v := 1 to n do
      if a[u, v] and (Trace[v] = 0) and (Abs(t[u] - t[v]) <= Threshold) then
        begin
          Trace[v] := u;
          if v = Start then
            begin
              GetPath := True;
              Exit;
            end;
          Push(v);
        end;
  until First > Last;
  GetPath := False;
end;

procedure Solve;
var
  inf, sup, median: Integer;
begin
  inf := -1; sup := maxT + 1;
  while inf + 1 < sup do
    begin
      median := (LongInt(inf) + sup) div 2;
      if GetPath(median) then sup := median
      else inf := median;
    end;
  if GetPath(sup) then Res := Sup
  else Res := -1;
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
var
  S: String[1];
begin
  Caption('Bµi "B¶o tån ®éng vËt hoang d·"');
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
  S, Next, THS: Integer;
begin
  Caption('ChÊm bµi: "B¶o tån ®éng vËt hoang d·"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, THS);
  Writeln('Dßng 1: §é chªnh lÖch nhiÖt ®é');
  Writeln('  + §¸p ¸n  : ', Res);
  Writeln('  + Häc sinh: ', THS);
  if Res <> THS then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  if Res = -1 then Correct;
  Writeln('KiÓm tra hµnh tr×nh:');
  Read(f, S);
  if S <> Start then
    begin
      Writeln('§Þa ®iÓm xuÊt ph¸t sai!');
      Wrong;
    end;
  while not SeekEoln(f) do
    begin
      Read(f, Next);
      if not a[S, Next] then
        begin
          Writeln('Gi÷a hai ®Þa ®iÓm liªn tiÕp ', S, ' vµ ', Next,
                        ' kh«ng cã ®­êng!');
          Wrong;
        end;
      if Abs(t[S] - t[Next]) > THS then
        begin
          Writeln('NhiÖt ®é hai ®Þa ®iÓm liªn tiÕp: ');
          Writeln('  + t(', S, ') = ', t[S]);
          Writeln('  + t(', Next, ') = ', t[Next]);
          Writeln('  Chªnh lÖch = ', Abs(t[S] - t[Next]), ' > ', THS);
          Wrong;
        end;
      S := Next;
    end;
  if S <> Finish then
    begin
      Writeln('§Þa ®iÓm kÕt thóc sai!');
      Wrong;
    end;
  Writeln('§­êng ®i chÝnh x¸c');
  Correct;
end;

begin
  AskTest;
  Enter;
  Solve;
  Test;
end.
7 1 4
20 22 29 30 24 27 26
1 2
1 3
1 4
2 4
2 5
3 4
3 6
4 5
4 6
5 7
6 7
