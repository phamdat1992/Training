{giai bai toan phuc vu doi tien
 nm: so may; nk: so khach}
uses crt;
const
  max = 100;
type
  trongso = array[1..max, 1..max] of integer;
  arr1 = array[1..max] of integer;
  arr2 = array[1..2*max] of integer;
var
  c: trongso;
  n, u, z, nm, nk: integer;   {u: dinh dau, z: dinh cuoi}
  px, py: arr1;       {mo ta cap ghep: px: X --> Y
                                       py: Y --> X}
  f, q: arr2;         {F[x]: x thuoc X: 1..n,
                       F[y]: y thuoc Y: n+1..2*n}
  tdapan: integer;

  procedure Nhap;
  var
    ft: text;
    finp: string;
    i, j : integer;
    may: array[1..max] of string[26];
    khach: string[max];

  begin
    clrscr;
    fillchar(C, sizeof(C), 0);
    write('Doc du lieu tu file: '); readln(finp);
    assign(ft, finp); reset(ft);
    readln(ft, nm, nk);
    for i:=1 to nm do readln(ft, may[i]);
    readln(ft, khach);
    close(ft);
    writeln('So may: ', nm); writeln('So khach: ', nk);
    for i := 1 to nk do
      for j := 1 to nm do
      if pos(khach[i], may[j]) > 0 then C[i, j] := 1;
    n := nm;
    if n < nk then n := nk;
  end;

  procedure KhoiTao;
  var x, y, xx: integer;
  begin
    {khoi tao F:
      F(x) = max(C[x, y], y thuoc Y), voi moi x thuoc X
      F(y) = 0 voi moi y thuoc Y}
    fillchar(F, sizeof(F), 0);
    for x := 1 to n do
    begin
      xx := C[x, 1];
      for y := 2 to n do if xx < C[x, y] then xx := C[x, y];
      F[x] := xx;
    end;
    {khoi tao cap ghep rong}
    fillchar(px, sizeof(px), 0);
    fillchar(py, sizeof(py), 0);
  end;

  function TimThayDinhTuDo: boolean;
  {tra lai TRUE neu tim thay va gui dinh tu do vao u}
  var x: integer;
  begin
    for x := 1 to n do
    if px[x] = 0 then
    begin
      u := x; TimThayDinhTuDo := true; exit;
    end;
    TimThayDinhTuDo := false;
  end;

  function TimThayDuongTangCapGhep: boolean;
  {tra lai TRUE neu tim thay va gui dinh cuoi cua duong di vao z}
  var dau, cuoi, v, w: integer;
      queue: arr2;
  begin
    {xuat phat tu dinh tu do u thuoc X}
    fillchar(q, sizeof(q), 0);
    dau := 1; cuoi := 1; queue[1] := u; q[u] := u;
    while cuoi-dau+1 > 0 do
    begin
      v := queue[dau]; inc(dau);
      if v < n+1 then  {thuoc X}
      begin
        for w := n+1 to 2*n do
        if (f[v]+f[w] = C[v, w-n]) and (q[w] = 0) then
        begin
          inc(cuoi); queue[cuoi] := w; q[w] := v;
        end;
      end else    {thuoc Y}
          if py[v-n] = 0 then  {v la dinh tu do thuoc Y}
          begin
            TimThayDuongTangCapGhep := true; z := v; exit;
          end else
          begin
            w := py[v-n];
            inc(cuoi); queue[cuoi] := w; q[w] := v;
          end;
    end;
    TimThayDuongTangCapGhep := false;
  end;

  procedure TangCapGhep;
  var x, y: integer;
      thuocY: boolean;
  begin
    {dieu chinh cap ghep tren duong tang cap ghep}
    y := z; thuocY := true;
    while y <> u do
    begin
      x := q[y];
      if thuocY then
      begin
        px[x] := y-n;
        py[y-n] := x;
      end;
      y := x;
      thuocY := not thuocY;
    end;
  end;

  procedure SuaNhan;
  var x, y, d, h: integer;
  begin
    {tim luong sua nhan}
    d := maxint;
    for x := 1 to n do
    if q[x] > 0 then
      for y := n+1 to 2*n do
      if q[y] = 0 then
      begin
        h := F[x]+F[y]-C[x, y-n];
        if h < d then d := h;
      end;
    {sua nhan}
    for x := 1 to n do
      if q[x] > 0 then F[x] := F[x]-d;
    for y := n+1 to 2*n do
      if q[y] > 0 then F[y] := F[y]+d;
  end;

  procedure DapAn;
  var x: integer;
  begin
    writeln('============= Dap an ==============');
    write('Phuong an phuc vu: ');
    for x := 1 to nk do
      if C[x, px[x]] = 1 then write(px[x]:4) else write(0:4);
    writeln;
    tdapan := 0;
    for x := 1 to n do tdapan := tdapan+C[x, px[x]];
    writeln('So khach duoc phuc vu: ', tdapan);
  end;

  procedure KiemTra;
  var
    ft: text;
    fout: string;
    t, tkq, x, i, j: integer;
    err: boolean;
  begin
    writeln('============= KiemTra ==============');
    fillchar(px, sizeof(px), 0);
    fillchar(py, sizeof(py), 0);
    err := false;
    write('Ten file ket qua: '); readln(fout);
    assign(ft, fout); reset(ft);
    readln(ft, tkq);
    writeln(tkq);
    t := 0;
    for x := 1 to tkq do
    begin
      readln(ft, i, j);
      write('   ', i:3, '-', j:3);
      if px[i] = 0 then px[i] := j else
      begin
        writeln;
        writeln('Error: khach ', i, ' da duoc phuc vu!');
        err := true;
      end;
      if py[j] = 0 then py[j] := i else
      begin
        writeln;
        writeln('Error: may ', j, ' da phuc vu!');
        err := true;
      end;
      if C[i, j] = 1 then inc(t) else
      begin
        writeln;
        writeln('Error: may ', j, ' khong phuc vu duoc khach ', i, '!');
        err := true;
      end;
    end;
    writeln;
    if t <> tkq then
    begin
      writeln('Error: So khach duoc phuc vu khong dung (', t, ')!');
      err := true;
    end;
    if tkq < tdapan then
    begin
      writeln('Error: So khach duoc phuc vu chua toi uu!');
      err := true;
    end;
    if not err then
    writeln('OK');
    readln;
  end;

BEGIN
  Nhap; KhoiTao;
  while TimThayDinhTuDo do
  begin
    while not TimThayDuongTangCapGhep do SuaNhan;
    TangCapGhep;
  end;
  DapAn;
  KiemTra;
END.
