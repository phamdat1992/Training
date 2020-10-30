{$A+,B-,D+,E+,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program ScholarShip;
uses crt, visual;
const
  InputFile: string = 'SCHOLAR.IN';
  OutputFile = 'SCHOLAR.OUT';
  max = 200;
type
  Real = Double;
  TStudent = record
    Name: string[25];
    Mark: Real;
  end;
  TList = array[1..max] of TStudent;
var
  a, b: TList;
  n, m, i: Integer;
  Threshold: Real;
  tmp: TStudent;
  ch: Char;
  f: Text;

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
  Caption('Bµi 134: "SholarShip"');
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

procedure InsertionSort(var x: TList);
var
  i, j: Integer;
  tmp: TStudent;
begin
  for i := 2 to m do
    begin
      tmp := x[i]; j := i - 1;
      while (j > 0) and (x[j].Name > tmp.Name) do
        begin
          x[j + 1] := x[j];
          Dec(j);
        end;
      x[j + 1] := tmp;
    end;
end;

procedure Test;
var
  i, hsm: Integer;
begin
  Caption('ChÊm bµi 134: "ScholarShip"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  hsm := 0;
  while not SeekEof(f) do
    begin
      Inc(hsm); Readln(f, b[hsm].Name);
    end;
  Writeln('Sè ng­êi ®­îc häc bæng: ');
  Writeln('  + §¸p ¸n  : ', m);
  Writeln('  + Häc sinh: ', hsm);
  if hsm <> m then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  InsertionSort(a);
  InsertionSort(b);
  Writeln('Danh s¸ch cña häc sinh (sau khi ®· Sort):');
  for i := 1 to m do
    begin
      Writeln(i:5, ') ', b[i].Name);
      if b[i].Name <> a[i].Name then
        begin
          Writeln('Cßn ng­êi ', a[i].Name, ' (', a[i].Mark:1:2,
                       ') ®Ó ®i ®©u?');
          Wrong;
        end;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  ThresHold := -2E38; m := 0;
  for i := 1 to n do
    begin
      Readln(f, tmp.Name);
      Readln(f, tmp.Mark);
      if tmp.Mark > ThresHold then
        begin
          ThresHold := tmp.Mark;
          m := 1; a[1] := tmp;
        end
      else
        if tmp.Mark = ThresHold then
          begin
            Inc(m); a[m] := tmp;
          end;
    end;
  Close(f);
  Test;
end.
4
a
7.9
b
9.0
c
8.1
d
9.0