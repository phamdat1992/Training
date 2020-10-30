program SubString;
const
  InputFile  = 'SUBSTR.INP';
  OutputFile = 'SUBSTR.OUT';
  max = 200;
type
  TBoard = array[1..max, 1..max] of Byte;
var
  a, b: string;
  fb: TBoard;
  Trace: ^TBoard;
  res, m, n, delta: Integer;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  Readln(f, a);
  Readln(f, b);
  while a[1] <> b[1] do
    begin
      Inc(delta);
      Delete(a, 1, 1);
    end;
  while a[Length(a)] <> b[Length(b)] do Dec(a[0]);
  m := Length(a);
  n := Length(b);
  Close(f);
end;

procedure Init;
var
  i, j: Integer;
begin
  FillChar(fb, SizeOf(fb), $FF);
  for i := 1 to m do
    if a[i] = b[1] then fb[i, 1] := 0;
  New(Trace);
  FillChar(Trace^, SizeOf(Trace^), 0);
end;

function GetMax(x, y: Integer): Integer;
begin
  if x > y then GetMax := x else GetMax := y;
end;

procedure Optimize;
var
  i, j, k, t: Integer;
begin
  for j := 2 to n do
    for i := j to m do
      if a[i] = b[j] then
        for k := i - 1 downto j - 1 do
          begin
            if a[k] = b[j - 1] then
              begin
                t := GetMax(i - k, fb[k, j - 1]);
                if t < fb[i, j] then
                  begin
                    fb[i, j] := t;
                    Trace^[i, j] := k;
                  end;
              end;
            if i - k >= fb[i, j] then Break;
          end;
end;

procedure GetTrace;
var
  f: Text;
  i, j, t: Integer;
  p: array[1..max] of Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  res := maxInt;
  for i := 1 to m do
    if fb[i, n] < res then
      begin
        res := fb[i, n];
        t := i;
      end;
  for j := n downto 1 do
    begin
      p[j] := t + Delta;
      t := Trace^[t, j];
    end;
  for j := 1 to n do
    Write(f, p[j], ' ');
  Close(f);
end;

begin
  Enter;
  Init;
  Optimize;
  GetTrace;
end.

fAzyxABlCiDkabcDh
ABCD