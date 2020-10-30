{$R-,S-,Q-}
program Thetour;
uses crt, visual;
const
  InputFile: String  = 'TOUR.IN';
  OutputFile = 'TOUR.OUT';
  max = 100;
  maxLong = 1000000001;
type
  TDistance = array[1..max, 1..max] of LongInt;
  PDistance = ^TDistance;
var
  c: TDistance;
  d: PDistance;
  Trace: array[1..max] of Byte;
  res, n, Start, Finish: Integer;
  minCost: LongInt;
  f: Text;
  ch: Char;

procedure Enter;
var
  i, m, x, y, t: LongInt;
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for x := 1 to n do
    for y := 1 to n do
      if x = y then c[x, y] := 0
      else c[x, y] := maxLong;
  for i := 1 to m do
    begin
      Readln(f, x, y, t);
      if c[x, y] > t then
        begin
          c[x, y] := t;
          c[y, x] := t;
        end;
    end;
  Close(f);
end;

procedure Floyd;
var
  u, v, k: Integer;
begin
  New(d);
  d^ := c;
  for k := 1 to n do
    for u := 1 to n do
      for v := 1 to n do
        if d^[u, v] > d^[u, k] + d^[k, v] then
          d^[u, v] := d^[u, k] + d^[k, v];
end;

function Dijkstra(S, T: Integer): LongInt;
var
  d: array[1..max] of LongInt;
  OpSet: array[1..max] of Byte;
  p, u, v, umin, nSet, tmp: Integer;
begin
  for u := 1 to n do d[u] := maxLong;
  d[S] := 0; OpSet[1] := S; nSet := 1;
  repeat
    umin := 1;
    for u := 1 to nSet do
      if d[OpSet[u]] < d[OpSet[umin]] then umin := u;
    p := OpSet[umin];
    OpSet[umin] := OpSet[nSet];
    Dec(nSet);
    for v := 1 to n do
      if d[v] > d[p] + c[p, v] then
        begin
          if d[v] = maxLong then
            begin
              Inc(nSet);
              OpSet[nSet] := v;
            end;
          d[v] := d[p] + c[p, v];
          Trace[v] := p;
        end;
  until nSet = 0;
  Dijkstra := d[T];
end;

procedure Solve;
var
  u, v: Integer;
  Cost, SaveC: LongInt;
begin
  minCost := maxLong;
  for u := 1 to n do
    for v := u + 1 to n do
      if c[u, v] + d^[v, u] < minCost then
        begin
          if d^[v, u] <> c[v, u] then Cost := c[u, v] + d^[v, u]
          else
            begin
              SaveC := c[u, v];
              c[u, v] := maxLong;
              Cost := SaveC + Dijkstra(u, v);
              c[u, v] := SaveC;
            end;
          if minCost > Cost then
            begin
              minCost := Cost;
              Start := u; Finish := v;
            end;
        end;
end;

procedure Result;
begin
  if minCost = maxLong then res := 0
  else res := 1;
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
  Caption('Bµi "Tua du lÞch rÎ nhÊt"');
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
  u, v, l1, nPath, i, s: Integer;
  cc, cost: LongInt;
  Mark: array[1..max] of Boolean;
begin
  Caption('ChÊm bµi: "Tua du lÞch rÎ nhÊt"');
  Visual.Color := 159;
  FlatFrame(3, 7, 78, 23, 'KiÓm tra');
  Assign(f, OutputFile); Reset(f);
  Readln(f, l1);
  Writeln('Dßng 1: ');
  Writeln('  + §¸p ¸n  : ', Res);
  Writeln('  + Häc sinh: ', l1);
  if l1 <> Res then
    begin
      Writeln('KÕt qu¶ sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ ®óng!');
  if Res = 0 then Correct;
  Readln(f, cost);
  Writeln('Chi phÝ cña Tour: ');
  Writeln('  + §¸p ¸n  : ', MinCost);
  Writeln('  + Häc sinh: ', cost);
  if cost > MinCost then
    begin
      Writeln('Kh«ng tèi ­u!');
      Wrong;
    end;
  FillChar(Mark, SizeOf(Mark), False);
  Readln(f, nPath);
  Read(f, u);
  if (u < 1) or (u > n) then
    begin
      Writeln('Sai khu«n d¹ng d÷ liÖu!');
      Wrong;
    end;
  Mark[u] := True;
  s := u; cc := 0;
  for i := 1 to nPath - 1 do
    begin
      Read(f, v);
      if (v < 1) or (v > n) then
        begin
          Writeln('Sai khu«n d¹ng d÷ liÖu!');
          Wrong;
        end;
      if Mark[v] then
        begin
          Writeln('§i lÆp ®Þa ®iÓm ', v);
          Wrong;
        end;
      if c[u, v] = maxLong then
        begin
          Writeln('§i ®­êng rõng ', u, ' -> ', v);
          Wrong;
        end;
      cc := cc + c[u, v];
      u := v;
      Mark[v] := True;
    end;
  if c[u, s] = maxLong then
    begin
      Writeln('§i ®­êng rõng ', u, ' -> ', s);
      Wrong;
    end;
  cc := cc + c[u, s];
  Writeln('Chi phÝ tÝnh theo hµnh tr×nh: ', cc);
  if cc <> cost then
    begin
      Writeln('TÝnh tæng sai!');
      Wrong;
    end;
  Writeln('KÕt qu¶ chÝnh x¸c!');
  Correct;
end;

begin
  Asktest;
  Enter;
  Floyd;
  Solve;
  Result;
  Test;
end.
5 5
1 3 2
2 4 2
3 5 2
4 1 2
5 2 2
1 2 3
2 3 3
3 4 3
4 5 3
5 1 3
