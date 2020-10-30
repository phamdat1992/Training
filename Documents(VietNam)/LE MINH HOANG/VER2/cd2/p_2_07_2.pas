program ConvertInfixToRPN;
const
  Opt = ['(', ')', '+', '-', '*', '/'];
var
  T, Infix, Stack: String;
  p: Integer;

procedure StackInit;
begin
  Stack := '';
end;

procedure Push(V: Char);
begin
  Stack := Stack + V;
end;

function Pop: Char;
begin
  Pop := Stack[Length(Stack)];
  Dec(Stack[0]);
end;

function Get: Char;
begin
  Get := Stack[Length(Stack)];
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

function Priority(Ch: Char): Integer;
begin
  case ch of
    '*', '/': Priority := 2;
    '+', '-': Priority := 1;
    '(': Priority := 0;
  end;
end;

procedure Process(T: String);
var
  c, x: Char;
begin
  c := T[1];
  if not (c in Opt) then Write(T, ' ')
  else
    case c of
      '(': Push(c);
      ')': repeat
                  x := Pop;
                  if x <> '(' then Write(x, ' ');
                until x = '(';
      '+', '-', '*', '/':
                begin
                  while (Stack <> '') and (Priority(c) <= Priority(Get)) do
                    Write(Pop, ' ');
                  Push(c);
                end;
    end;
end;

begin
  Write('Infix = '); Readln(Infix);
  Refine(Infix);
  Writeln('Refined: ', Infix);
  Write('RPN  : ');
  T := '';
  for p := 1 to Length(Infix) do
      if Infix[p] <> ' ' then T := T + Infix[p]
      else
        begin
          Process(T);
          T := '';
        end;
  while Stack <> '' do Write(Pop, ' ');
  Writeln;
end.
