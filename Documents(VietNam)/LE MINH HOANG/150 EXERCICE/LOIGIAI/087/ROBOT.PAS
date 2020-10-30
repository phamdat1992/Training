{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
program Robot;
const
  fi = 'house.inp';
  fo = 'house.out';
  Dx: array[1..4] of Integer = (-1, 0, 0, 1);
  Dy: array[1..4] of Integer = (0, 1, -1, 0);
  MaxN = 100;
type
  Rec = record
    u, v: Byte;
  end;
  Arr = array[1..MaxN, 1..MaxN] of Integer;
var
  a: array[0..MaxN + 1, 0..MaxN + 1] of Integer;
  q1: array[1..MaxN*MaxN] of Rec;
  sl: ^Arr;
  n, Count: Integer;
  f: Text;

procedure ReadFile;
var
  i, j: Integer;
begin
  Assign(f, fi); Reset(f);
  Readln(f, n);
  FillChar(a, SizeOf(a), 0);
  New(sl);
  for i := 1 to n do
  begin
    for j := 1 to n do Read(f, a[i, j]);
    Readln(f);
  end;
  Close(f);
end;

procedure Move(x1, y1: Integer);
var
  Free: array[1..MaxN, 1..maxn] of Boolean;
  l, r, u, v, lu, lv, k, i: Integer;
begin
  FillChar(Free, SizeOf(Free), True);
  l := 1; r := 1;
  Free[x1, y1] := False;
  q1[1].u := x1;
  q1[1].v := y1;
  repeat
    lu := q1[l].u; lv := q1[l].v;
    Inc(l);
    for k := 1 to 4 do
    begin
      u := lu + Dx[k];
      v := lv + Dy[k];
      if (a[u, v] > 1) and Free[u, v] then
      begin
        Free[u, v] := False;
        Inc(r);
        q1[r].u := u;
        q1[r].v := v;
      end;
    end;
  until l > r;
end;

function cn(u, v, Old: Integer): Boolean;
begin
  cn := (u > 0) and (u <= n) and (v > 0) and (v <= n) and (a[u, v] = Old);
end;

procedure Put(x1, y1: Integer);
var
  q: array[1..MaxN*MaxN] of Rec;
  Free: array[1..MaxN, 1..MaxN] of Boolean;
  l, r, u, v, lu, lv, k, i, i1, j1, Old, x, y, z, dex, dey: Integer;
  ok0, ok90, ok180, ok270: Boolean;
begin
  FillChar(Free, SizeOf(Free), True);
  l := 1; r := 1;
  Free[x1, y1] := False;
  q[1].u := x1;
  q[1].v := y1;
  repeat
    lu := q[l].u; lv := q[l].v;
    Inc(l);
    for k := 1 to 4 do
    begin
      u := lu + Dx[k];
      v := lv + Dy[k];
      if (a[u, v] = 1) and Free[u, v] then
      begin
        Free[u, v] := False;
        Inc(r);
        q[r].u := u;
        q[r].v := v;
      end;
    end;
  until l > r;
  for i1 := 1 to x1 do
    for j1 := 1 to n do
    begin
      if (a[i1, j1] > 1) and (sl^[i1, j1] = r) then
      begin
        Move(i1, j1);
        Old := a[i1, j1];
        for z := 1 to r do
        begin
          x := q1[z].u; y := q1[z].v;
          dex := x - q[1].u; dey := y - q[1].v;
          ok0 := True; ok90 := True; ok180 := True; ok270 := True;
          for i := 1 to r do
          begin
            lu := q[i].u;
            lv := q[i].v;
            lu := lu;
            lv := lv;
            if not cn(lu + dex, lv + dey, Old) then ok0 := False;
            if not cn(n - lv + dex + 1, lu + dey, Old) then ok90 := False;
            if not cn(n - lu + dex + 1, n - lv + dey + 1, Old) then ok180 := False;
            if not cn(lv + dex, n - lu + dey + 1, Old) then ok270 := False;
          end; { of for i := 1 to r }
          if ok0 or ok90 or ok180 or ok270 then
          begin
            for i := 1 to r do
              with q[i] do
              begin
                a[u, v] := Old;
                sl^[u, v] := r;
              end;
            Exit;
          end;
        end; { for z := 1 to r }
      end; { if }
    end; { for i1, j1 }
  Inc(Count);
  for i := 1 to r do
    with q[i] do
    begin
      a[u, v] := Count;
      sl^[u, v] := r;
    end;
end;

procedure Process;
var
  i, j: Integer;
begin
  Count := 1;
  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] = 1 then
      begin
        Put(i, j);
      end;
end;

procedure WriteFile;
var
  i, j: Integer;
begin
  Assign(f, fo); Rewrite(f);
  Writeln(f, Count - 1);
  for i := 1 to n do
  begin
    for j := 1 to n do
      if a[i, j] > 0 then Write(f, a[i, j] - 1, ' ')
      else Write(f, 0, ' ');
    Writeln(f);
  end;
  Close(f);
end;

begin
  ReadFile;
  Process;
  WriteFile;
end.