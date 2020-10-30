program Brackets;
const
  InputFile  = 'BRACKETS.INP';
  OutputFile = 'BRACKETS.OUT';
  max = 200;
type
  Str200 = String[200];
  TBoard = array[0..max, -2..max + 2] of Byte;
var
  S: Str200;
  b: TBoard;
  Res, n: Integer;

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
begin
  FillChar(b, SizeOf(b), max + 1);
  b[0, 0] := 0;
end;

function Min(x, y: Byte): Byte;
begin
  if x < y then Min := x else Min := y;
end;

procedure Optimize;
var
  i, V: Integer;
begin
  for i := 1 to n do
    for V := 0 to n do
      begin
        case S[i] of
          '(': b[i, V] := Min(b[i - 1, V - 1], b[i - 1, V + 1] + 1);
          ')': b[i, V] := Min(b[i - 1, V + 1], b[i - 1, V - 1] + 1);
        end;
      end;
end;

procedure Result;
var
  f: Text;
  i, V: Integer;
  T: Str200;
begin
  Res := b[n, 0];
  t[0] := S[0];
  V := 0;
  for i := n downto 1 do
    begin
      case S[i] of
       '(':  if b[i, V] = b[i - 1, V - 1] then T[i] := '('
             else T[i] := ')';
        ')': if b[i, V] = b[i - 1, V + 1] then T[i] := ')'
             else T[i] := '(';
      end;
      if T[i] = ')' then Inc(V) else Dec(V);
    end;
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, T);
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  Result;
end.
