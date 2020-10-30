{$R-,Q-,S-,I-}
program B6;
uses crt, visual;
const
  InputFile: String = 'TOURS.IN';
  OutputFile = 'TOURS.OUT';
  max = 200;
type
  TLine = array[1..max] of Word;
  PLine = ^TLine;
  TMark = array[1..20000] of Boolean;
var
  a: array[1..max, 1..max] of Byte;
  Mark: ^TMark;
  Map: array[1..max] of PLine;
  Free: array[1..max] of Boolean;
  Trace: array[1..max] of Word;
  n: Integer;
  count: Word;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, m, x, y: Word;
begin
  Assign(f, InputFile); Reset(f);
  FillChar(a, SizeOf(a), 0);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, x, y);
      a[x, y] := 1;
      a[y, x] := 1;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Free, n, True);
  FillChar(Trace, SizeOf(Trace), 0);
  count := 0;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  Free[u] := False;
  for v := 1 to n do
    if a[u, v] = 1 then
      begin
        a[v, u] := 0;
        if Free[v] then
          begin
            Trace[v] := u;
            Visit(v);
          end
        else a[u, v] := 2;
      end;
end;

procedure Solve;
var
  u, v: Integer;
begin
  for u := 1 to n do
    if Free[u] then Visit(u);
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] = 2 then Inc(Count);
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
  Caption('Bµi "Du lÞch nhiÒu tua nhÊt"');
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
  i, tTour: Word;
  Path: array[1..max + 1] of Integer;
  nPath, j, u, v: Integer;

  procedure CheckPath(number: Word);
  var
    Mark: array[1..max] of Boolean;
    i: Integer;
  begin
    FillChar(Mark, SizeOf(Mark), False);
    for i := 1 to nPath do
      if Mark[Path[i]] then
        begin
          ClrEol;
          Writeln('§Þa ®iÓm ', Path[i], ' bÞ th¨m 2 lÇn!');
          Wrong;
        end
      else Mark[Path[i]] := True;
    for i := 2 to nPath + 1 do
      if a[Path[i], Path[i - 1]] <> 1 then
        begin
          ClrEol;
          Writeln('§i ®­êng rõng: ', Path[i - 1], '->', Path[i]);
          Wrong;
        end
      else
        begin
          Map[Path[i]]^[Path[i - 1]] := number;
          Map[Path[i - 1]]^[Path[i]] := number;
        end;
  end;

begin
  Enter;
  for i := 1 to n do
    begin
      New(Map[i]);
      FillChar(Map[i]^, SizeOf(Map[i]^), 0)
    end;
  New(Mark);
  FillChar(Mark^, SizeOf(Mark^), False);
  Caption('ChÊm bµi: "Du lÞch nhiÒu tua nhÊt"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, tTour);
  Writeln('KiÓm tra sè Tour: ');
  Writeln('  + §¸p ¸n   : ', Count);
  Writeln('  + Häc sinh : ', tTour);
  if Count <> tTour then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Writeln('KiÓm tra c¸c tour: ');
  for i := 1 to tTour do
    begin
      Read(f, nPath);
      GotoXY(1, WhereY);
      Write('  KiÓm tra tour thø ', i, ' - sè ®Þa ®iÓm: ', nPath, '...');
      if (nPath < 3) or (nPath > n) then
        begin
          ClrEol;
          Writeln('Tour kh«ng hîp lÖ!');
          Wrong;
        end;
      for j := 1 to nPath do
        begin
          if SeekEoln(f) then
            begin
              ClrEol;
              Writeln('Sai khu«n d¹ng d÷ liÖu!');
              Wrong;
            end;
          Read(f, Path[j]);
          if (Path[j] < 1) or (Path[j] > n) then
            begin
              ClrEol;
              Writeln('Sai khu«n d¹ng d÷ liÖu!');
              Wrong;
            end;
        end;
      Path[nPath + 1] := Path[1];
      CheckPath(i);
      Readln(f);
      Write('  Tour hîp lÖ!     ');
    end;
  GotoXY(1, WhereY); ClrEol;
  Writeln('  TÊt c¶ c¸c tour ®Òu hîp lÖ!');
  Writeln;
  Writeln('KiÓm tra c¸c ®o¹n ®­êng riªng:');
  for u := 1 to n do
    for v := u + 1 to n do
      if Map[u]^[v] <> 0 then Mark^[Map[u]^[v]] := True;
  for i := 1 to tTour do
    begin
      Write('  Tour thø ', i, '...');
      if not Mark^[i] then
        begin
          Writeln('Kh«ng cã ®o¹n ®­êng riªng!');
          Wrong;
        end;
      Write('OK'#13);
    end;
  Writeln('  TÊt c¶ c¸c tour ®Òu cã ®o¹n ®­êng riªng!');
  Writeln;
  Writeln('KÕt qu¶ hoµn toµn chÝnh x¸c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Solve;
  Test;
end.
