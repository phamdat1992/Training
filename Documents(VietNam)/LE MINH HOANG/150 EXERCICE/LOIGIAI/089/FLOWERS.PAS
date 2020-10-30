{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program Flowers;
const
  fi = 'flowers.inp';
  fo = 'flowers.out';
  MaxN = 200;
type
  Lab = array[1..MaxN, 1..MaxN] of Byte;
var
  c: ^Lab;
  Next: Lab;
  d, t: array[1..MaxN] of Byte;
  q: array[1..MaxN] of Byte;
  Free: array[1..MaxN] of Boolean;
  n, li, l, r: Byte;
  Count, Best: Integer;
  f: Text;

  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure ReadFile;
var
  u, v: Byte;
  i: Integer;
begin
  Assign(f, fi); Reset(f);
  ReadLn(f, n);
  New(c);
  FillChar(c^, SizeOf(c^), 0);
  while not SeekEof(f) do
  begin
    Readln(f, u, v);
    c^[u, v] := 1;
  end;
  Close(f);
end;

procedure Bfs(s: Byte; b: Boolean);
var
  u, v, iv: Byte;
begin
  l := 1; r := 1;
  q[1] := s;
  FillChar(Free, SizeOf(Free), True);
  Free[s] := False;
  while l <= r do
  begin
    u := q[l]; Inc(l);
    if b and (t[u] >= Best) then
    begin
      r := Best;
      Break;
    end;
    for iv := 1 to d[u] do
    begin
      v := Next[u, iv];
      if Free[v] then
      begin
        Free[v] := False;
        Inc(r);
        q[r] := v;
      end;
    end;
  end;
  if r < Best then
  begin
    Best := r;
    li := s;
  end;
  for v := 1 to n do
    if c^[v, s] = 1 then t[v] := Best;
end;

procedure Init;
var
  i, j: Byte;
begin
  FillChar(d, SizeOf(d), 0);
  for i := 1 to n do
    for j := 1 to n do
      if c^[i, j] = 1 then
      begin
        Inc(d[i]);
        Next[i, d[i]] := j;
      end;
end;

procedure Process;
var
  i: Byte;
begin
  Best := MaxInt;
  FillChar(t, SizeOf(t), 0);
  for i := 1 to n do
    if t[i] < Best then Bfs(i, True);
end;

procedure WriteFile;
var
  i: Byte;
begin
  Assign(f, fo); Rewrite(f);
  WriteLn(f, Best);
  Bfs(li, False);
  for i := 1 to r do Write(f, q[i], ' ');
  Close(f);
end;

begin
  OldTime := Time;
  ReadFile;
  Init;
  Process;
  WriteFile;
  WriteLn(Time - OldTime);
end.