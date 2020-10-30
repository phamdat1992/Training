program truyen_tin_tren_mang;
uses  crt;
const inp = 'mess.inp';
      out = 'mess.out';
      max = 1000000000;
      mn  = 100;

type  arr1lgin = array [ 1..mn ] of longint;
      arr1_01  = array [ 1..mn ] of 0..1;
      road = record
               dem, do_dai : integer;
               kq : arr1lgin;
               cx : arr1_01;
             end;
      arr2lgin = array [ 1..mn ] of arr1lgin;
      arr1bool = array [ 1..mn ] of boolean;
      arr1road = array [ 1..2 ] of road;
var   f : text;
      dd : arr1road;
      lab, trc : arr1lgin;
      chuaxet : arr1bool;
      a : arr2lgin;
      n, m, s, t, i, j, muc_dang : integer;

procedure input;
  var k, l, gt : integer;
  begin
    assign(f,inp);
      reset(f);
      readln(f,n,m,s,t);
      for i := 1 to n do
        for j := 1 to n do a[i,j] := max;
      for i := 1 to m do
        begin
          readln(f,k,l,gt);
          a[k,l] := gt;
        end;
    close(f);
  end;

procedure init;
  begin
    for i := 1 to n do
      begin
        lab[i] := a[s,i];
        trc[i] := s;
      end;
    lab[s] := 0;
  end;

procedure tim_min(var i : integer);
  var min : integer;
  begin
    min := maxint;
    for j := 1 to n do
      if chuaxet[j] and ( lab[j] < min )
      then begin
             min := lab[j];
             i := j;
           end;
  end;

procedure sua_nhan(i : integer);
  begin
    for j := 1 to n do
      if chuaxet[j] and ( lab[j] > lab[i] + a[i,j] ) then
        begin
          lab[j] := lab[i] + a[i,j];
          trc[j] := i;
        end;
  end;

procedure dijsktra;
  begin
    init;
    fillchar(chuaxet, sizeof(chuaxet), true);
    trc[s] := 0;
    chuaxet[s] := false;
    while chuaxet[t] do
      begin
        tim_min(i);
        chuaxet[i] := false;
        if chuaxet[t] then sua_nhan(i);
      end;
  end;

procedure luu_dd(i : integer);
  begin
    with dd[i] do
      begin
        j := t;
        while j <> s do
          begin
            inc(dem);
            inc(do_dai, a[trc[j],j]);
            kq[dem] := j;
            j := trc[j];
          end;
        inc(dem);
        kq[dem] := s;
      end;
  end;

procedure doi_trong_so;
  begin
    with dd[1] do
      begin
        for i := 1 to pred(dem) do
          begin
            a[kq[i], kq[succ(i)]] := -a[kq[succ(i)], kq[i]];
            a[kq[succ(i)], kq[i]] := max;
          end;
      end;
  end;

procedure ford_bellmand;
  var k : integer;
  begin
    init;
    for k := 1 to n-2 do
      for i := 1 to n do
        if i <> s then
          for j := 1 to n do
            if lab[i] > lab[j]+a[j,i] then
              begin
                lab[i] := lab[j] + a[j,i];
                trc[i] := j;
              end;
  end;

procedure loai;
  begin
    for i := 2 to pred(dd[1].dem) do
      for j := 2 to pred(dd[2].dem) do
        if ( dd[1].kq[i] = dd[2].kq[succ(j)] )
           and ( dd[1].kq[succ(i)] = dd[2].kq[j] )
        then begin
               dd[1].cx[succ(i)] := 1;
               dd[2].cx[succ(j)] := 1;
             end;
  end;

procedure result;
  begin
    assign(f,out);
      rewrite(f);
      writeln(f,dd[1].do_dai + dd[2].do_dai);
      for i := 1 to 2 do
        with dd[i] do
          begin
            for j := dem downto 1 do
              if cx[j] = 0 then write(f,kq[j],' ');
            writeln(f);
        end;
    close(f);
  end;

BEGIN
  clrscr;
  fillchar(dd, sizeof(dd), 0);
  muc_dang := 0;
  input;
  dijsktra;
  luu_dd(1);
  doi_trong_so;
  ford_bellmand;
  luu_dd(2);
  loai;
  result;
END.

5 7 1 5
1 2 3
1 4 8
2 3 5
2 4 4
3 5 5
4 3 8
4 5 3

11 16 1 10
1 2 3
1 4 8
2 3 5
3 5 5
4 3 8
4 5 3
2 6 1
6 4 3
5 7 3
5 9 8
7 8 5
8 10 5
9 8 8
9 10 3
7 11 3
11 9 1
