program Brackets;
const
  InputFile  = 'BRACKETS.INP';
  OutputFile = 'BRACKETS.OUT';
  max = 200;
type
  Str200 = String[200];
var
  Catalan: array[0..max] of Integer;
  S, T: Str200;
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

procedure Solve;
var
  i: Integer;
begin
  T := S; catalan[0] := 0;
  for i := 1 to n do
    begin
      case T[i] of
        '(': if catalan[i - 1] = n - i + 1 then T[i] := ')';
        ')': if catalan[i - 1] = 0 then T[i] := '(';
      end;
      if T[i] = '(' then catalan[i] := catalan[i - 1] + 1
      else catalan[i] := catalan[i - 1] - 1;
    end;
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, T);
  Close(f);
end;

begin
  Enter;
  Solve;
  Result;
end.