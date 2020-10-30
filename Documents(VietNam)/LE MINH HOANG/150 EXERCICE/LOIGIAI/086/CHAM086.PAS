{$R-,S-,D-,I-,Q-}
program CityRoad;
uses crt, visual;
const
 InputFile: String  = 'CITY.IN';
 OutputFile = 'CITY.OUT';
 max = 200;
 maxC = 2000000001;
type
 TLine  = array[1..max] of LongInt;
var
 c, d: array[1..max] of ^TLine;
 a: array[1..max, 1..max] of Boolean;
 n: Integer;
 Total: LongInt;
 f: Text;
 ch: Char;

procedure Enter;
var
 f: Text;
 i, m, u, v: Integer;
begin
 Assign(f, InputFile); Reset(f);
 Readln(f, n, m);
 FillChar(a, SizeOf(a), False);
 for u := 1 to n do
  begin
   New(c[u]);
   for v := 1 to n do
    if u = v then c[u]^[v] := 0 else c[u]^[v] := maxC;
  end;
 for i := 1 to m do
  begin
   Readln(f, u, v, c[u]^[v]);
   c[v]^[u] := c[u]^[v];
   a[u, v] := True; a[v, u] := True;
  end;
 Close(f);
end;

procedure Floyd;
var
 k, u, v: Integer;
begin
 for k := 1 to n do
  for u := 1 to n do
   if (u <> k) and (c[u]^[k] <> maxC) then
    for v := u + 1 to n do
     if (k <> v) and (c[k]^[v] <> maxC) and
        (c[u]^[v] >= c[u]^[k] + c[k]^[v]) then
      begin
       c[u]^[v] := c[u]^[k] + c[k]^[v];
       c[v]^[u] := c[u]^[v];
       a[u, v] := False;
       a[v, u] := False;
      end;
end;

procedure Result;
var
 u, v: Integer;
begin
 Total := 0;
 for u := 1 to n do
  for v := u + 1 to n do
   if a[u, v] then
     Total := Total + c[u]^[v];
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
 Assign(f, 'POINT.TXT'); Rewrite(f);
 Write(f, p);
 Close(f);
end;

function ReadP: Integer;
var
 f: file of Integer;
 P: Integer;
begin
 Assign(f, 'POINT.TXT'); Reset(f);
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
 Color := 30;
 MSG(60, 3, 'Tæng', 'Tæng ®iÓm ®ang lµ ' + S + '/10');
end;

procedure Correct;
begin
 Color := 47;
 MSG(20, 3, InputFile, '   B¹n cã 1 ®iÓm   ');
 WriteP(ReadP + 1);
 ShowP;
 if ReadP = 10 then
  Logo('§óng hÕt c¸c test', 'Perfect! Perfect!');
 Halt;
end;

procedure Wrong;
begin
 Color := 78;
 MSG(20, 3, InputFile, '   B¹n cã 0 ®iÓm   '#7);
 ShowP;
 Halt;
end;

procedure AskTest;
begin
 Caption('Bµi 086: Thµnh phè trªn sao Ho¶');
 MSG(40, 3, 'Input?', 'Cho tªn file d÷ liÖu: CITY.IN  '#8#8);
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
 i, m, u, v, k: Integer;
 T, Sum: LongInt;
begin
 Caption('ChÊm bµi 086: "Thµnh phè trªn sao Ho¶"');
 Visual.Color := 159;
 Frame(5, 8, 75, 23, 'KiÓm tra'); Writeln;
 Assign(f, OutputFile); Reset(f);
 Readln(f, m, T);
 Writeln('Tæng ®é dµi c¸c ®o¹n ®­êng gi÷ l¹i: ');
 Writeln('  + §¸p ¸n:   ', Total);
 Writeln('  + Häc sinh: ', T);
 if T > Total then
  begin
   Writeln('KÕt qu¶ sai!');
   Wrong;
  end
 else
  if T < Total then Writeln('Tèt h¬n ®¸p ¸n!')
  else Writeln('Tåi nh­ ®¸p ¸n!');
 for u := 1 to n do  d[u] := c[u];
 Enter;
 Sum := 0;
 for i := 1 to m do
  begin
   Readln(f, u, v);
   Sum := Sum + c[u]^[v];
   c[u]^[v] := -c[u]^[v];
   c[v]^[u] := -c[v]^[u];
  end;
 if Sum <> T then
  begin
   Writeln('TÝnh tæng sai!');
   Wrong;
  end;
 for u := 1 to n do
  for v := 1 to n do
   if c[u]^[v] > 0 then c[u]^[v] := maxC
   else c[u]^[v] := -c[u]^[v];
 for k := 1 to n do
  for u := 1 to n do
   if (u <> k) and (c[u]^[k] <> maxC) then
    for v := u + 1 to n do
     if (k <> v) and (c[k]^[v] <> maxC) and
      (c[u]^[v] > c[u]^[k] + c[k]^[v]) then
       begin
        c[u]^[v] := c[u]^[k] + c[k]^[v];
        c[v]^[u] := c[u]^[v];
       end;
 for u := 1 to n do
  for v := 1 + u to n do
   if d[u]^[v] <> c[u]^[v] then
    begin
     Writeln('§é dµi ®­êng ®i ng¾n nhÊt gi÷a ', u, ' vµ ', v, ' kh«ng ®óng:');
     Writeln('  + §é dµi ban ®Çu    : ', d[u]^[v]);
     Writeln('  + §é dµi sau khi söa: ', c[u]^[v]);
     Wrong;
    end;
 Writeln('KÕt qña ®óng! §é dµi c¸c ®­êng ®i ng¾n nhÊt ®­îc b¶o toµn!');
 Correct;
end;

begin
 AskTest;
 Enter;
 Floyd;
 Result;
 Test;
end.

10 12
1 2 1
1 5 1
2 6 7
3 4 1
3 7 2
4 8 8
5 6 3
6 7 1
6 9 2
7 8 5
7 10 8
9 10 4

10 13
1 2 1
2 3 1
3 4 1
1 4 3
4 5 1
5 6 1
6 7 1
4 7 3
7 8 1
8 9 2
9 10 3
7 10 6
1 10 12
