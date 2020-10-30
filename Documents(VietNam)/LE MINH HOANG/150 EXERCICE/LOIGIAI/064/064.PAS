program MinWStr;
const
  InputFile  = 'STR.INP';
  OutputFile = 'STR.OUT';
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
  n, m: Integer;
  minSpending: LongInt;

  Start: LongInt;
  Time: LongInt absolute 0:$46C;

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

procedure PrintResult;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, MinSpending);
  Writeln(f, Result);
  Close(f);
end;

begin
  InitTree;
  Enter;
  Start := Time;
  Init;
  Solve;
  Writeln('Time = ', (Time - Start)/18.2:1:2,' (s)');
  PrintResult;
end.
