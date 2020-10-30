program MinimalValueofString;
const
  InputFile  = 'NUMBER.INP';
  OutputFile = 'NUMBER.OUT';
  max = 101;
var
  a, b: String[max];
  fb: array[1..2, 0..max] of String;
  m, n: Integer;
  Res: String;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, a);
  Readln(f, b);
  Close(f);
  m := Length(a); n := Length(b);
end;

procedure Init;
var
  j: Integer;
begin
  for j := 0 to n do fb[1, j] := Copy(b, 1, j);
end;

function GetMin(s1, s2: String): String;
begin
  while (Length(s1) <> 0) and (s1[1] = '0') do Delete(s1, 1, 1);
  while (Length(s2) <> 0) and (s2[1] = '0') do Delete(s2, 1, 1);
  if (Length(s1) < Length(s2)) or
     (Length(s1) = Length(s2)) and (s1 < s2) then GetMin := s1
  else GetMin := s2;
end;

procedure Optimize;
var
  i, j, x, y: Integer;
begin
  x := 1; y := 2;
  for i := 1 to m do
    begin
      fb[y][0] := Copy(a, 1, i);
      for j := 1 to n do
        if a[i] = b[j] then fb[y][j] := fb[x][j - 1] + a[i]
        else
          fb[y][j] := GetMin(fb[x][j] + a[i], fb[y][j - 1] + b[j]);
      x := 3 - x; y := 3 - y;
    end;
  Res := fb[x][n];
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, Res);
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  Result;
end.
