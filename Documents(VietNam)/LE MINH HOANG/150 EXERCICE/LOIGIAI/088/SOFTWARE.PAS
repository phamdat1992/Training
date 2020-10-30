{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program SoftWare;
const
  fi = 'software.in0';
  fo = 'software.out';
  Bit: array[0..7] of Byte = (1, 2, 4, 8, 16, 32, 64, 128);
  MaxN = 100;
type
  Line = array[0..1250] of Byte;
var
  p, c: array[0..MaxN] of LongInt;
  a: array[0..MaxN * MaxN] of LongInt;
  Trace: array[0..100] of ^Line;
  Sum: array[0..100] of Integer;
  PMark: Pointer;
  n: Byte;
  f: Text;

  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure ReadFile;
var
  i: Byte;
begin
  Assign(f, fi); Reset(f);
  ReadLn(f, n);
  Sum[0] := 0;
  for i := 1 to n do
  begin
    Read(f, p[i]);
    Sum[i] := Sum[i - 1] + p[i];
  end;
  for i := 1 to n do Read(f, c[i]);
  c[0] := 0;
  Close(f);
end;

procedure SetBit(i, j: Integer);
begin
  Trace[i]^[j shr 3] := Trace[i]^[j shr 3] or Bit[j and 7];
end;

function GetBit(i, j: Integer): Boolean;
begin
  GetBit := Trace[i]^[j shr 3] and Bit[j and 7] <> 0;
end;

procedure Optimize;
var
  i, j, x, i1, Max: Integer;
begin
  Mark(PMark);
  for i := 0 to n do
  begin
    New(Trace[i]);
    FillChar(Trace[i]^, SizeOf(Trace[i]^), 0);
  end;
  FillChar(a, SizeOf(a), 0);
  SetBit(0, 0);
  for i := 1 to n do
  begin
    for j := Sum[i] downto p[i] do
    begin{ a[i - 1, j - p[i] va a[i - 1, j] + c[i] }
      if a[j - p[i]] < a[j] + c[i] then
      begin
        a[j] := a[j - p[i]];
        SetBit(i, j);
      end
      else Inc(a[j], c[i]);
    end;
    for j := p[i] - 1 downto 0 do Inc(a[j], c[i]);
  end;
end;

function Max(x, y: Integer): Integer;
begin
  if x > y then Max := x
  else Max := y;
end;

procedure WriteFile;
var
  i, Best, li, n1: Integer;
  Free: array[1..MaxN] of Boolean;
begin
  Assign(f, fo); Rewrite(f);
  Best := MaxInt;
  for i := 0 to Sum[n] do
    if Max(a[i], i) < Best then
    begin
      Best := Max(a[i], i);
      li := i;
    end;
  Writeln(f, Best);
  FillChar(Free, SizeOf(Free), True);
  n1 := n;
  while n > 0 do
  begin
    if GetBit(n, li) then
    begin
      Free[n] := False;
      Write(f, n, ' ');
      Dec(li, p[n]);
    end;
    Dec(n);
  end;
  Writeln(f);
  for i := 1 to n1 do
    if Free[i] then Write(f, i, ' ');
  Close(f);
  Release(PMark);
end;

begin
  OldTime := Time;
  ReadFile;
  Optimize;
  WriteFile;
  Writeln(Time - OldTime);
end.