program MaxNumber;
const
  InputFile  = 'NUMBER.INP';
  OutputFile = 'NUMBER.OUT';
  max = 201;
type
  TStr = string[max];
  TLine = array[0..max] of TStr;
  PLine = ^TLine;
var
  a, b: TStr;
  m, n: Integer;
  Current, Next: PLine;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, a);
  while a[1] = '0' do Delete(a, 1, 1);
  m := Length(a);
  Readln(f, b);
  while b[1] = '0' do Delete(b, 1, 1);
  n := Length(b);
  Close(f);
  New(Current); New(Next);
  FillChar(Current^, SizeOf(Current^), 0);
  FillChar(Next^, SizeOf(Next^), 0);
end;

function GetMax(s1, s2, s3: TStr): TStr;
var
  i, t: Integer;
  S: String;
begin
  t := Length(s1);
  if t < Length(s2) then t := Length(s2);
  if t < Length(s3) then t := Length(s3);
  if s1 <> '' then
    for i := Length(s1) + 1 to t do s1 := '0' + s1;
  if s2 <> '' then
    for i := Length(s2) + 1 to t do s2 := '0' + s2;
  if s3 <> '' then
    for i := Length(s3) + 1 to t do s3 := '0' + s3;
  S := s1;
  if S < s2 then S := s2;
  if S < s3 then S := s3;
  GetMax := S;
end;

procedure Optimize;
var
  t, i, j: Integer;
  s1, s2, s3: string;
  temp: PLine;
begin
  for j := 1 to n do Current^[j] := '0';
  for i := 1 to m do
    begin
      for j := 1 to n do
        if a[i] = b[j] then Next^[j] := Current^[j - 1] + b[j]
        else
            Next^[j] := GetMax(Next^[j - 1], Current^[j - 1], Current^[j]);
      temp := Current; Current := Next; Next := temp;
    end;
end;

procedure Result;
var
  S: String;
  f: Text;
begin
  S := Current^[n];
  while (Length(S) > 1) and (S[1] = '0') do Delete(S, 1, 1);
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, S);
  Close(f);
end;

begin
  Enter;
  Optimize;
  Result;
end.
123456781234
567812345678
