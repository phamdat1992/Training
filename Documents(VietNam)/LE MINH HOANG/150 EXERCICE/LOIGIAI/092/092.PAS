{$N+,E+}
program Factorial;
const
  InputFile  = 'FDIGIT.IN0';
  OutputFile = 'FDIGIT.OUT';
type
  Int = LongInt;
var
  m, n: LongInt;
  a, b: Int;
  lge: Extended;

procedure Init;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, m, n);
  Close(f);
  lge := 1 / ln(10);
end;

procedure Solve;
var
  S: Extended;
begin
  Dec(m);
  S := 0;
  while S < m do
    begin
      Inc(a);
      S := S + lge * ln(a);
    end;
  b := a;
  while S <= n do
    begin
      Inc(b);
      S := S + lge * ln(b);
    end;
  Dec(b);
end;

procedure Result;
var
  f: Text;
  i: Int;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, a, ' ', b);
  Close(f);
end;

begin
  Init;
  Solve;
  Result;
end.
