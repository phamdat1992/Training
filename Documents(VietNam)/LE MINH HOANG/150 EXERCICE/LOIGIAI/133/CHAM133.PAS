program Sequence;
uses crt, visual;
const
  InputFile: string = 'SZERO.IN';
  OutputFile = 'SZERO.OUT';
  max = 10000;
var
  t: array[0..max] of LongInt;
  id: array[0..max] of Integer;
  n, resL, resR, res: Integer;
  f: Text;
  ch: Char;

procedure Enter;
var
  f: Text;
  i, a: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  t[0] := 0; id[0] := 0;
  for i := 1 to n do
    begin
      Read(f, a);
      t[i] := t[i - 1] + a;
      id[i] := i;
    end;
  Close(f);
end;
{$R-,Q-}
function Lower(id1, id2: Integer): Boolean;
begin
  Lower := (t[id1] < t[id2]) or
           (t[id1] = t[id2]) and (id1 < id2);
end;

procedure HeapSort;
var
  i, temp: Integer;

  procedure Adjust(root, endnode: Integer);
  var
    c, k: Integer;
  begin
    k := id[root];
    while (root shl 1 + 1) <= endnode do
      begin
        c := (root shl 1 + 1);
        if (c < endnode) and Lower(id[c], id[c + 1]) then Inc(c);
        if Lower(id[c], k) then Break;
        id[root] := id[c];
        root := c;
      end;
    id[root] := k;
  end;

begin
  for i := n div 2 downto 0 do Adjust(i, n);
  for i := n - 1 downto 0 do
    begin
      temp := id[0]; id[0] := id[i + 1]; id[i + 1] := temp;
      Adjust(0, i);
    end;
end;

procedure Solve;
var
  i, j: Integer;
begin
  res := 0;
  i := 0;
  repeat
    j := i;
    while (j < n) and (t[id[j + 1]] = t[id[i]]) do Inc(j);
    if id[j] - id[i] > res then
      begin
        resL := id[i]; resR := id[j]; res := id[j] - id[i];
      end;
    i := j + 1;
  until i > n;
  Inc(resL);
end;
{$R+,Q+}
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
  Caption('Bµi 133: "LONGEST ZERO SEGMENT"');
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
  hsL, hsR: Integer;
begin
  Caption('ChÊm bµi 133: "LONGEST ZERO SEGMENT"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsL, hsR);
  Writeln('KiÓm tra ®o¹n liªn tiÕp t×m ®­îc:');
  Writeln('  + §¸p ¸n  : tõ a[', resL, '] ®Õn a[', resR, ']; ®é dµi: ', res);
  Writeln('  + Häc sinh: tõ a[', hsL, '] ®Õn a[', hsR, ']; ®é dµi: ',
               hsR - hsL + 1);
  if (hsL < 1) or (hsL > n) or (hsR < 1) or (hsR > n) then
    begin
      Writeln('Sai khu«n d¹ng Output!');
      Wrong;
    end;
  if hsR - hsL + 1 < res then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  Writeln('Tæng c¸c sè trong ®o¹n cña häc sinh: ', t[hsR] - t[hsL - 1]);
  if t[hsR] <> t[hsL - 1] then
    begin
      Writeln('Kh«ng ®óng yªu cÇu!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  HeapSort;
  Solve;
  Test;
end.
9
2 7 5 -3 -2 4 -9 -2 -1

7
0 0 0 0 0 0 0 0