program Bracket;
const
  InputFile  = 'BRACKET.IN0';
  OutputFile = 'BRACKET.OUT';
  max = 200;
  CharCode: String[4] = '[()]';
type
  TBoard = array[1..200, 1..200] of Byte;
  PBoard = ^TBoard;
var
  n: Integer;
  S: String;
  a: array[1..max] of Integer;
  b: TBoard;
  Trace: PBoard;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, S);
  n := Length(S);
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  for i := 1 to Length(S) do
    case S[i] of
      '[': a[i] := 1;
      ']': a[i] := 4;
      '(': a[i] := 2;
      ')': a[i] := 3;
    end;
  for i := 1 to n do
    for j := 1 to n do
      if i > j then b[i, j] := 0
      else
        if i = j then b[i, j] := 1
        else b[i, j] := 255;
  New(Trace);
  FillChar(Trace^, SizeOf(Trace^), 0);
end;

function GetNumber(i, j: Integer): Byte;
var
  k: Integer;
begin
  if b[i, j] = 255 then
    begin
      if (a[i] <= 2) and (a[i] + a[j] = 5) then
        begin
          b[i, j] := GetNumber(i + 1, j - 1);
          Trace^[i, j] := 255;
        end;
      for k := i to j - 1 do
        if b[i, j] > GetNumber(i, k) + GetNumber(k + 1, j) then
          begin
            b[i, j] := GetNumber(i, k) + GetNumber(k + 1, j);
            Trace^[i, j] := k;
          end;
    end;
  GetNumber := b[i, j];
end;

procedure Result;
var
  f: Text;

  procedure GetTrace(i, j: Integer);
  begin
    if i > j then Exit;
    if i = j then
      case s[i] of
        '[', ']': Write(f, '[]');
        '(', ')': Write(f, '()');
      end
    else
      if Trace^[i, j] = 255 then
        begin
          if a[i] <= 2 then Write(f, CharCode[a[i]])
          else Write(f, CharCode[5 - a[i]]);
          GetTrace(i + 1, j - 1);
          if a[i] <= 2 then Write(f, CharCode[5 - a[i]])
          else Write(f, CharCode[a[i]]);
        end
      else
        begin
          GetTrace(i, Trace^[i, j]);
          GetTrace(Trace^[i, j] + 1, j);
        end;
  end;

begin
  Assign(f, OutputFile); Rewrite(f);
  GetTrace(1, n);
  Close(f);
end;

begin
  Enter;
  Init;
  GetNumber(1, n);
  Result;
end.
([(]
([[((())())]()])[]