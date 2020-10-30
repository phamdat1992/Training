{giai bai toan XEPKHOI bang ghep cap, co toi uu}
uses crt;
type
  status = string[6];
  rows = array[1..4] of byte;
  table = array[1..6] of rows;
const
  chtab: table = ((1, 1, 6, 5),
                  (5, 6, 2, 2),
                  (3, 3, 5, 6),
                  (6, 5, 4, 4),
                  (4, 2, 1, 3),
                  (2, 4, 3, 1));

  function Change(s: status; k: byte): status;
  {k la phep bien doi: 1-R, 2-L, 3-U, 4-D}
  var
    l: byte;
    d: status;
  begin
    d[0] := s[0];
    for l := 1 to 6 do d[l] := s[chtab[l, k]];
    Change := d;
  end;

const
  max = 15;
  max2 = max*max;
type
  ptr = ^node;
  node = record
           s: status;
           p: string[4];
           next: ptr;
         end;
var
  st: array[1..max2] of status;
  n, m: byte;
  head: array[1..max2] of ptr;  {tro dau FIFO}
  first: ptr;
  mattren: array[1..max] of string[max];
  matxq: string[4*max];
  c: array[1..max2, 1..max2] of byte;

  f: text;
  fn: string;
  yes: boolean;

  procedure RandomBlock;
  var i, j, k: byte;
  begin
    m := 0;
    randomize;
    for i := 1 to n do
      for j := 1 to n do
      begin
        inc(m);
        st[m][0] := chr(6);
        for k := 1 to 6 do st[m][k] := chr(65+random(6));
      end;
  end;

  procedure RandomPatt;
  var i, j: byte;
  begin
    randomize;
    {mat tren}
    for i := 1 to n do
    begin
      mattren[i] := '';
      for j := 1 to n do mattren[i] := mattren[i]+chr(65+random(6));
    end;
    {mat xung quanh}
    matxq := '';
    for i := 1 to 4*n do matxq := matxq+chr(65+random(6));
  end;

  procedure ReadFile;
  var i, j: byte;
  begin
    write('=========== Ten file input: '); readln(fn);
    if fn <> '' then
    begin
      assign(f, fn); reset(f);
      readln(f, n);
      m := n*n;
      for i := 1 to m do readln(f, st[i]);
      for i := 1 to n do readln(f, mattren[i]);
      readln(f, matxq);
      close(f);
    end else
    begin
      write('n = '); readln(n);
      RandomBlock; RandomPatt;
    end;
  end;

  function NotIn(var t: status): boolean;
  {kiem tra t khong thuoc FIFO}
  var u: ptr;
  begin
    u := first;
    while (u <> nil) and (u^.s <> t) do u := u^.next;
    NotIn := (u = nil);
  end;

  procedure Creat;
  {tao FIFO trang thai}
  var last, u, v: ptr;
      t: status;
      i, k: byte;     {phep bien doi}
  begin
    for i := 1 to m do
    begin
      new(first);
      first^.s := st[i];
      first^.p := '';
      first^.next := nil;
      last := first;
      u := first;
      repeat
        for k := 1 to 4 do
        begin
          t := Change(u^.s, k);
          if NotIn(t) then
          begin
            new(v);
            v^.s := t;
            v^.p := u^.p+chr(k+48);
            last^.next := v;
            last := v;
            last^.next := nil;
          end;
        end;
        u := u^.next;
      until u = nil;
      head[i] := first;
    end;    {for i}
  end;

  procedure ShowData;
  var i: byte;
  begin
    for i := 1 to m do
      write(i:3, '.', st[i]);
    writeln;
    writeln('Mat tren:');
    for i := 1 to n do writeln(mattren[i]);
    writeln('Mat xung quanh:');
    writeln(matxq);
  end;

  procedure CalC;
  var i, j, k, l: byte;
      t: status;
      u: ptr;
  begin
    fillchar(c, sizeof(c), 255);
    {4 goc}
    {goc 1,1}
    k := 1;
    for l := 1 to m do
    begin
      u := head[l];
      while (u <> nil) do
      begin
        t := u^.s;
        if (t[3] = matxq[3*n]) and (t[4] = matxq[3*n+1]) and
           (t[5] = mattren[1][1]) then
        begin
          c[k, l] := length(u^.p); break;
        end;
        u := u^.next;
      end;
    end;
    {goc 1,n}
    k := n;
    for l := 1 to m do
    begin
      u := head[l];
      while (u <> nil) do
      begin
        t := u^.s;
        if (t[2] = matxq[2*n]) and (t[3] = matxq[2*n+1]) and
           (t[5] = mattren[1][n]) then
        begin
          c[k, l] := length(u^.p); break;
        end;
        u := u^.next;
      end;
    end;
    {goc n,1}
    k := m-n+1;
    for l := 1 to m do
    begin
      u := head[l];
      while (u <> nil) do
      begin
        t := u^.s;
        if (t[1] = matxq[1]) and (t[4] = matxq[4*n]) and
           (t[5] = mattren[n][1]) then
        begin
          c[k, l] := length(u^.p); break;
        end;
        u := u^.next;
      end;
    end;
    {goc n,n}
    k := m;
    for l := 1 to m do
    begin
      u := head[l];
      while (u <> nil) do
      begin
        t := u^.s;
        if (t[1] = matxq[n]) and (t[2] = matxq[n+1]) and
           (t[5] = mattren[n][n]) then
        begin
          c[k, l] := length(u^.p); break;
        end;
        u := u^.next;
      end;
    end;
    {4 duong vien}
    {vien tren}
    for j := 2 to n-1 do
    begin
      k := j;
      for l := 1 to m do
      begin
        u := head[l];
        while (u <> nil) do
        begin
          t := u^.s;
          if (t[3] = matxq[3*n+1-j]) and
             (t[5] = mattren[1][j]) then
          begin
            c[k, l] := length(u^.p); break;
          end;
          u := u^.next;
        end;
      end;
    end;
    {vien duoi}
    for j := 2 to n-1 do
    begin
      k := m-n+j;
      for l := 1 to m do
      begin
        u := head[l];
        while (u <> nil) do
        begin
          t := u^.s;
          if (t[1] = matxq[j]) and
             (t[5] = mattren[n][j]) then
          begin
            c[k, l] := length(u^.p); break;
          end;
          u := u^.next;
        end;
      end;
    end;
    {vien trai}
    for i := 2 to n-1 do
    begin
      k := (i-1)*n+1;
      for l := 1 to m do
      begin
        u := head[l];
        while (u <> nil) do
        begin
          t := u^.s;
          if (t[4] = matxq[3*n+i]) and
             (t[5] = mattren[i][1]) then
          begin
            c[k, l] := length(u^.p); break;
          end;
          u := u^.next;
        end;
      end;
    end;
    {vien phai}
    for i := 2 to n-1 do
    begin
      k := i*n;
      for l := 1 to m do
      begin
        u := head[l];
        while (u <> nil) do
        begin
          t := u^.s;
          if (t[2] = matxq[2*n+1-i]) and
             (t[5] = mattren[i][n]) then
          begin
            c[k, l] := length(u^.p); break;
          end;
          u := u^.next;
        end;
      end;
    end;
    {vung giua}
    for i := 2 to n-1 do
      for j := 2 to n-1 do
      begin
        k := (i-1)*n+j;
        for l := 1 to m do
        begin
          u := head[l];
          while (u <> nil) do
          begin
            t := u^.s;
            if (t[5] = mattren[i][j]) then
            begin
              c[k, l] := length(u^.p); break;
            end;
            u := u^.next;
          end;
        end;
      end;
  end;

