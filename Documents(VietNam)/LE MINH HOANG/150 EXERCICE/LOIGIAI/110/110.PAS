program Encode_Decode;
const
  InputFile  = 'PERMUTE.IN0';
  OutputFile = 'PERMUTE.OU0';
  max = 12;
var
  Fac: array[0..max] of LongInt;
  a, b: array[1..max] of Integer;
  n: Integer;
  p, q: LongInt;

procedure Enter;
var
  f: Text;
begin
  Assign(f, InputFile); Reset(f);
  n := 0;
  while not SeekEoln(f) do
    begin
      Inc(n); Read(f, a[n]);
    end;
  Readln(f);
  Readln(f, p);
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  Fac[0] := 1;
  for i := 1 to n do Fac[i] := Fac[i - 1] * i;
end;

procedure Solve1;
var
  Free: array[1..max] of Boolean;
  i, j, k: Integer;
begin
  q := 0;
  FillChar(Free, SizeOf(Free), True);
  for i := 1 to n do
    begin
      k := 0;
      for j := 1 to a[i] - 1 do
        if Free[j] then Inc(k);
      q := q + LongInt(k) * Fac[n - i];
      Free[a[i]] := False;
    end;
  Inc(q);
end;

procedure Solve2;
var
  i, j, k, t: Integer;
  Free: array[1..max] of Boolean;
begin
  FillChar(Free, SizeOf(Free), True);
  for i := 1 to n do
    begin
      j := (p - 1) div Fac[n - i] + 1;
      for k := 1 to n do
        if Free[k] then
          begin
            Dec(j);
            if j = 0 then Break;
          end;
      b[i] := k;
      Free[k] := False;
      p := (p - 1) mod Fac[n - i] + 1;
    end;
end;

procedure Result;
var
  f: Text;
  i: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, q);
  for i := 1 to n do Write(f, b[i], ' ');
  Close(f);
end;

begin
  Enter;
  Init;
  Solve1;
  Solve2;
  Result;
end.
