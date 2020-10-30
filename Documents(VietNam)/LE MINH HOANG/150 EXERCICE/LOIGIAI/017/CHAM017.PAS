{$R-,S-,Q-}
program TestBoard;
uses Crt, Visual;
const
  InputFile: String = 'BOARD.IN';
  OutputFile = 'BOARD.OUT';
  max = 80;
var
  a: array[0..max - 1, 0..max - 1] of Integer;
  m, n: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 0 to m - 1 do
    begin
      for j := 0 to n - 1 do Read(f, a[i, j]);
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
  Caption('Bµi ""');
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

procedure Test;
var
  t, x, y, x1, y1, x2, y2: Integer;
  i: LongInt;
begin
  Caption('Ch m bµi 017: "X’p lπi b∂ng sË"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Writeln('Ki”m tra c∏c ph–p chuy”n:');
  Assign(f, OutputFile); Reset(f);
  i := 0;
  while not SeekEof(f) do
    begin
      Inc(i);
      Readln(f, x1, y1, x2, y2);

      Write('  Dﬂng: ', i:5, '    (',
                   x1, ', ', y1, ')  <->  (', x2, ', ', y2, ')                    ');
      if (x1 < 0) or (x1 >= m) or (x2 < 0) or (x2 >= m)
         or (y1 < 0) or (y1 >= n) or (y2 < 0) or (y2 >= n) then
           begin
             Writeln;
             Writeln('LÁi! Toπ ÆÈ ´ kh´ng hÓp l÷!');
             Wrong;
           end;
      if Abs(x1 - x2) * Abs(y1 - y2) <> 2 then
        begin
          Writeln;
          Writeln('LÁi! M∑ nh∂y ki”u Ûc!');
          Wrong;
        end;
      t := a[x1, y1]; a[x1, y1] := a[x2, y2]; a[x2, y2] := t;
      Write(#13);
    end;
  ClrEol;
  Writeln('  C∏c ph–p chuy”n hÓp l÷!');
  Writeln;
  Writeln('Ki”m tra b∂ng k’t qu∂!');
  for x := 0 to m - 1 do
    for y := 0 to n - 1 do
      if a[x, y] <> x * n + y then
        begin
          Writeln('    + SË ghi Î ´ (', x, ', ', y, ') = ', a[x, y]);
          Writeln('    + SË c«n ghi: ', x * n + y);
          Writeln('  B∂ng k’t qu∂ kh´ng ÆÛng!');
          Wrong;
        end;
  Writeln('  B∂ng k’t qu∂ ch›nh x∏c!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Test;
end.
