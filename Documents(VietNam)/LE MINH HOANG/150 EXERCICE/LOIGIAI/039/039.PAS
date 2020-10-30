{$N+,E+}
program NetWork;
const
  InputFile  = 'NET.IN9';
  OutputFile = 'NET.OUT';
  maxN = 1000;
  maxM = 10000;
  maxC = 1000000000;
type
  Real = Double;
  PNode = ^TNode;
  TNode = record
    vertex: Integer;
    Link: PNode;
  end;
var
  x, y, d: array[1..maxN] of LongInt;
  Trace: array[1..maxN] of Integer;
  adj: array[1..maxN] of PNode;
  Free: array[1..maxN] of Boolean;
  permanent, n, m, nAdd: Integer;
  res: Real;

procedure Enter;
var
  f: Text;
  i, j, u, v: Integer;
  procedure AddE(u, v: Integer);
  var
    P: PNode;
  begin
    New(P); P^.vertex := v;
    P^.Link := adj[u];
    adj[u] := P;
  end;

begin
  FillChar(adj, SizeOf(adj), 0); {Init NIL Pointer}
  Assign(f, InputFile); Reset(f);
  Readln(f, n, m);
  for i := 1 to n do Readln(f, x[i], y[i]);
  for j := 1 to m do
    begin
      Readln(f, u, v);
      AddE(u, v); AddE(v, u);
    end;
  Close(f);
end;

procedure Init;
var
  i: Integer;
begin
  for i := 2 to n do d[i] := maxC;
  d[1] := 0;
  FillChar(Free, SizeOf(Free), True);
  res := 0;
  nAdd := 0;
end;

function Distance2(u, v: Integer): LongInt;
begin
  Distance2 := Sqr(x[u] - x[v]) + Sqr(y[u] - y[v]);
end;

procedure FindPermanent;
var
  min: Real;
  u: Integer;
begin
  min := maxC;
  for u := 1 to n do
    if Free[u] and (d[u] < min) then
      begin
        min := d[u];
        permanent := u;
      end;
end;

procedure OptimizeLabel;
var
  v: Integer;
  p: PNode;
  c: LongInt;
begin
  p := adj[permanent];
  while p <> nil do
    begin
      v := p^.vertex;
      if Free[v] then d[v] := 0;
      p := p^.Link;
    end;
  for v := 1 to n do
    if Free[v] and (d[v] <> 0) then
      begin
        c := Distance2(Permanent, v);
        if d[v] > c then
          begin
            d[v] := c;
            Trace[v] := Permanent;
          end;
      end;
end;

procedure Prim;
var
  step: Integer;
begin
  for step := 1 to n do
    begin
      FindPermanent;
      res := res + Sqrt(d[permanent]);
      if d[permanent] <> 0 then Inc(nAdd);
      Free[permanent] := False;
      OptimizeLabel;
    end;
end;

procedure Result;
var
  f: Text;
  v: Integer;
begin
  Assign(f, OutputFile); Rewrite(f);
  Writeln(f, nAdd, ' ', res:1:6);
  for v := 2 to n do
    if d[v] <> 0 then Writeln(f, Trace[v], ' ', v);
  Close(f);
end;

begin
  Enter;
  Init;
  Prim;
  Result;
end.
