program MaxString;
const
  InputFile  = 'STR.INP';
  OutputFile = 'STR.OUT';
  max = 255;
type
  TLine = array[0..max] of Integer;
  PLine = ^TLine;
var
  Fb: array[0..max] of PLine;
  c, a, b: String;
  m, n: Integer;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, a); Readln(f, b);
  m := Length(a); n := Length(b);
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 0 to m do New(Fb[i]);
  FillChar(Fb[0]^, SizeOf(Fb[0]^), 0);
  for i := 1 to m do Fb[i]^[0] := 0;
end;

function Max3(x, y, z: Integer): Integer;
begin
  if y > x then x := y;
  if z > x then x := z;
  Max3 := x;
end;

procedure Optimize;
var
  i, j: Integer;
begin
  for i := 1 to m do
    for j := 1 to n do
      if a[i] = b[j] then Fb[i]^[j] := Fb[i - 1]^[j - 1] + 1
      else
        Fb[i]^[j] := Max3(Fb[i - 1]^[j - 1], Fb[i - 1]^[j], Fb[i]^[j - 1]);
end;

procedure Trace;
var
  i, j: Integer;
begin
  c := '';
  i := m; j := n;
  while (i <> 0) and (j <> 0) do
    if a[i] = b[j] then
      begin
        c := a[i] + c;
        Dec(i); Dec(j);
      end
    else
      if Fb[i]^[j] = Fb[i - 1]^[j - 1] then
        begin
          Dec(i); Dec(j);
        end
      else
        if Fb[i]^[j] = Fb[i - 1]^[j] then Dec(i)
        else Dec(j);
end;

procedure Result;
var
  f: Text;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, c);
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  Trace;
  Result;
end.
