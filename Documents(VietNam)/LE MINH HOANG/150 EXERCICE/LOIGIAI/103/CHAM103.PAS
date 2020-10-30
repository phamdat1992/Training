{$R-,S-,Q-,D-}
program Tourism;
uses crt, visual;
const
  InputFile: String = 'CIRCUIT.IN';
  OutputFile = 'CIRCUIT.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Byte;
  Trace: array[1..max] of Integer;
  Mark: array[1..max] of Boolean;
  n, Start, Finish: Integer;
  Res: String;
  ch: Char;
  f: Text;

procedure Enter;
var
  f: Text;
  u, v: Integer;
begin
  FillChar(a, SizeOf(a), 0);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, Start);
  while not SeekEof(f) do
    begin
      Readln(f, u, v);
      a[u, v] := 1; a[v, u] := 1;
    end;
  Close(f);
end;

procedure Init;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  Trace[Start] := -1;
  Finish := 0;
end;

procedure Visit(u: Integer);
var
  v: Integer;
begin
  for v := 1 to n do
    if a[u, v] = 1 then
      begin
        a[v, u] := 0;
        if Trace[v] = 0 then
          begin
            Trace[v] := u;
            Visit(v);
          end
        else
          if v = Start then Finish := u;
        if Finish <> 0 then Exit;
      end;
end;

procedure Result;
begin
  if Finish = 0 then Res := 'NO' else Res := 'YES';
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
  s: String[1];
begin
  Caption('Bµi "Chu tr×nh c¬ b¶n"');
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
  T: String;
  u, v: Integer;
begin
  Caption('ChÊm bµi: "Chu tr×nh c¬ b¶n"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Enter;
  Assign(f, OutputFile); Reset(f);
  Readln(f, T);
  Writeln('Dßng ®Çu tiªn: ');
  Writeln('  + §¸p ¸n  : ', Res);
  Writeln('  + Häc sinh: ', T);
  if Res <> T then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  if Res = 'NO' then Correct;
  Writeln;
  Read(f, u);
  if u <> Start then
    begin
      Writeln('N¬i xuÊt ph¸t sai!');
      Wrong;
    end;
  FillChar(Mark, SizeOf(Mark), False);
  while not SeekEoln(f) do
    begin
      Read(f, v);
      if (v < 1) or (v > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      if Mark[v] then
        begin
          Writeln('§Þa ®iÓm ', v, ' bÞ ®i lÆp!');
          Wrong;
        end;
      if a[u, v] = 0 then
        begin
          Writeln('Gi÷a ', u, ' vµ ', v, ' kh«ng cã ®­êng!');
          Wrong;
        end;
      if a[u, v] = 2 then
        begin
          Writeln(' §­êng (', u, ', ', v, ') bÞ ®i lÆp!');
          Wrong;
        end;
      a[u, v] := 2; a[v, u] := 2;
      Mark[v] := True;
      u := v;
    end;
  if v <> Start then
    begin
      Writeln('Kh«ng quay trë vÒ n¬i xuÊt ph¸t!');
      Wrong;
    end;
  Writeln('Chu tr×nh hîp lÖ!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Visit(Start);
  Result;
  Test;
end.
7 1
1 2
2 3
3 4
1 5
5 6
6 7
