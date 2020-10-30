{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R-,S+,T-,V+,X+}
{$M 65520,0,655360}
const
  fi = 'fujiwara.ins';
  fo = 'fujiwara.out';
  n = 9;
  Rec: array[1..n, 1..2] of Byte = ((1, 1), (1, 4), (1, 7),
                                    (4, 1), (4, 4), (4, 7),
                                    (7, 1), (7, 4), (7, 7));
  OverTime = 10*18;
type
  ArrayFree = array[1..9] of Boolean;
var
  a, Pos: array[1..n, 1..n] of Byte;
  r: array[1..n] of ArrayFree;
  h, c: array[1..n] of ArrayFree;
  f: Text;

  OldTime: LongInt;
  Time: LongInt absolute 0:$46C;

procedure ReadFile;
var
  i, j: Byte;
  ch: Char;
begin
  Assign(f, fi); Reset(f);
  FillChar(a, SizeOf(a), 0);
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      Read(f, ch);
      if ch <> '.' then a[i, j] := Ord(ch) - Ord('0');
    end;
    Readln(f);
  end;
  Close(f);
end;

procedure WriteFile(Result: Byte);
var
  i, j: Byte;
begin
  Assign(f, fo); Rewrite(f);
  if Result = 0 then Write(f, 'IMPOSSIBLE')
  else
    for i := 1 to n do
    begin
      for j := 1 to n do Write(f, a[i, j]);
      Writeln(f);
    end;
  Close(f);
  Writeln(Time - OldTime);
  Halt;
end;

procedure Fix(Key: Byte);
var
  u, v, i, j: Byte;
begin
  u := Rec[Key, 1];
  v := Rec[Key, 2];
  for i := u to u + 2 do
    for j := v to v + 2 do
    begin
      Pos[i, j] := Key;
      if a[i, j] > 0 then
      begin
        if not r[Key, a[i, j]] or not h[i, a[i, j]]
           or not c[j, a[i, j]] then WriteFile(0);
        r[Key, a[i, j]] := False;
        h[i, a[i, j]] := False;
        c[j, a[i, j]] := False;
      end;
    end;
end;

procedure Init;
var
  i: Byte;
begin
  for i := 1 to 9 do
  begin
    FillChar(h[i], n, True);
    FillChar(c[i], n, True);
    FillChar(r[i], n, True);
  end;
  for i := 1 to 9 do Fix(i);
end;

procedure Try(u, v: Byte);
var
  k, i1, j1: Byte;
begin
  if Time - OldTime > OverTime then WriteFile(0);
  for k := 1 to n do
    if r[Pos[u, v], k] and h[u, k] and c[v, k] then
    begin
      r[Pos[u, v], k] := False;
      h[u, k] := False;
      c[v, k] := False;
      a[u, v] := k;
      i1 := u;
      j1 := v;
      repeat
        if j1 = 9 then
        begin
          j1 := 1;
          Inc(i1);
          if i1 > 9 then WriteFile(1);
        end
        else Inc(j1);
      until a[i1, j1] = 0;
      Try(i1, j1);
      r[Pos[u, v], k] := True;
      h[u, k] := True;
      c[v, k] := True;
      a[u, v] := 0;
    end;
end;

procedure Process;
var
  i, j: Byte;
begin
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] = 0 then
      begin
        Try(i, j);
        WriteFile(0);
      end;
end;

begin
  OldTime := Time;
  ReadFile;
  Init;
  Process;
end.