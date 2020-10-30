{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q-,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program TriangleAnalyses;
uses crt, visual;
const
  InputFile: String  = 'POLYGON.IN';
  OutputFile = 'POLYGON.OUT';
  max = 100;
  epsilon = 1E-3;
type
  Real = Double;
  TLine = array[1..max] of Real;
  PLine = ^TLine;
  TBoard = array[1..max] of PLine;
var
  n: Integer;
  d, b: TBoard;
  f, fout: Text;
  Lab, Ls, Lf: array[1..max] of Integer;
  X, Y: Array[1..max] of Real;
  ch: Char;
  res: Real;

procedure Enter;
var
  f: Text;
  X, Y: Array[1..max] of Real;
  i, j: Integer;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n);
  for i := 1 to n do
    begin
      New(d[i]); New(b[i]);
    end;
  for i := 1 to n do Readln(f, X[i], Y[i]);
  for i := 1 to n do
    for j := 1 to n do
      begin
        d[i]^[j] := Sqrt(Sqr(X[i] - X[j]) + Sqr(Y[i] - Y[j]));
      end;
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  for i := 1 to n - 2 do
    for j := i to i + 2 do b[i]^[j] := 0;
end;

procedure GetCut(i, j: Integer);
var
  t: Integer;
begin
  b[i]^[j] := b[i]^[j - 1] + d[i]^[j - 1];

  if b[i]^[j] > b[i + 1]^[j] + d[i + 1]^[j] then
    b[i]^[j] := b[i + 1]^[j] + d[i + 1]^[j];

  for t := i + 2 to j - 2 do
    if b[i]^[j] > b[i]^[t] + d[i]^[t] + b[t]^[j] + d[t]^[j] then
        b[i]^[j] := b[i]^[t] + d[i]^[t] + b[t]^[j] + d[t]^[j];
end;

procedure Optimize;
var
  i, j, k: Integer;
begin
  for k := 3 to n do
    for i := 1 to n - k do
      begin
        j := i + k;
        GetCut(i, j);
      end;
end;

procedure Result;
begin
  res := b[1]^[n];
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
  MSG(60, 3, 'TÊng', 'TÊng Æi”m Æang lµ ' + S + '/10');
end;

procedure Correct;
begin
  Visual.Color := 252;
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
  Caption('Bµi "Ph©n hoπch tam gi∏c"');
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
  sum, hsRes: Real;
  i: Integer;

  procedure Check(i: Integer);
  var
    j: Integer;
  begin
    for j := 1 to i - 1 do
      if (Ls[i] = Ls[j]) and (Lf[i] = Lf[j]) or
         (Ls[i] = Lf[j]) and (Lf[i] = Ls[j]) then
           begin
             Writeln('ß≠Íng ch–o ', i, ' vµ ', j, ' trÔng nhau!');
             Wrong;
           end;
  end;

  procedure CheckCut(k, p, q: Integer);
  var
    t, a, b, c: Real;
    i: Integer;
  begin
    a := y[q] - y[p]; b := x[p] - x[q];
    c := x[q] * y[p] - x[p] * y[q];
    for i := 1 to n do
      begin
        t := a * x[i] + b * y[i] + c;
        if t > epsilon then Lab[i] := 1
        else
          if t < -epsilon then Lab[i] := -1
          else Lab[i] := 0;
      end;
    for i := 1 to k - 1 do
      if Lab[Ls[i]] * Lab[Lf[i]] = -1 then
        begin
          Writeln('ßoπn th¯ ', i, ' cæt Æoπn th¯ ', k);
          Wrong;
        end;
  end;

begin
  Caption('Ch m bµi: "Ph©n hoπch tam gi∏c"');
  Visual.Color := 159;
  Frame(3, 7, 77, 23, 'Ki”m tra');
  Writeln('Tr‰ng sË ph–p ph©n hoπch: ');
  Assign(f, OutputFile); Reset(f);
  Readln(f, hsRes);
  Writeln('  + ß∏p ∏n:   ', res:1:3);
  Writeln('  + H‰c sinh: ', hsres:1:3);
  if hsres > res + epsilon then
    begin
      Writeln('K’t qu∂ kh´ng tËi ≠u!');
      Wrong;
    end;
  sum := 0;
  for i := 1 to n - 3 do
    begin
      Readln(f, Ls[i], Lf[i]);
      Check(i);
      sum := sum + d[Ls[i]]^[Lf[i]];
    end;
  Writeln('TÊng tr‰ng sË c∏c Æ≠Íng ch–o cÒa h‰c sinh: ', sum:1:3);
  if Abs(sum - hsres) > epsilon then
    begin
      Writeln('Ti“n hÀu b t nh t!');
      Wrong;
    end;
  for i := 2 to n - 3 do
    CheckCut(i, Ls[i], Lf[i]);
  Writeln('K’t qu∂ ÆÛng!');
  Correct;
end;

begin
  AskTest;
  Enter;
  Init;
  Optimize;
  Result;
  Test;
end.

