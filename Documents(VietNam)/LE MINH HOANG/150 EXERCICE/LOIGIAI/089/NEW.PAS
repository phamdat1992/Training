{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
program FlowersByTarjan;
const
  fi = 'flowers.inp';
  fo = 'flowers.out';
  MaxN = 200;
var
  Next: array[1..MaxN, 1..MaxN - 1] of Byte;
  d, Number, Low, C: array[1..MaxN] of Byte;
  n, Count, Best, li: Byte;
  f: Text;

  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure ReadFile;
var
  u, v: Byte;
begin
  Assign(f, fi); Reset(f);
  ReadLn(f, n);
  FillChar(d, SizeOf(d), 0);
  while not SeekEof(f) do
  begin
    ReadLn(f, u, v);
    Inc(d[u]);
    Next[u, d[u]] := v;
  end;
  Close(f);
end;

function Min(x, y: Byte): Byte;
begin
  if x < y then Min := x
  else Min := y;
end;

procedure Visit(u: Byte);
var
  v, iv: Byte;
begin
  Inc(Count);
  Low[u] := Count; Number[u] := Count;
  C[u] := 1;
  for iv := 1 to d[u] do
  begin
    v := Next[u, iv];
    if Number[v] <> 0 then Low[u] := Min(Low[u], Number[v])
    else
    begin
      Visit(v);
      Low[u] := Min(Low[u], Low[v]);
      Inc(C[u], C[v]);
    end;
  end;
end;

procedure Process;
var
  i: Byte;
begin
  FillChar(Number, SizeOf(Number), 0);
  Count := 0;
  for i := 1 to n do
    if Number[i] = 0 then Visit(i);
  Best := n + 1;
  for i := 1 to n do
    if (Low[i] >= Number[i]) and (C[i] < Best) then
    begin
      Best := C[i];
      li := i;
    end;
end;

procedure WriteFile;
var
  q: array[1..MaxN] of Byte;
  l, r: Byte;
  procedure Bfs;
  var
    Free: array[1..MaxN] of Boolean;
    u, v, iv: Byte;
  begin
    FillChar(Free, SizeOf(Free), True);
    l := 1; r := 1;
    q[1] := li;
    Free[li] := False;
    while l <= r do
    begin
      u := q[l]; Inc(l);
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
  end;
begin
  Assign(f, fo); Rewrite(f);
  WriteLn(f, Best);
  Bfs;
  for l := 1 to r do Write(f, q[l], ' ');
  Close(f);
end;

begin
  OldTime := Time;
  ReadFile;
  Process;
  WriteFile;
  WriteLn(Time - OldTime);
end.