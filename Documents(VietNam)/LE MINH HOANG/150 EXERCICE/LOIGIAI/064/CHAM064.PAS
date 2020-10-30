program MinWStr;
uses crt, visual;
const
  InputFile: String  = 'STR.IN';
  OutputFile = 'STR.OUT';
  ReportFile = 'BIENBAN.TXT';
  maxN = 100;
  maxLong = 1000000000;
  maxNode = 1092; {0..maxNode: (3^7-1) / 2 Nodes}
  max5 = 242;  {3^5 - 1}
  max6 = 728;  {3^6 - 1}
  cChar: array[0..2] of Char = 'IWN';
type
  TLine = array[0..max5] of LongInt;
  PLine = ^TLine;
  TTrace = array[6..maxN, 0..max5] of Integer;
  PTrace = ^TTrace;
var
  Tree: array[0..maxNode] of Word;
  IsNode: array[0..maxNode] of Boolean;
  Gen56, Gen55: array[0..max5, 0..2] of Integer;
  c: array[0..max6] of LongInt;
  F, G: PLine;
  Trace: PTrace;
  Result: String;
  n, m, p: Integer;
  minSpending: LongInt;
  fout, fr: Text;
  ch: Char;

procedure InitTree;
var
  i: Integer;
begin
  for i := 1 to maxNode do IsNode[i] := False;
  IsNode[0] := True;
  Tree[0] := 0;
end;

procedure AddToTree(Value, Len: Integer; C: Word);
var
  p, q, k: Integer;
  i: Integer;
begin
  p := 0;
  for i := 1 to Len do
    begin
      k := Value mod 3 + 1;
      q := p * 3 + k; {p * 3 + k}
      if not IsNode[q] then IsNode[q] := True;
      p := q;
      Value := Value div 3;
    end;
  Tree[p] := C;
end;

function Convert(k, Len: Integer): string; {Chuyen so k thanh xau WIN}
var
  S: String;
  i: Integer;
begin
  S := '';
  for i := 1 to Len do
    begin
      S := cChar[k mod 3] + S;
      k := k div 3;
    end;
  Convert := S;
end;

function BackConvert(S: String): Integer; {Chuyen xau WIN thanh so}
var
  V, i: Integer;
begin
  V := 0;
  for i := 1 to Length(S) do
    case S[i] of
      'I': V := V * 3;
      'W': V := V * 3 + 1;
      'N': V := V * 3 + 2;
    end;
  BackConvert := V;
end;

procedure Enter;
var
  f: Text;
  i, j, V: Integer;
  S: String;
  c: LongInt;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to m do
    begin
      Readln(f, S);
      Readln(f, c);
      AddToTree(BackConvert(S), Length(S), c);
    end;
  Close(f);
end;

function GetSpendingAtEnd(V, EndPost: Integer): LongInt;
var
  i, P, Q, k: Integer;
  Spending: LongInt;
begin
  Spending := 0;
  P := 0;
  for i := EndPost downto 1 do
    begin
      k := V mod 3 + 1;
      Q := P * 3 + k;
      if (Q > maxNode) or not IsNode[Q] then Break;
      Spending := Spending + Tree[Q];
      P := Q;
      V := V div 3;
    end;
  GetSpendingAtEnd := Spending;
end;

function GetSpending(V, Len: Integer): LongInt;
var
  i: Integer;
  Spending: LongInt;
begin
  Spending := 0;
  for i := Len downto 1 do
    begin
      Spending := Spending + GetSpendingAtEnd(V, i);
      V := V div 3;
    end;
  GetSpending := Spending;
end;

procedure Init;
const
  Divisor = 243;
var
  i, j: Integer;
begin
  for i := 0 to max5 do
    for j := 0 to 2 do
      begin
        Gen56[i, j] := i * 3 + j;
        Gen55[i, j] := Gen56[i, j] mod Divisor;
      end;
  for i := 0 to max6 do c[i] := GetSpendingAtEnd(i, 6);
  New(F); New(G);
  New(Trace);
end;

procedure Solve;
var
  maxArr: TLine;
  i, j, k, jmin, p, Limit: Integer;
  t: LongInt;
  tmp: PLine;
begin
  minSpending := maxLong;
  if n <= 5 then
    begin
      Limit := Round(Exp(Ln(3) * n));
      for i := 0 to Limit - 1 do
        begin
          t := GetSpending(i, n);
          if t < minSpending then
            begin
              Result := Convert(i, n);
              minSpending := t;
            end;
        end;
      Exit;
    end;
  for j := 0 to max5 do
    begin
      F^[j] := GetSpending(j, 5);
      maxArr[j] := maxLong;
    end;
  for i := 6 to n do
    begin
      G^ := maxArr;
      for j := 0 to max5 do
        for k := 0 to 2 do
          begin
            p := Gen55[j, k];
            if G^[p] > F^[j] + c[Gen56[j, k]] then
              begin
                G^[p] := F^[j] + c[Gen56[j, k]];;
                Trace^[i, p] := j;
              end;
          end;
      tmp := F; F := G; G := tmp;
    end;
  minSpending := maxLong;
  for j := 0 to max5 do
    if F^[j] < minSpending then
      begin
        minSpending := F^[j];
        jmin := j;
      end;
  Result := '';
  for i := n downto 6 do
    begin
      Result := cChar[jmin mod 3] + Result;
      jmin := Trace^[i, jmin];
    end;
  Result := Convert(jmin, 5) + Result;
end;

function GetCS(S: String): LongInt;
var
  V, i: Integer;
  ST: String;
  C, t: LongInt;
begin
  ST := ''; C := 0;
  for i := 1 to Length(S) do
    begin
      ST := ST + S[i];
      if Length(ST) > 6 then Delete(ST, 1, 1);
      V := BackConvert(ST);
      t := GetSpendingAtEnd(V, Length(St));
      C := C + t;
    end;
  GetCS := C;
end;

procedure Halt;
begin
  {$I-}
  Close(fout); if IOResult = 0 then;
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
  Caption('Bµi "Tr‰ng sË x©u"');
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
  t, YourResult: LongInt;
  S: String;
  j: Integer;
begin
  Caption('Ch m bµi: "Tr‰ng sË x©u"');
  Visual.Color := 159;
  Frame(3, 7, 77, 23, 'Ki”m tra');
  Assign(fout, OutputFile); Reset(fout);
  Readln(fout, YourResult);
  Readln(fout, S);
  Writeln('  + Ket qua dung: ', minSpending);
  Writeln('  + Ket qua HS  : ', YourResult);
  if YourResult <> minSpending then
    begin
      Writeln('Error: Chi phi sai');
      Wrong;
    end;
  Writeln('Xau cua hoc sinh: ');
  Writeln(S);
  t := GetCS(S);
  Writeln('  + Chi phi cua xau tren la: ', t);
  Writeln('  + Hoc sinh tinh ra la    : ', YourResult);
  if t <> YourResult then
    begin
      Writeln('Error: Tinh chi phi cua xau sai');
      Wrong;
    end;
  Writeln('Correct!');
  Correct;
end;

begin
  AskTest;
  InitTree;
  Enter;
  Init;
  Solve;
  Test;
end.


