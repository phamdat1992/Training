{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
{uses ctest076;} { moi hop sao cho do voi ve la max }
const
  fi = 'guest.inp';
  fo = 'guest.out';
type
  Ma = array[0..10000] of Integer;
  Ma1 = array[1..10000] of Byte;
var
  Pa: array[1..10000] of LongInt;
  c: array[0..10000] of Integer;
  Trace: ^Ma1;
  Ke, h, q: ^Ma;
  n, start, l, r: Integer;
  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure ReadFile;
var
  i: Integer;
  f: Text;
  vv: ^Ma;
begin
  New(vv);
  New(Ke);
  FillChar(c, SizeOf(c), 0);
  Assign(f, fi); Reset(f);
  Readln(f, n);
  New(h);
  for i := 1 to n do
  begin
    Readln(f, vv^[i], h^[i]);
    if vv^[i] = 0 then Start := i
    else Inc(c[vv^[i]]);
  end;
  Close(f);
  for i := 1 to n do Inc(c[i], c[i - 1]);
  Move(c[0], c[1], n shl 1);
  Assign(f, fi); Reset(f);
  Readln(f);
  ke^[0] := 0;
  for i := 1 to n do
  begin
    if vv^[i] <> 0 then
    begin
      Inc(c[vv^[i]]);
      Ke^[c[vv^[i]]] := i;
    end;
  end;
  Close(f);
  Dispose(vv);
end;

procedure Numbering;
var
  u, iv, v: Integer;
begin
  New(q);
  q^[1] := Start;
  l := 1;
  r := 1;
  while r < n do
  begin
    u := q^[l];
    for iv := c[u - 1] + 1 to c[u] do
    begin
      Inc(r);
      q^[r] := Ke^[iv];
    end;
    Inc(l);
  end;
end;

function Calculator(Key: Integer): LongInt;
var
  i: Integer;
  s: LongInt;
begin
  s := 0;
  for i := c[Key - 1] + 1 to c[Key] do Inc(s, Pa[Ke^[i]]);
  Calculator := s;
end;

procedure Optimize;
var
  i, x, j: Integer;
  p1, p2: LongInt;
begin
  New(Trace);
  for i := n downto 1 do
  begin
    x := q^[i];
    if c[x] - c[x - 1] = 0 then
    begin
      Pa[x] := h^[x];
      Trace^[x] := 0;
      Continue;
    end;
    p1 := Calculator(x);
    p2 := h^[x];
    for j := c[x - 1] + 1 to c[x] do Inc(p2, Calculator(Ke^[j]));
    if p1 > p2 then
    begin
      Pa[x] := p1;
      Trace^[x] := 1;
    end
    else
    begin
      Pa[x] := p2;
      Trace^[x] := 2;
    end;
  end;
end;

procedure Add(Key: Integer);
var
  i: Integer;
begin
  for i := c[Key - 1] + 1 to c[Key] do
  begin
    Inc(r);
    q^[r] := Ke^[i];
  end;
end;

procedure WriteFile;
var
  x, i, Count: Integer;
  f: Text;
  g: file of Char;
  st: string;
begin
  Assign(f, fo); Rewrite(f);
  Writeln(f, '      ', Pa[Start]);
  l := 1;
  r := 1;
  Count := 0;
  repeat
    x := q^[l];
    Inc(l);
    if Trace^[x] = 1 then Add(x)
    else
    begin
      Writeln(f, x);
      Inc(Count);
      for i := c[x - 1] + 1 to c[x] do Add(Ke^[i])
    end;
  until l > r;
  Close(f);
  Str(Count, st);
  Assign(g, fo); Reset(g);
  while st <> '' do
  begin
    Write(g, st[1]);
    Delete(st, 1, 1);
  end;
  Close(g);
  Dispose(Trace);
  Dispose(q);
  Dispose(h);
  Dispose(Ke);
end;

begin
  OldTime := Time;
  ReadFile;
  Numbering;
  Optimize;
  WriteFile;
  Writeln(Time - OldTime);
end.