var
    px, py: array[1..max2] of integer;  {mo ta cap ghep: px: X --> Y
                                                         py: Y --> X}
  procedure SelBlock;

  var
    u, z: integer;  {u: dinh dau, z: dinh cuoi}
    f, q, queue: array[1..2*max2] of integer; {F[x]: x thuoc X: 1..m,
                                               F[y]: y thuoc Y: m+1..2*m}
  procedure KhoiTao;
  var x, y, xx: integer;
  begin
    {khoi tao F:
      F(x) = min(C[x, y], y thuoc Y), voi moi x thuoc X
      F(y) = 0 voi moi y thuoc Y}
    fillchar(F, sizeof(F), 0);
    for x := 1 to m do
    begin
      xx := C[x, 1];
      for y := 2 to m do if xx > C[x, y] then xx := C[x, y];
      F[x] := xx;
    end;
    fillchar(px, sizeof(px), 0);
    fillchar(py, sizeof(py), 0);
  end;

  function DinhTuDo: byte;
  {tim dinh tu do, neu khong co, tra lai 0}
  var x: integer;
  begin
    for x := 1 to m do
    if px[x] = 0 then
    begin
      DinhTuDo := x; exit;
    end;
    DinhTuDo := 0;
  end;

  procedure TimDuongTangCapGhep;
  {neu tim thay, gan Yes bang True va gui dinh cuoi cua duong di vao z}
  var dau, cuoi, v, w: integer;
  begin
    {xuat phat tu dinh tu do u thuoc X}
    fillchar(q, sizeof(q), 0);
    dau := 1; cuoi := 1; queue[1] := u; q[u] := u;
    while cuoi-dau+1 > 0 do
    begin
      v := queue[dau]; inc(dau);
      if v < m+1 then  {thuoc X}
      begin
        for w := m+1 to 2*m do
        if (f[v]+f[w] = C[v, w-m]) and (q[w] = 0) then
        begin
          inc(cuoi); queue[cuoi] := w; q[w] := v;
        end;
      end else    {thuoc Y}
          if py[v-m] = 0 then  {v la dinh tu do thuoc Y}
          begin
            yes := true; z := v; exit;
          end else
          begin
            w := py[v-m];
            inc(cuoi); queue[cuoi] := w; q[w] := v;
          end;
    end;
    yes := false; z := v;
  end;

  procedure TangCapGhep;
  var x, y: integer;
      thuocY: boolean;
  begin
    {duyet duong tang cap ghep}
    y := z;
    thuocY := true;
    while y <> u do
    begin
      x := q[y];
      if thuocY then
      begin
        px[x] := y-m;
        py[y-m] := x;
      end;
      y := x;
      thuocY := not thuocY;
    end;
  end;

  procedure SuaNhan;
  var min, x, y, d: integer;
  begin
    min := -maxint;
    for x := 1 to m do
    if q[x] > 0 then
      for y := m+1 to 2*m do
      if q[y] = 0 then
      begin
        d := F[x]+F[y]-C[x, y-m];
        if d > min then min := d;
      end;
    for x := 1 to m do
      if q[x] > 0 then F[x] := F[x]-min;
    for y := m+1 to 2*m do
      if q[y] > 0 then F[y] := F[y]+min;
  end;


