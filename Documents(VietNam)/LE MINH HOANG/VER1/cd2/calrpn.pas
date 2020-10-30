{$N+,E+}
program CalculateRPNExpression;
const
  Opt = ['+', '-', '*', '/'];
var
  T, RPN: String;
  Stack: array[1..255] of Extended;
  p, Last: Integer;

procedure StackInit;
begin
  Last := 0;
end;

procedure Push(V: Extended);
begin
  Inc(Last); Stack[Last] := V;
end;

function Pop: Extended;
begin
  Pop := Stack[Last]; Dec(Last);
end;

procedure Refine(var S: String);
var
  i: Integer;
begin
  S := S + ' ';
  for i := Length(S) - 1 downto 1 do
    if (S[i] in Opt) or (S[i + 1] in Opt) then
      Insert(' ', S, i + 1);
  for i := Length(S) - 1 downto 1 do
    if (S[i] = ' ') and (S[i + 1] = ' ') then Delete(S, i + 1, 1);
end;

procedure Process(T: String);
var
  x, y: Extended;
  e: Integer;
begin
  if not (T[1] in Opt) then
    begin
      Val(T, x, e); Push(x);
    end
  else
    begin
      y := Pop; x := Pop;
      case T[1] of
        '+': x := x + y;
        '-': x := x - y;
        '*': x := x * y;
        '/': x := x / y;
      end;
      Push(x);
    end;
end;

begin
  Write('Enter RPN Expression: '); Readln(RPN);
  Refine(RPN);
  StackInit;
  T := '';
  for p := 1 to Length(RPN) do
    if RPN[p] <> ' ' then T := T + RPN[p]
    else
      begin
        Process(T);
        T := '';
      end;
  Writeln(RPN, ' = ', Pop:0:4);
end.
