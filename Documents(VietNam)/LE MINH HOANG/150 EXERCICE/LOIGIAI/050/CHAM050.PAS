{$R-,S-,Q-,I-}
program MaxSquare;
uses crt, visual;
const
  InputFile: String = 'SQUARE.IN';
  OutputFile = 'SQUARE.OUT';
  max = 1000;
var
  m, n, maxSize: Integer;
  Line: array[1..max] of Integer;
  Column: array[1..max] of Integer;
  f: Text;
  ch: Char;

procedure Init;
begin
  FillChar(Line, SizeOf(Line), $FF);
  maxSize := 1;
end;

procedure Solve;
var
  f: Text;
  i, j, Count, Data: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, Data);
          if Data <> Line[j] then Column[j] := 1
          else Inc(Column[j]);
          Line[j] := Data;
        end;
      Readln(f);
      Count := 0;
      for j := 1 to n do
        if Column[j] <= maxSize then Count := 0
        else
          if Line[j] <> Line[j - 1] then Count := 1
          else
           begin
             Inc(Count);
             if Count > maxSize then
               begin
                 Inc(maxSize);
                 Break;
               end;
           end;
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
  Caption('Bµi ');
  MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: ' + InputFile + '  '#8#8);
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

procedure Test;
var
  s: LongInt;
  c, i, j, x1, y1, x2, y2, data: Integer;
begin
  Caption('ChÊm bµi: "');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, s);
  Writeln('KÝch th­íc c¹nh h×nh vu«ng: ');
  Writeln('  + §¸p ¸n  : ', maxSize);
  Writeln('  + Häc sinh: ', s);
  if s <> maxSize then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!'#13#10);
  Readln(f, x1, y1, x2, y2);
  Close(f);
  Writeln('KiÓm tra tÝnh hîp lÖ: ');
  Assign(f, InputFile); Reset(f);
  Readln(f);
  c := -1;
  for i := 1 to m do
    begin
      for j := 1 to n do
        begin
          Read(f, data);
          if (x1 <= i) and (i <= x2) and (y1 <= j) and (j <= y2) then
            begin
              if (c <> -1) and (data <> c) then
                begin
                  Writeln('  + H×nh kh«ng hîp lÖ!');
                  Wrong;
                end;
              c := data;
            end;
        end;
      Readln(f);
    end;
  Close(f);
  Writeln('  + H×nh hîp lÖ!');
  Correct;
end;

begin
  AskTest;
  Init;
  Solve;
  Test;
end.
