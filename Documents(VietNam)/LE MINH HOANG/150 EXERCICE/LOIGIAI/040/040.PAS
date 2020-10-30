program Domino;
const
  InputFile  = 'DOMINO.IN1';
  OutputFile = 'DOMINO.OUT';
  maxN = 100;
var
  F: array[0..maxN, -6..maxN * 6] of Byte;
  a, b: array[1..maxN] of Byte;
  n: Byte;
  m, Sum: Integer;

procedure Enter;
var
  InFile: Text;
  i: Byte;
begin
  Assign(InFile, InputFile); Reset(InFile);
  Readln(InFile, n);
  for i := 1 to n do Read(InFile, a[i]); Readln(InFile);
  for i := 1 to n do Read(InFile, b[i]);
  Close(InFile);
end;

function Min(x, y: Byte): Byte;
begin
  if x < y then Min := x else Min := y;
end;

function Max(x, y: Byte): Byte;
begin
  if x > y then Max := x else Max := y;
end;

procedure Init;
var
  i: Byte;
begin
  FillChar(F, SizeOf(F), maxN + 1);
  F[0, 0] := 0;
  m := 0; Sum := 0;
  for i := 1 to n do
    begin
      m := m + Max(a[i], b[i]);
      Sum := Sum + a[i] + b[i];
    end;
end;

procedure Optimize;
var
  k: Byte;
  V: Integer;
begin
  for k := 1 to n do
    for V := 0 to m do
      F[k, V] := Min(F[k - 1, V - a[k]], F[k - 1, V - b[k]] + 1);
end;

procedure Trace;
var
  V, p, d: Integer;
  i: Byte;
  OutFile: Text;

  function Better(a, b: Integer): Boolean;
  var
    other2, other1: Integer;
  begin
    other1 := Sum - a; other2 := Sum - b;
    Better := (Abs(a - other1) < Abs(b - other2)) or
                        (Abs(a - other1) = Abs(b - other2)) and (F[n, a] < F[n, b]);
  end;

begin
  p := 0;
  while F[n, p] = maxN + 1 do Inc(p);
  for V := p + 1 to m do
    if (F[n, V] <> maxN + 1) and Better(V, p) then p := V;
  d := Sum - 2 * p;
  Assign(OutFile, OutputFile); Rewrite(OutFile);
  Writeln(OutFile, F[n, p]);
  for i := n downto 1 do
    if F[i, p] = F[i - 1, p - a[i]] then p := p - a[i]
    else
      begin
        Write(OutFile, i, ' ');
        p := p - b[i];
      end;
  Writeln(OutFile);
  Writeln(OutFile, Abs(d));
  Close(OutFile);
end;

begin
  Enter;
  Init;
  Optimize;
  Trace;
end.
