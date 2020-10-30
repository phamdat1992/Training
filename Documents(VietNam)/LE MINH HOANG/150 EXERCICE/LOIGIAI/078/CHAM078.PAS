program Cham078;
uses crt, visual;
const
  InputFile: String = 'CHAIN.IN';
  OutputFile = 'CHAIN.OUT';
var
  f1, f2: Text;
  ch: Char;

procedure Halt;
begin
  {$I-}
  Close(f1); if IOResult = 0 then;
  Close(f2); if IOResult = 0 then;
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
  Caption('Bµi "D©y xÝch"');
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
type
  TList = array[1..10000] of Integer;
var
  Mark, Lab: ^TList;
  u, v, i, n: Integer;
begin
  Caption('ChÊm bµi: "D©y xÝch"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  New(Lab); New(Mark);
  FillChar(Lab^, SizeOf(Lab^), 0);
  Assign(f1, InputFile); Reset(f1);
  Readln(f1, n);
  Assign(f2, OutputFile); Reset(f2);
  Writeln('KiÓm tra nh·n (Sè ghi trong ngoÆc lµ nh·n)');
  for i := 1 to n do
    begin
      Read(f2, Lab^[i]);
      if (Lab^[i] <= 0) or (Lab^[i] > n) then
        begin
          Writeln('  + Cã nh·n Lab[', i, '] = ', Lab^[i]);
          Wrong;
        end;
    end;
  Close(f2);
  FillChar(Mark^, SizeOf(Mark^), 0);
  for i := 1 to n do
    if Mark^[Lab^[i]] <> 0 then
      begin
        Writeln('  + §Ønh ', Mark^[Lab^[i]], ' vµ', i, ' ®Òu cã nh·n ', Lab^[i]);
        Wrong;
      end
    else
      Mark^[Lab^[i]] := i;
  FillChar(Mark^, SizeOf(Mark^), 0);
  for i := 1 to n - 1 do
    begin
      Readln(f1, u, v);
      Writeln(i:5, '. C¹nh: ', u, '(', Lab^[u], ')-',
                               v, '(', Lab^[v], ')');
      if Mark^[Abs(Lab^[u] - Lab^[v])] <> 0 then
        begin
          Writeln('  + Cã hai c¹nh mµ chªnh lÖch hai ®Çu mót ®Òu lµ: ',
                    Abs(Lab^[u] - Lab^[v]));
          Wrong;
        end
      else
        Mark^[Abs(Lab^[u] - Lab^[v])] := 1;
    end;
 Writeln('Tèt');
 Correct;
end;

begin
  AskTest;
  Test;
end.
