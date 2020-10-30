{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 7000,0,655360}
const
  fi = 'message.in9';
  fo = 'message.out';
type
  p = array[1..500] of Boolean;
var
  Free: array[1..500] of Boolean;
  Number: array[1..500] of Integer;
  m: array[1..500] of Integer;
  c: array[1..500] of ^p;
  time: LongInt;
  OldTime: LongInt absolute 0:$46C;
  n, sl, sm: Integer;
  f: Text;

procedure ReadFile;
var
  u, v: Integer;
begin
  Assign(f, fi); Reset(f);
  Readln(f, n);
  while not SeekEof(f) do
  begin
    Readln(f, u, v);
    c[u]^[v] := True;
  end;
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 1 to 500 do
  begin
    New(c[i]);
    FillChar(c[i]^, SizeOf(c[i]^), False);
  end;
end;

procedure Numbering(i: Integer);
var
  j: Integer;
begin
  Free[i] := False;
  for j := 1 to n do
    if Free[j] and c[i]^[j] then Numbering(j);
  Inc(sl);
  Number[sl] := i;
end;

procedure Put(i: Integer);
var
  j: Integer;
begin
  Free[i] := False;
  m[i] := sm;
  for j := 1 to n do
    if Free[j] and c[j]^[i] then Put(j);
end;

procedure Ltm;
var
  i: Integer;
begin
  FillChar(Free, n, True);
  sl := 0;
  for i := 1 to n do
    if Free[i] then Numbering(i);
  FillChar(Free, n, True);
  sm := 0;
  for i := n downto 1 do
    if Free[Number[i]] then
    begin
      Inc(sm);
      Put(Number[i]);
    end;
end;

procedure Process;
var
  i, j, k: Integer;
begin
  FillChar(Free, sm, True);
  for i := 1 to n do
    for j := i + 1 to n do
      if (m[i] <> m[j]) then
        if c[i]^[j] then Free[m[j]] := False
        else
          if c[j]^[i] then Free[m[i]] := False;
  Assign(f, fo); Rewrite(f);
  k := 0;
  for i := 1 to sm do
    if Free[i] then Inc(k);
  Writeln(f, k);
  for i := 1 to sm do
    if Free[i] then
      for j := 1 to n do
        if m[j] = i then
        begin
          Write(f, j, ' ');
          Break;
        end;
  Close(f);
end;

begin
  Time := OldTime;
  Init;
  ReadFile;
  Ltm;
  Process;
  Writeln(OldTime - Time);
end.