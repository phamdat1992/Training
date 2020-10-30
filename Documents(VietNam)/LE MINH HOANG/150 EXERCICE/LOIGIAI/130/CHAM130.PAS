{$M 65520 0 655360}
program LinkedKnights;
uses crt, visual;
const
  InputFile: string = 'KMOVE.IN';
  OutputFile = 'KMOVE.OUT';
  max = 100;
  dx: array[1..8] of Integer = (1, -1, 1, -1, 2, -2, 2, -2);
  dy: array[1..8] of Integer = (2, 2, -2, -2, 1, 1, -1, -1);
type
  TBoard = array[-1..max + 2, -1..max + 2] of Char;
var
  a: TBoard;
  pos: array[-1..max + 2, -1..max + 2] of Integer;
  x, y: array[1..max] of Integer;
  knight: array[1..max, 1..max] of Integer;
  n, k: Integer;
  f: Text; ch: Char;

{$R-,Q-,S-,I-}

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  FillChar(a, SizeOf(a), '#');
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  k := 0;
  for i := 1 to n do
    begin
      for j := 1 to n do
        begin
          Read(f, a[i, j]);
          if a[i, j] = '$' then
            begin
              Inc(k);
              x[k] := i; y[k] := j;
            end;
        end;
      Readln(f);
    end;
  Close(f);
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
  Caption('Bµi 130: "Liªn hoµn m·"');
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

procedure CheckLine;
var
  x1, y1, x2, y2, kn, i, count: Integer;
  free: array[1..max] of Boolean;

  procedure DFS(i: Integer);
  var
    d, j, px, py, newx, newy: Integer;
  begin
    free[i] := False;
    Inc(count); px := x[i]; py := y[i];
    for d := 1 to 8 do
      begin
        newx := px + dx[d]; newy := py + dy[d];
        j := pos[newx, newy];
        if j = 0 then Continue;
        if free[j] then DFS(j);
      end;
  end;

begin
  while not SeekEoln(f) do
    begin
      Read(f, x1, y1, x2, y2);
      if Abs((x1 - x2) * (y1 - y2)) <> 2 then
        begin
          Writeln('§i sai luËt!');
          Writeln(' (', x1, ', ', y1, ') -> (', x2, ', ', y2, ')');
          Wrong;
        end;
      if a[x2, y2] = '#' then
        begin
          Writeln('§i vµo « cÊm (', x2, ', ', y2, ')');
          Wrong;
        end;
      if Pos[x1, y1] = 0 then
        begin
          Writeln('Kh«ng cã m· ë « (', x1, ', ', y1, ')');
          Wrong;
        end;
      kn := Pos[x1, y1];
      x[kn] := x2; y[kn] := y2;
    end;
  Readln(f);
  FillChar(Pos, SizeOf(Pos), 0);
  for i := 1 to k do
    if Pos[x[i], y[i]] <> 0 then
      begin
        Writeln('¤ (', x[i], ', ', y[i], ') chøa 2 qu©n m·!');
        Wrong;
      end
    else
      Pos[x[i], y[i]] := i;
  count := 0; FillChar(free, SizeOf(free), True);
  DFS(1);
  if count <> k then
    begin
      Writeln('MÊt tÝnh liªn hoµn!');
      Wrong;
    end;
end;

procedure Test;
var
  i: Integer;
  c: LongInt;
begin
  Caption('ChÊm bµi 130: "Liªn hoµn m·"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Writeln('KiÓm tra n­íc ®i:');
  FillChar(Pos, SizeOf(Pos), 0);
  for i := 1 to k do
    Pos[x[i], y[i]] := i;
  Assign(f, OutputFile); Reset(f);
  c := 0;
  while not SeekEof(f) do
    begin
      Inc(c); Write('  + LÖnh hµnh qu©n ', c, ': ... ');
      CheckLine;
      Writeln('OK');
    end;
  Writeln('KiÓm tra vÞ trÝ tËp kÕt...');
  for i := 1 to k do
    if a[x[i], y[i]] <> '@' then
      begin
        Writeln('Cßn qu©n m· ch­a tËp kÕt ë « (', x[i], ', ', y[i], ')');
        Wrong;
      end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Test;
end.

