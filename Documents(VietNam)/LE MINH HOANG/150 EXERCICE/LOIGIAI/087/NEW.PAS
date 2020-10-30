{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 60000,0,655360}
program House;
const
  fi = 'house.inp';
  fo = 'house.out';
  Dx: array[1..4] of ShortInt = (-1, 0, 0, 1);
  Dy: array[1..4] of ShortInt = (0, 1, -1, 0);
  MaxN = 100;
type
  Position = record
    u, v: Byte;
  end;
  Map = array[0..MaxN + 1, 0..MaxN + 1] of Byte;
  AList = array[1..MaxN*MaxN] of Position;
var
  c, Trace: array[0..MaxN*MaxN div 2] of Integer;
  a: Map;
  b: array[0..MaxN, 0..MaxN] of Integer;
  List: array[0..4] of ^AList;
  PMark: Pointer;
  m, Count: Integer;
  n: Byte;
  f: Text;

  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure ReadFile;
var
  i, j: Byte;
begin
  Mark(PMark);
  for i := 0 to 4 do New(List[i]);
  Assign(f, fi); Reset(f);
  Readln(f, n);
  FillChar(a, SizeOf(a), 0);
  for i := 1 to n do
  begin
    for j := 1 to n do Read(f, a[i, j]);
    Readln(f);
  end;
  Close(f);
end;

procedure Bfs(var List: AList; a: Map);
var
  q: AList;
  i, j: Byte;
  procedure BfsFrom(su, sv: Byte);
  var
    l, r: Integer;
    u, v, lu, lv, k: Byte;
  begin
    l := 1; r := 1;
    q[1].u := su;
    q[1].v := sv;
    a[su, sv] := 0;
    while l <= r do
    begin
      lu := q[l].u; lv := q[l].v;
      Inc(l);
      for k := 1 to 4 do
      begin
        u := lu + Dx[k];
        v := lv + Dy[k];
        if a[u, v] = 1 then
        begin
          a[u, v] := 0;
          Inc(r);
          q[r].u := u; q[r].v := v;
        end;
      end;
    end;
    c[m] := c[m - 1] + r;
    Move(q[1], List[c[m - 1] + 1], r * SizeOf(q[1]));
  end;
begin
  c[0] := 0;
  m := 0;
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] = 1 then
      begin
        Inc(m);
        BfsFrom(i, j);
      end;
end;

procedure Xoay(s, t: Byte; k: Integer);
var
  i: Integer;
begin
  for i := c[k - 1] + 1 to c[k] do
    with List[t]^[i] do
    begin
      u := n - List[s]^[i].v + 1;
      v := List[s]^[i].u;
    end;
end;

procedure Move(s: Byte; k: Integer);
var
  i: Integer;
  MinX, MinY: Byte;
begin
  MinX := n;
  MinY := n;
  for i := c[k - 1] + 1 to c[k] do
    with List[s]^[i] do
    begin
      if u < MinX then MinX := u;
      if v < MinY then MinY := v;
    end;
  for i := c[k - 1] + 1 to c[k] do
    with List[s]^[i] do
    begin
      Dec(u, MinX);
      Dec(v, MinY);
    end;
end;

procedure Init;
var
  k, i: Integer;
begin
  Bfs(List[1]^, a);
  for i := 1 to m do
    for k := 2 to 4 do Xoay(k - 1, k, i);
  List[0]^ := List[1]^;
  for i := 1 to m do
    for k := 1 to 4 do Move(k, i);
end;

procedure Fill(i: Integer);
var
  j: Integer;
begin
  FillChar(b, SizeOf(b), 0);
  for j := c[i - 1] + 1 to c[i] do
    with List[1]^[j] do b[u, v] := 1;
end;

function Ok(i: Integer; k: Byte): Boolean;
var
  j: Integer;
begin
  for j := c[i - 1] + 1 to c[i] do
    with List[k]^[j] do
      if b[u, v] = 0 then
      begin
        Ok := False;
        Exit;
      end;
  Ok := True;
end;

function GiongNhau(i, j: Integer): Boolean;
var
  k: Byte;
begin
  if c[i] - c[i - 1] <> c[j] - c[j - 1] then
  begin
    GiongNhau := False;
    Exit;
  end;
  Fill(i);
  for k := 1 to 4 do
    if Ok(j, k) then
    begin
      GiongNhau := True;
      Exit;
    end;
  GiongNhau := False;
end;

procedure Process;
var
  i, j: Integer;
begin
  FillChar(Trace, SizeOf(Trace), 0);
  for i := 1 to m - 1 do
    if Trace[i] = 0 then
      for j := i + 1 to m do
        if Trace[j] = 0 then
          if GiongNhau(i, j) then Trace[j] := i;
end;

procedure Put(i: Integer);
var
  j: Integer;
begin
  for j := c[i - 1] + 1 to c[i] do
    with List[0]^[j] do b[u, v] := Count;
end;

procedure WriteFile;
var
  i, j: Integer;
begin
  FillChar(b, SizeOf(b), 0);
  Count := 0;
  for i := 1 to m do
    if Trace[i] = 0 then
    begin
      Inc(Count);
      Trace[i] := i;
      for j := i to m do
        if Trace[j] = i then Put(j);
    end;
  Assign(f, fo); Rewrite(f);
  Writeln(f, Count);
  for i := 1 to n do
  begin
    for j := 1 to n do Write(f, b[i, j], ' ');
    Writeln(f);
  end;
  Close(f);
  Release(PMark);
end;

begin
  OldTime := Time;
  ReadFile;
  Init;
  Process;
  WriteFile;
  Writeln(Time - OldTime);
end.