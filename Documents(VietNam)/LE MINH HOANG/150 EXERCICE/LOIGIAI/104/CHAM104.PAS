program MileStones;
uses crt, visual;
const
  InputFile: String  = 'MSTONE.IN';
  OutputFile = 'MSTONE.OUT';
  max = 200;
var
  a: array[1..max, 1..max] of Byte;
  Free: array[1..max] of Boolean;
  n: Integer;
  f, fOut: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, u, v, m: Integer;
begin
  FillChar(a, SizeOf(a), $FF);
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, u, v);
      a[u, v] := 0; a[v, u] := 0;
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
  Caption('Bµi "CÈt c©y sË"');
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
  u, v: Integer;
begin
  Caption('Ch m bµi: "CÈt c©y sË"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'Ki”m tra');
  Writeln('Ki”m tra hµnh tr◊nh:');
  Assign(f, OutputFile); Reset(f);
  Read(f, u); Write(u, ' ');
  if u <> 1 then
    begin
      Writeln(#13#10'N¨i xu t ph∏t sai!');
      Wrong;
    end;
  while not SeekEof(f) do
    begin
      Read(f, v); Write(v, ' ');
      if (v < 1) or (v > n) then
        begin
          Writeln(#13#10'Sai khu´n dπng d˜ li÷u!');
          Wrong;
        end;
      if a[u, v] = $FF then
        begin
          Writeln(#13#10'Gi˜a ', u, ' vµ ', v, ' kh´ng c„ Æ≠Íng!');
          Wrong;
        end;
      if a[u, v] = 1 then
        begin
          Writeln(#13#10' Nh˜ng cÈt tr™n tuy’n ', u, ' -> ', v,
                          ' bﬁ Æ∏nh sË hai l«n!');
          Wrong;
        end;
      a[u, v] := 1;
      u := v;
    end;
  if u <> 1 then
    begin
      Writeln(#13#10'N¨i k’t thÛc sai!');
      Wrong;
    end;
  Writeln;
  for u := 1 to n do
    for v := 1 to n do
      if a[u, v] = 0 then
        begin
          Writeln('Tuy’n ', u, ' -> ', v, ' ch≠a Æ≠Óc Æi“n sË');
          Wrong;
        end;
  Writeln('K’t qu∂ ÆÛng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Test;
end.
