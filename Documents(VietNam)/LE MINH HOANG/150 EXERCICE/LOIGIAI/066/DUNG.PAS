{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 65520,0,655360}
const
  fi = 'traffic.in1';
  fo = 'traffic.out';
  MaxLong = 1000000000;
  H: array[1..2, 1..4] of Integer = ((-1, 0, 0, 1),
                                     (0, 1, -1, 0));
  B: string[4] = 'NEWS';

type
  Pixel = record
    x, y: Byte;
  end;
  ma = array[0..101, 0..101] of Byte;
  Queue = array[1..10000] of Pixel;

var
  den: array[0..101, 0..101] of Integer;
  d: array[1..100, 1..100] of LongInt;
  q: ^Queue;
  Trace: ^ma;
  m, n: Byte;
  l: Integer;
  time: LongInt;
  f: Text;

procedure ReadFile;
var
  u, v: Byte;
  k, i: Integer;
begin
  Assign(f, fi); Reset(f);
  Readln(f, m, n);
  Readln(f, k);
  FillChar(den, SizeOf(den), 0);
  for i := 1 to k do Readln(f, u, v, den[u, v]);
  Close(f);
end;

procedure Init;
var
  u, v: Byte;
begin
  for u := 1 to m do
    for v := 1 to n do d[u, v] := MaxLong;
  d[1, 1] := 0;
  New(Trace);
  FillChar(Trace^, SizeOf(Trace^), 0);
  for u := 0 to m + 1 do
  begin
    den[u, 0] := -1;
    den[u, n + 1] := -1;
  end;
  for v := 0 to n + 1 do
  begin
    den[0, v] := -1;
    den[m + 1, v] := -1;
  end;
  New(q);
end;

procedure FindMin(var u, v: Byte);
var
  i, li: Integer;
begin
  li := 1;
  for i := 1 to l do
    if d[q^[i].x, q^[i].y] < d[q^[li].x, q^[li].y] then li := i;
  u := q^[li].x;
  v := q^[li].y;
  q^[li] := q^[l];
  Dec(l);
end;

procedure Dijsktra;
var
  u, v, lu, lv, k: Byte;
  Min, cho: LongInt;
begin
  l := 1;
  q^[1].x := 1;
  q^[1].y := 1;
  repeat
    FindMin(lu, lv);
    Min := d[lu,lv] + 1;
    den[lu, lv] := -1;
    for k := 1 to 4 do
    begin
      u := lu + H[1, k];
      v := lv + H[2, k];
      if den[u, v] < 0 then Continue;
      if den[u, v] = 0 then
      begin
        if d[u, v] > Min then
        begin
          if d[u, v] = MaxLong then
          begin
            Inc(l);
            q^[l].x := u;
            q^[l].y := v;
          end;
          d[u, v] := Min;
          Trace^[u, v] := k;
        end;
        Continue;
      end;
      if (Min div den[u, v]) mod 2 = 0 then
      begin { Chi duoc di Dong-Tay }
        if {k in [2, 3]} (k = 2) or (k = 3) then
        begin { Neu khong phai cho }
          if d[u, v] > Min then
          begin
            if d[u, v] = MaxLong then
            begin
              Inc(l);
              q^[l].x := u;
              q^[l].y := v;
            end;
            d[u, v] := Min;
            Trace^[u, v] := k;
          end;
        end
        else { Neu phai cho }
        begin
          cho := den[u, v] - Min mod den[u, v];
          if d[u, v] > Min + cho then
          begin
            if d[u, v] = MaxLong then
            begin
              Inc(l);
              q^[l].x := u;
              q^[l].y := v;
            end;
            d[u, v] := Min + cho;
            Trace^[u, v] := k;
          end;
        end;
      end
      else
      begin { Chi duoc di Bac-Nam }
        if {k in [1, 4]} (k = 4) or (k = 1) then
        begin { Neu khong phai cho }
          if d[u, v] > Min then
          begin
            if d[u, v] = MaxLong then
            begin
              Inc(l);
              q^[l].x := u;
              q^[l].y := v;
            end;
            d[u, v] := Min;
            Trace^[u, v] := k;
          end;
        end
        else { Neu phai cho }
        begin
          cho := den[u, v] - Min mod den[u, v];
          if d[u, v] > Min + cho then
          begin
            if d[u, v] = MaxLong then
            begin
              Inc(l);
              q^[l].x := u;
              q^[l].y := v;
            end;
            d[u, v] := Min + cho;
            Trace^[u, v] := k;
          end;
        end;
      end;
    end;
  until den[m, n] < 0;
end;

procedure Vet;
var
  kq: array[1..10000] of Integer;
  i: Integer;
begin
  Assign(f, fo); Rewrite(f);
  Writeln(f, d[m, n]);
  l := 10000;
  while d[m, n] <> 0 do
  begin
    kq[l] := d[m, n];
    q^[l].x := 5 - Trace^[m, n];
    m := m + H[1, q^[l].x];
    n := n + H[2, q^[l].x];
    Dec(l);
  end;
  Inc(l);
  while l < 10000 do
  begin
    Write(f, B[5 - q^[l].x]);
    i := kq[l] + 1;
    while i < kq[l + 1] do
    begin
      Write(f, 'w');
      Inc(i);
    end;
    Inc(l);
  end;
  Write(f, B[5 - q^[l].x]);
  Close(f);
end;

begin
  Time := Meml[0:$46C];
  ReadFile;
  Init;
  Dijsktra;
  Vet;
  Writeln(Meml[0:$46C] - Time);
end.