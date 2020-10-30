{sinh du lieu cho bai XEPHINH-co nghiem}
const
  max = 50;
  max2 = max*max;
var
  a: array[1..max, 1..max] of byte;
  aa: array[1..max, 1..max] of integer;
  m, n: integer;
  p, q: array[1..max2] of integer;

  function Rot(r, b: byte): byte;
  var i, b1, b2: byte;
  begin
    for i := 1 to r do
    begin
      b1 := b shr 2;
      b2 := byte(b shl 6);
      b := b1 or b2;
    end;
    Rot := b;
  end;

  procedure RandP;
  var i, j, nn, np: integer;
  begin
    nn := m*n; np := 0;
    for i := 1 to nn do q[i] := i;
    while nn > 0 do
    begin
      j := 1+random(nn);
      inc(np);
      p[np] := q[j];
      q[j] := q[nn];
      dec(nn);
    end;
  end;

  procedure FindRowCol(k: integer; var row, col: integer);
  begin
    row := (k-1) div n + 1;
    col := (k-1) mod n + 1;
  end;

  procedure GenPat;
  var i, j: integer;
  begin
    randomize;
    write('So dong: '); readln(m);
    write('So cot: '); readln(n);
    for i := 1 to m do
      for j := 1 to n do a[i, j] := random(256);
  end;

  procedure WriteFile;
  var f, g: text;
      nf, ng: string;
      i, j, row, col: integer;
      rr: array[1..max, 1..max] of byte;
      r: byte;
  begin
    write('Ghi data len file: '); readln(nf);
    assign(f, nf); rewrite(f);
    writeln(f, m, ' ', n);
    for i := 1 to m*n do
    begin
      j := p[i];
      FindRowCol(j, row, col);
      r := random(4);
      write(f, Rot(r, a[row, col]):4);
      aa[row, col] := i;
      rr[row, col] := (4-r) mod 4;
    end;
    writeln(f);
    for i := 1 to m do
    begin
      for j := 1 to n do write(f, a[i, j]:4);
      writeln(f);
    end;
    close(f);
    write('Ghi ket qua len file: '); readln(ng);
    assign(g, ng); rewrite(g);
    for i := 1 to m do
    begin
      for j := 1 to n do write(g, aa[i, j]:6);
      writeln(g);
    end;
    for i := 1 to m do
    begin
      for j := 1 to n do write(g, rr[i, j]:3);
      writeln(g);
    end;
    close(g);
  end;

BEGIN
  GenPat;
  RandP;
  WriteFile;
END.


