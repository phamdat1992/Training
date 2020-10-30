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

  function Change(s: status; ch: char): status;
  var
    l, k: byte;
    d: status;
  begin
    k := pos(ch, 'RLUD');
    d[0] := s[0];
    for l := 1 to 6 do d[l] := s[chtab[l, k]];
    Change := d;
  end;

const
  max = 15;
var
  st: array[1..max*max] of status;
  p: array[1..max*max] of string;
  n, m, err: byte;
  f: text;
  fn: string;
  mautren, kqtren: array[1..max] of string[max];
  mauxq, kqxq: string[4*max];
  h: array[1..max, 1..max] of byte;
  co: boolean;
  tsp: word;   {tong so phep bien doi}

  procedure DocFile;
  var i, j: byte;
  begin
    write('=========== Ten file input: '); readln(fn);
    assign(f, fn); reset(f);
    readln(f, n);
    m := n*n;
    for i := 1 to m do readln(f, st[i]);
    for i := 1 to n do readln(f, mautren[i]);
    readln(f, mauxq);
    readln(f, fn); readln(f, fn);
    co := fn = 'YES';
    close(f);
    writeln(n);
    for i := 1 to m do writeln(st[i]);
    for i := 1 to n do writeln(mautren[i]);
    writeln(mauxq);
    writeln(co,'-',fn);
    write('=========== Ten file output: '); readln(fn);
    assign(f, fn); reset(f);
    readln(f, fn);
    if fn = 'YES' then
    begin
      tsp := 0;
      for i := 1 to m do
      begin
        readln(f, p[i]);
        if p[i] <> '#' then tsp := tsp+length(p[i]);
      end;
      for i := 1 to n do
        for j := 1 to n do read(f, h[i, j]);
    end;
    close(f);
    writeln(fn);
    if fn = 'YES' then
    begin
      for i := 1 to m do writeln(p[i]);
      for i := 1 to n do
      begin
        for j := 1 to n do write(h[i, j]:4);
        writeln;
      end;
    end;
    err := 0;
  end;

  procedure  KiemTraFileOut;
  var i, j: byte;
  begin
    if fn <> 'YES' then
      if co then
      begin
        writeln(#7'Error: Xep duoc!');
        err := 1; exit;
      end else
      begin
        writeln('OK');
        err := 9; exit;
      end;
    for i := 1 to m do
    if p[i][1] <> '#' then
      for j := 1 to length(p[i]) do
      if not (p[i][j] in ['R','L','U','D']) then
      begin
        writeln(#7'Error: dong ', p[i], ' chua ky tu sai!');
        err := 1; exit;
      end;
    for i := 1 to n do
      for j := 1 to n do
      if not (h[i, j] in [1..m]) then
      begin
        writeln(#7'Error: so hieu ', h[i, j], ' sai!');
        err := 1; exit;
      end;
  end;

  procedure TinhKq;
  var i, j, k: byte;
  begin
    {thay doi trang thai}
    for i := 1 to m do
    if p[i][1] <> '#' then
      for j := 1 to length(p[i]) do st[i] := Change(st[i], p[i][j]);
    {Mat tren}
    for i := 1 to n do
    begin
      kqtren[i] := '';
      for j := 1 to n do kqtren[i] := kqtren[i]+st[h[i, j]][5];
    end;
    {Mat xung quanh}
    kqxq := '';
    k := n;
    for i := 1 to n do
      kqxq := kqxq+st[h[k, i]][1];
    for i := n downto 1 do
      kqxq := kqxq+st[h[i, k]][2];
    k := 1;
    for i := n downto 1 do
      kqxq := kqxq+st[h[k, i]][3];
    for i := 1 to n do
      kqxq := kqxq+st[h[i, k]][4];
  end;

  procedure SoSanhMau;
  var i: byte;
  begin
    {so sanh mat tren}
    for i := 1 to n do
    if mautren[i] <> kqtren[i] then
    begin
      writeln(#7'Error: mat tren sai mau!');
      err := 1; exit;
    end;
    if mauxq <> kqxq then
    begin
      writeln(#7'Error: mat xung quanh sai mau!');
      err := 1; exit;
    end;
  end;

BEGIN
  DocFile;
  writeln('=========== Ket qua kiem tra');
  KiemTraFileOut;
  if err = 0 then
  begin
    TinhKq;
    SoSanhMau;
  end;
  if err = 0 then writeln('OK! Tong so phep lat = ', tsp);
  readln;
END.



