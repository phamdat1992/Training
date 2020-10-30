{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
uses ctest078;
const
  fi = 'chain.inp';
  fo = 'chain.out';
  Bit: array[0..7] of Byte = (1, 2, 4, 8, 16, 32, 64, 128);
  MaxN = 10000;
type
  Array10000 = array[0..10000] of Integer;
var
  Ke: array[1..MaxN * 2] of Integer;
  c: ^Array10000;
  Chain, Lab: ^Array10000;
  Free: array[0..1250] of Byte;
  n, m, Last: Integer;
  f: Text;

procedure ReadFile;
var
  i, u, v: Integer;
begin
  Assign(f, fi); Reset(f);
  Readln(f, n);
  New(c);
  FillChar(c^, SizeOf(c^), 0);
  for i := 2 to n do
  begin
    Readln(f, u, v);
    Inc(c^[u]);
    Inc(c^[v]);
  end;
  Close(f);
  c^[0] := 0;
  for i := 2 to n do Inc(c^[i], c^[i - 1]);
  Move(c^[0], c^[1], n shl 1);
  Assign(f, fi); Reset(f);
  Readln(f);
  for i := 2 to n do
  begin
    Readln(f, u, v);
    Inc(c^[u]);
    Ke[c^[u]] := v;
    Inc(c^[v]);
    Ke[c^[v]] := u;
  end;
  Close(f);
end;

procedure Join; { noi day xich }
var
  i, j, x: Integer;
  Found: Boolean;
begin
  New(Chain);
  FillChar(Free, SizeOf(Free), 0);
  for i := 1 to n do
    if c^[i] - c^[i - 1] > 1 then Break;
  m := 1;
  Chain^[1] := i;
  Inc(Free[i shr 3], Bit[i and 7]);
  Found := True;
  while Found do
  begin
    Found := False;
    for j := c^[i - 1] + 1 to c^[i] do
    begin
      x := Ke[j];
      if (c^[x] - c^[x - 1] > 1) and (Free[x shr 3] and Bit[x and 7] = 0) then
      begin
        Inc(Free[x shr 3], Bit[x and 7]);
        Inc(m);
        Chain^[m] := x;
        Found := True;
        i := x;
        Break;
      end;
    end;
  end;
  i := Chain^[1];
  Found := True;
  while Found do
  begin
    Found := False;
    for j := c^[i - 1] + 1 to c^[i] do
    begin
      x := Ke[j];
      if (c^[x] - c^[x - 1] > 1) and (Free[x shr 3] and Bit[x and 7] = 0) then
      begin
        Inc(Free[x shr 3], Bit[x and 7]);
        Move(Chain^[1], Chain^[2], m shl 1);
        Inc(m);
        Chain^[1] := x;
        Found := True;
        i := x;
        Break;
      end;
    end;
  end;
end;

function Find(Delta, Old: Integer): Integer;
var
  New: Integer;
begin
  { Delta = Abs(New - Old) => New = Old + Delta V New = Old - Delta }
  New := Old - Delta;
  if (New > 0) and (Free[New shr 3] and Bit[New and 7] = 0) then Find := New
  else Find := Old + Delta;
end;

procedure FillLabel(x: Integer);
var
  i, l, l1: Integer;
begin
  l := Lab^[x];
  Inc(Free[l shr 3], Bit[l and 7]);
  for i := c^[x - 1] + 1 to c^[x] do
    if c^[Ke[i]] - c^[Ke[i] - 1] = 1 then
    begin
      l1 := Find(Last, l);
{      if (l1 > n) or (Free[l1 shr 3] and Bit[l1 and 7] > 0) then
      begin
        Writeln(' That bai ', l1);
        Readln;
        Halt;
      end;}
      Lab^[Ke[i]] := l1;
      Dec(Last);
      Inc(Free[l1 shr 3], Bit[l1 and 7]);
    end;
end;

procedure Process;
var
  i, x, l: Integer;
begin
  FillChar(Free, SizeOf(Free), 0);
  New(Lab);
  x := Chain^[1];
  Lab^[x] := 1;
  Last := n - 1;
  FillLabel(x);
  for i := 2 to m do
  begin
    l := Find(Last, Lab^[Chain^[i - 1]]);
    Lab^[Chain^[i]] := l;
    Dec(Last);
    FillLabel(Chain^[i]);
  end;
end;

procedure WriteFile;
var
  i: Integer;
begin
  Assign(f, fo); Rewrite(f);
  for i := 1 to n do Write(f, Lab^[i], ' ');
  Close(f);
  Dispose(Chain);
  Dispose(Lab);
end;

begin
  ReadFile;
  Join;
  Process;
  WriteFile;
end.