BEGIN
  KhoiTao;
  u := DinhTuDo;
  while u > 0 do
  begin
    TimDuongTangCapGhep;
    if yes then
    begin
      TangCapGhep; u := DinhTuDo;
    end else SuaNhan;
  end;
END;

  function XepDuoc: boolean;
  var x: byte;
  begin
    for x := 1 to m do
    if C[x, px[x]] = 255 then
    begin
      XepDuoc := false; exit;
    end;
    XepDuoc := true;
  end;

  procedure Result;
  var x, y, k: byte;
      t: status;
      u: ptr;
      pp: array[1..max2] of string[4];
      bd: string[4];
  begin
    yes := XepDuoc;
    if yes then writeln(' --> xep duoc')
    else writeln(' --> khong xep duoc');
    if fn = '' then
    begin
      write('Ghi input len file: '); readln(fn);
      assign(f, fn); rewrite(f);
      writeln(f, n);
      for x := 1 to m do writeln(f, st[x]);
      for x := 1 to n do writeln(f, mattren[x]);
      writeln(f, matxq);
      writeln(f);
      if yes then writeln(f, 'YES') else writeln(f, 'NO');
      close(f);
    end;
    write('Ghi ket qua ra file: '); readln(fn);
    assign(f, fn); rewrite(f);
    if not yes then  writeln(f, 'NO')
    else
    begin
      writeln(f, 'YES');
      {4 goc}
      {goc 1,1}
      k := px[1];
      u := head[k];
      while (u <> nil) do
      begin
        t := u^.s;
        if (t[3] = matxq[3*n]) and (t[4] = matxq[3*n+1]) and
           (t[5] = mattren[1][1]) then
        begin
          pp[k] := u^.p; break;
        end;
        u := u^.next;
      end;
      {goc 1,n}
      k := px[n];
      u := head[k];
      while (u <> nil) do
      begin
        t := u^.s;
        if (t[2] = matxq[2*n]) and (t[3] = matxq[2*n+1]) and
           (t[5] = mattren[1][n]) then
        begin
          pp[k] := u^.p; break;
        end;
        u := u^.next;
      end;
      {goc n,1}
      k := px[m-n+1];
      u := head[k];
      while (u <> nil) do
      begin
        t := u^.s;
        if (t[1] = matxq[1]) and (t[4] = matxq[4*n]) and
           (t[5] = mattren[n][1]) then
        begin
          pp[k] := u^.p; break;
        end;
        u := u^.next;
      end;
      {goc n,n}
      k := px[m];
      u := head[k];
      while (u <> nil) do
      begin
        t := u^.s;
        if (t[1] = matxq[n]) and (t[2] = matxq[n+1]) and
           (t[5] = mattren[n][n]) then
        begin
          pp[k] := u^.p; break;
        end;
        u := u^.next;
      end;
      {4 duong vien}
      {vien tren}
      for y := 2 to n-1 do
      begin
        k := px[y];
        u := head[k];
        while (u <> nil) do
        begin
          t := u^.s;
          if (t[3] = matxq[3*n+1-y]) and
             (t[5] = mattren[1][y]) then
          begin
            pp[k] := u^.p; break;
          end;
          u := u^.next;
        end;
      end;
      {vien duoi}
      for y := 2 to n-1 do
      begin
        k := px[m-n+y];
        u := head[k];
        while (u <> nil) do
        begin
          t := u^.s;
          if (t[1] = matxq[y]) and
             (t[5] = mattren[n][y]) then
          begin
            pp[k] := u^.p; break;
          end;
          u := u^.next;
        end;
      end;
      {vien trai}
      for x := 2 to n-1 do
      begin
        k := px[(x-1)*n+1];
        u := head[k];
        while (u <> nil) do
        begin
          t := u^.s;
          if (t[4] = matxq[3*n+x]) and
             (t[5] = mattren[x][1]) then
          begin
            pp[k] := u^.p; break;
          end;
          u := u^.next;
        end;
      end;
      {vien phai}
      for x := 2 to n-1 do
      begin
        k := px[x*n];
        u := head[k];
        while (u <> nil) do
        begin
          t := u^.s;
          if (t[2] = matxq[2*n+1-x]) and
             (t[5] = mattren[x][n]) then
          begin
            pp[k] := u^.p; break;
          end;
          u := u^.next;
        end;
      end;
      {vung giua}
      for x := 2 to n-1 do
        for y := 2 to n-1 do
        begin
          k := px[(x-1)*n+y];
          u := head[k];
          while (u <> nil) do
          begin
            t := u^.s;
            if (t[5] = mattren[x][y]) then
            begin
              pp[k] := u^.p; break;
            end;
            u := u^.next;
          end;
        end;
      bd := 'RLUD';
      for k := 1 to m do
      begin
        if pp[k] = '' then pp[k] := '#'
        else
          for y := 1 to length(pp[k]) do
            pp[k][y] := bd[ord(pp[k][y])-48];
        writeln(f, pp[k]);
      end;
      k := 0;
      for x := 1 to n do
      begin
        for y := 1 to n do
        begin
          inc(k); write(f, px[k]:4);
        end;
        writeln(f);
      end;
    end;
    close(f);
  end;

BEGIN
  ReadFile;
  ShowData;
  Creat;
  CalC;
  SelBlock;
  Result;
END.
